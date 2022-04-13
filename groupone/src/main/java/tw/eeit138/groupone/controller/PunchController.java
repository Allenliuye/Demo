package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.opencsv.CSVWriter;
import com.opencsv.bean.ColumnPositionMappingStrategy;
import com.opencsv.bean.StatefulBeanToCsv;
import com.opencsv.bean.StatefulBeanToCsvBuilder;
import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;

import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.PunchBean;
import tw.eeit138.groupone.service.BackendSystemService;
import tw.eeit138.groupone.service.PunchService;
import tw.eeit138.groupone.util.SHA256Utils;

@Controller
public class PunchController {
	
	@Autowired
	private BackendSystemService service;
	
	@Autowired
	private PunchService punchService;
	
	@Autowired
	private SHA256Utils shaUtils;
	
	//員工找打卡紀錄
	@GetMapping("/getPersonalPunchData")
	public ModelAndView getPersonalPunchData(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		Integer empId = admin.getEmpId();
		List<PunchBean> punchBean = punchService.empFindAllPunchData(empId);
		mav.getModel().put("puns", punchBean);
		mav.setViewName("backendsystem/GetPersonalPunchData");
		return mav;
	}
	
	//管理員找所有員工打卡紀錄
	@GetMapping("/getEmpPunchData")
	public ModelAndView getEmpPunchData(ModelAndView mav) {
		List<EmployeeBean> empBean = service.selectAllEmployee();
		mav.getModel().put("emps", empBean);
		
		
		List<PunchBean> punchBean = punchService.selectAllEmpsPunchDate();
		mav.getModel().put("puns", punchBean);
		mav.setViewName("backendsystem/GetAllEmpsPunchData");
		return mav;
	}
	
	//打卡
	@ResponseBody
	@PostMapping("/api/punch")
	public PunchBean punch(HttpServletRequest request) {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		Integer empId = admin.getEmpId();
		return punchService.empPunchDay(empId);
	}
	
	//掃描打卡並登入首頁
//	@GetMapping("/qrpunch")
//	public ModelAndView qrPunch(ModelAndView mav,Integer empId,String password, HttpSession session) {
//		EmployeeBean emp = service.findById(empId);
//		System.out.println("emp:"+emp);
//		System.out.println("empId:"+empId);
//		System.out.println("password:"+password);
//		String salt = "eeit138_" + emp.getBoardDate() + "_07_" + password + emp.getId();
//		String pass = shaUtils.getSHA256StrJava(salt);
//		System.out.println("pass:"+pass);
//		System.out.println("emp.getPassword():"+emp.getPassword());
//		if (pass.equals(emp.getPassword())) {
//			session.setAttribute("admin", emp);
//		}
//		punchService.empPunchDay(empId);
//		mav.setViewName("redirect:/frontPage");
//		return mav;
//	}
	
	//掃描打卡並登入首頁
	@GetMapping("/qrpunch")
	public ModelAndView qrPunch(ModelAndView mav,Integer x, String c, HttpSession session) {
		EmployeeBean emp = service.findById((x));
		if (c.equals(emp.getPassword()) && 2 == emp.getFkStateId().getId()) {
			session.setAttribute("admin", emp);
		}
		punchService.empPunchDay(x);
		mav.setViewName("redirect:/frontPage");
		return mav;
	}
	
	//報表
	@ResponseBody
	@GetMapping("/api/punchToCSV")
	public void punchToCSV(HttpServletRequest request,HttpServletResponse response) throws IOException, CsvDataTypeMismatchException, CsvRequiredFieldEmptyException {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		Integer empId = admin.getEmpId();
		
		// set file name and content type
		String filename = empId + "_punch.csv";
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=\"" + filename + "\"");
        
        //指定報表欄位順序
	    ColumnPositionMappingStrategy mapStrategy = new ColumnPositionMappingStrategy();
	    mapStrategy.setType(PunchBean.class);
	        
	    String[] columns = new String[]{"id", "empId", "punchYear","punchMonth","punchDate","onWorkTime","offWorkTime"};
	    mapStrategy.setColumnMapping(columns);
        
        // create a csv writer
        StatefulBeanToCsv<PunchBean> writer = 
                       new StatefulBeanToCsvBuilder <PunchBean>(response.getWriter()).withQuotechar(CSVWriter.NO_QUOTE_CHARACTER).
                       withSeparator(CSVWriter.DEFAULT_SEPARATOR).withMappingStrategy(mapStrategy).withOrderedResults(true).build();
        
        // write all employees to csv file
        List<PunchBean> punchBean = punchService.empFindAllPunchDataOrderBy(empId);
        writer.write(punchBean);
	}
	
	//管理員產員工報表
	@ResponseBody
	@GetMapping("/api/getEmpPunchToCsv")
	public void getEmpPunch(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "year") String year,@RequestParam(value = "month") String month,HttpServletResponse response
			) throws IOException, CsvDataTypeMismatchException, CsvRequiredFieldEmptyException {

		String filename = empId + "_" + year + "-" + month + "_punch.csv";
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=\"" + filename + "\"");
        
        StatefulBeanToCsv<PunchBean> writer = 
                new StatefulBeanToCsvBuilder <PunchBean>(response.getWriter()).withQuotechar(CSVWriter.NO_QUOTE_CHARACTER).
                withSeparator(CSVWriter.DEFAULT_SEPARATOR).withOrderedResults(true).build();
        
        List<PunchBean> punchBean = punchService.getEmpPunch(empId, year, month);
        writer.write(punchBean);

	}
	
	
	//打卡記錄圓餅圖頁面
	@GetMapping("/getEmpPunchFlot")
	public ModelAndView flotPage(ModelAndView mav) {
		List<EmployeeBean> empBean = service.selectAllEmployee();
		mav.getModel().put("emps", empBean);
		mav.setViewName("backendsystem/FlotPage");
		return mav ;
	}
	
	//統計遲到準時次數
	@ResponseBody
	@GetMapping("/api/getEmpPunchFlot")
	public HashMap<String, Integer> getEmpPunchFlot(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "year") String year,@RequestParam(value = "month") String month,HttpServletResponse response) {
		Integer lateCount = punchService.getEmpPunchLate(empId, year, month); // 遲到
		Integer onTimeCount = punchService.getEmpPunchOnTime(empId, year, month); //準時
		HashMap<String, Integer> map = new HashMap<String,Integer>();
		map.put("late", lateCount);
		map.put("onTime", onTimeCount);
		return map;
	}
	
	//下載QRcode圖片
//	@ResponseBody
	@GetMapping("/api/dowQRcode")
	public void dowQRcode(HttpServletRequest request,HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		Integer empId = admin.getEmpId();
		
		// set file name and content type
		String fileName = empId + "_QR.jpg";
        response.setContentType("image/jpeg");
        //通知瀏覽器以下載的方式開啟
        response.addHeader("Content-Type","application/octet-stream");
        response.addHeader("Content-Disposition","attachment;filename="+fileName);
        //通過檔案輸入流讀取檔案
		File file = new File("");
		String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empId + "\\" + empId + "_QR.jpg";
        InputStream in=new FileInputStream(path);
        //通過檔案輸出流寫入檔案
        OutputStream out=response.getOutputStream();
        byte[] bytes=new byte[1024];
        int len=0;
        //迴圈將寫入流
        while ((len=in.read(bytes))!=-1){
            out.write(bytes,0,len);
        }
        // 關閉資源
        out.flush();
        out.close();
	}
}
