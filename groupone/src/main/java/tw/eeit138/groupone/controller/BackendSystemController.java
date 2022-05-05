package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.zxing.EncodeHintType;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.StateBean;
import tw.eeit138.groupone.model.TitleBean;
import tw.eeit138.groupone.service.BackendSystemService;
import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.util.QRCodeTool;
import tw.eeit138.groupone.util.SHA256Utils;

@Controller
@MultipartConfig
public class BackendSystemController {

	@Autowired
	private BackendSystemService service;

	@Autowired
	private MailService mailService;


	// 登入驗證
	@ResponseBody
	@PostMapping("/api/getEmployee")
	public EmployeeBean getEmployeeApi(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "password") String password, HttpSession session) {
		EmployeeBean emp = service.findById(empId);
		if (emp.getId() != null) {
			String salt = "eeit138_" + emp.getBoardDate() + "_07_" + password + emp.getId();
			String pass = SHA256Utils.getSHA256StrJava(salt);

			if (pass.equals(emp.getPassword())) {
				session.setAttribute("admin", emp);
				return emp;
			}
			return new EmployeeBean();
		}
		return new EmployeeBean();
	}
	

	// 自己找基本資料
	@GetMapping("/getPersonalInformation")
	public ModelAndView getPersonalInformation(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		int empId = admin.getEmpId();
		EmployeeBean employeeBean = service.findById(empId);
		mav.getModel().put("emp", employeeBean);
		mav.setViewName("backendsystem/GetPersonalInformation");
		return mav;
	}

	// 自己找要修改基本資料頁面
	@GetMapping("/getUpdatePersonalInformation")
	public ModelAndView getUpdatePersonal(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession();
		EmployeeBean admin = (EmployeeBean) session.getAttribute("admin");
		int empId = admin.getEmpId();
		EmployeeBean employeeBean = service.findById(empId);
		mav.getModel().put("emp", employeeBean);
		mav.setViewName("backendsystem/UpdatePersonalInformationDate");

		return mav;
	}

	// 自己修改基本資料
	@PostMapping("/updatePersonalInformation")
	public ModelAndView updatePersonalInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "orphoto") String orphoto, @RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "username") String username, @RequestParam(value = "birthday") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email) throws IOException, ServletException {
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			File file = new File("");
			String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empId + "\\";
			String filename = empId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empId + "\\" + empId + ".jpg";
		} else {
			photo = orphoto;
		}

		EmployeeBean employeeBean = service.empUpdateInformation(empId, photo, username, birthday, fkDepartmentDeptno,
				fkTitleId, sex, superiorName, id, phone, highEdu, highLevel, highMajor, emergencyContact,
				contactRelationship, contactPhone, address, email);

		mav.getModel().put("emp", employeeBean);

		mav.setViewName("redirect:/getPersonalInformation");
		return mav;
	}

	// 管理員找所有員工資訊
	@GetMapping("/getAllEmpsInforation")
	public ModelAndView getAllEmployee(ModelAndView mav) {
		List<EmployeeBean> employeeBeans = service.selectAllEmployee();
		mav.getModel().put("emps", employeeBeans);
		mav.setViewName("backendsystem/GetAllEmpsInfornation");
		return mav;
	}

	// 管理員找員工基本資料
	@GetMapping("/getEmpUpdateInformation")
	public ModelAndView getEmpUpdatePersonal(ModelAndView mav, @RequestParam(value = "empId") Integer empId) {
		EmployeeBean employeeBean = service.findById(empId);
		mav.getModel().put("emp", employeeBean);

		List<DepartmentBean> dpartmentBean = service.selectAllDname();
		mav.getModel().put("dNames", dpartmentBean);

		List<TitleBean> titleBean = service.selectAllTitName();
		mav.getModel().put("tNames", titleBean);

		List<StateBean> stateBean = service.selectAllStateName();
		mav.getModel().put("sNames", stateBean);

		mav.setViewName("backendsystem/UpdateEmpInformationDate");
		return mav;
	}

	// 管理員刪除員工資訊
	@GetMapping("deleteEmp")
	public ModelAndView deleteEmp(ModelAndView mav, Integer empId) {
		service.deleteEmp(empId);
		mav.setViewName("redirect:/getAllEmpsInforation");
		return mav;
	}

	// 修改密碼：驗證舊密碼及新
	@PostMapping("/checkPass")
	public ModelAndView ckeckPass(ModelAndView mav, @RequestParam(value = "oldPass") String oldPass,
			@RequestParam(value = "empId") Integer empId, @RequestParam(value = "newPass_01") String newPass_01,
			@RequestParam(value = "newPass_02") String newPass_02) {

		EmployeeBean emp = service.findById(empId);

		return mav;
	}

	// 管理員更新員工資料
	@PostMapping("/updateEmpInformation")
	public ModelAndView updateEmpInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "orphoto") String orphoto, @RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "username") String username, @RequestParam(value = "birthday") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email, @RequestParam(value = "fkStateId") String fkStateId)
			throws IOException, ServletException {
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			File file = new File("");
			String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empId + "\\";
			String filename = empId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empId + "\\" + empId + ".jpg";
		} else {
			photo = orphoto;
		}

		EmployeeBean employeeBean = service.adminUpdateEmpInformation(empId, photo, username, birthday,
				fkDepartmentDeptno, fkTitleId, sex, superiorName, id, phone, highEdu, highLevel, highMajor,
				emergencyContact, contactRelationship, contactPhone, address, email, fkStateId);

		mav.getModel().put("emp", employeeBean);

		mav.setViewName("redirect:/getAllEmpsInforation");
		return mav;
	}

	// 管理員新增員工資料
	@PostMapping("/addEmpInformation")
	public ModelAndView addEmpInformation(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "fkDepartmentDeptn") String fkDepartmentDeptno,
			@RequestParam(value = "fkTitleId") String fkTitleId, @RequestParam(value = "contact") String sex,
			@RequestParam(value = "username") String username, @RequestParam(value = "date") String birthday,
			@RequestParam(value = "superiorName") String superiorName, @RequestParam(value = "id") String id,
			@RequestParam(value = "phone") String phone, @RequestParam(value = "highEdu") String highEdu,
			@RequestParam(value = "highLevel") String highLevel, @RequestParam(value = "highMajor") String highMajor,
			@RequestParam(value = "emergencyContact") String emergencyContact,
			@RequestParam(value = "contactRelationship") String contactRelationship,
			@RequestParam(value = "contactPhone") String contactPhone, @RequestParam(value = "address") String address,
			@RequestParam(value = "email") String email) throws Exception {
		Date date = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		String bDate = ft.format(date);

		EmployeeBean emp = new EmployeeBean();
		DepartmentBean dep = new DepartmentBean();
		TitleBean tit = new TitleBean();
		StateBean stat = new StateBean();
		
		

		emp.setUsername(username);
		dep.setDeptno(Integer.valueOf(fkDepartmentDeptno));
		emp.setFkDeptno(dep);
		tit.setTitleId(Integer.valueOf(fkTitleId));
		emp.setFkTitleId(tit);
		emp.setSuperiorName(superiorName);
		emp.setBirthday(birthday);
		emp.setPhone(phone);
		emp.setHighEdu(highEdu);
		emp.setHighLevel(highLevel);
		emp.setHighMajor(highMajor);
		emp.setEmail(email);
		emp.setAddress(address);
		emp.setBoardDate(bDate);
		emp.setEmergencyContact(emergencyContact);
		emp.setContactPhone(contactPhone);
		emp.setContactRelationship(contactRelationship);
		stat.setId(1);
		String idUpper = id.toUpperCase();
		emp.setId(idUpper);
		// 密碼使用SHA256及自己設定的"鹽"來加密
		String salt = "eeit138_" + bDate + "_07_" + idUpper + idUpper;
		String password = SHA256Utils.getSHA256StrJava(salt);
		emp.setPassword(password);
		emp.setSex(sex);
		service.addEmpInformation(emp);
		
		
		List<EmployeeBean> AllEmp = service.findAll();
		EmployeeBean empAll = AllEmp.get(AllEmp.size()-1);
		System.out.println("empAll.getEmpId():"+empAll.getEmpId());
		Integer empLastEmpId = empAll.getEmpId();
		EmployeeBean empLast = service.findById(empLastEmpId);


		File file = new File("");
		String path = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empLastEmpId + "\\";
		File folder = new File(path);
		if (!folder.exists()) {
			folder.mkdir(); // create folder
		}
		Part part = request.getPart("photo");
		long dataname = part.getSize();
		String photo = null;
		if (dataname != 0) {
			String path1 = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empLastEmpId + "\\";
			String filename = empLastEmpId + ".jpg";
			InputStream in = part.getInputStream();
			OutputStream out = new FileOutputStream(path1 + filename);
			byte[] buf = new byte[256];
			while (in.read(buf) != -1) {
				out.write(buf);
			}
			in.close();
			out.close();
			photo = empLastEmpId + "/" + empLastEmpId + ".jpg";
		} else {
			photo = "Nopic/No-picture.png";
		}
		
		//QR code 內容
		String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" + empLastEmpId + "&c=" + password;
		System.out.println("qrCodeData:"+qrCodeData);
		// QR code寫入位置
		String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empLastEmpId + "\\" + empLastEmpId + "_QR.jpg";
		// 字元編碼
		String charset = "UTF-8"; // "ISO-8859-1"
		Map hintMap = new HashMap();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400,400);
		//QR code照片路徑寫入資料庫
		String Qrcode = empLastEmpId + "/" + empLastEmpId + "_QR.jpg";
		
		
		empLast.setQrcode(Qrcode);
		empLast.setPhoto(photo);
		
		
		service.addEmpInformation(empLast);
		mailService.sendAccountOpeningEmail(empLast);
		mav.setViewName("redirect:/getAllEmpsInforation");

		return mav;
	}

	// ajax改變主管名稱
	@ResponseBody
	@GetMapping("/api/getSupervisor")
	public List<EmployeeBean> getSupervisorApi(@RequestParam(value = "empId") Integer empId,
			@RequestParam(value = "departId") String departId, @RequestParam(value = "titleId") String titleId) {

		List<EmployeeBean> superiorNames = service.selectSuperiorName(empId, departId, titleId);
		System.out.println("superiorNames.size():" + superiorNames.size());
		if (superiorNames.size() == 0) {
			Integer adminEmpId = 1000;
			String adminDepartId = "400";
			String adminTitleId = "30";
			List<EmployeeBean> adminNames = service.selectSuperiorName(adminEmpId, adminDepartId, adminTitleId);
			return adminNames;
		} else {
			return superiorNames;
		}

	}

}
