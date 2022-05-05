package tw.eeit138.groupone.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.TitleBean;
import tw.eeit138.groupone.service.BackendSystemService;
import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.util.QRCodeTool;
import tw.eeit138.groupone.util.SHA256Utils;

@Controller
public class PageController {
	
	@Autowired
	private BackendSystemService service;
	
	@Autowired
	private MailService mailService;
	

	
	//登入頁面
	@GetMapping("/loginPage")
	public String home() {
		return "backendsystem/LoginPage";
	}
	
	@GetMapping("/frontPage")
	public String frontPage() {
		return "backendsystem/FrontPage";
	}
	
	@GetMapping("/forgotPasswordPage")
	public String forgotPasswordPage() {
		return "backendsystem/ForgotPassword";
	}
	
	
	
	//修改密碼頁面
	@GetMapping("/changePassword")
	public ModelAndView changePassword(ModelAndView mav,@RequestParam(value = "empId") Integer empId) {
		EmployeeBean emp = service.findById(empId);
		mav.getModel().put("emp", emp);
		mav.setViewName("backendsystem/ChangePassword");
		return mav;
	}
	
	//管理員家新增員工頁面
	@GetMapping("/addEmp")
	public ModelAndView addEmp(ModelAndView mav) {
		List<DepartmentBean> dpartmentBean = service.selectAllDname();
		mav.getModel().put("dNames", dpartmentBean);
		
		List<TitleBean> titleBean = service.selectAllTitName();
		mav.getModelMap().put("tNames", titleBean);
		mav.setViewName("backendsystem/AddEmp");
		
		return mav;
	}

	//重新設定密碼頁面
	@GetMapping("/resetPassword")
	public ModelAndView resetPassword(ModelAndView mav,
			@RequestParam(value = "empId") Integer empId,
			@RequestParam String idCode) {
		EmployeeBean emp = service.checkIdCode(empId, idCode);
		
		if(emp.getId() == null) {
			mav.setViewName("redirect:/loginPage");
		}else {
			mav.getModel().put("emp", emp);
		mav.setViewName("backendsystem/ResetPassword");
		}
		
		return mav;
	}
	
	//驗證頁面
	@GetMapping("/accountOpening")
	public ModelAndView accountOpening(ModelAndView mav,
			@RequestParam(value = "empId") Integer empId,
			@RequestParam String idCode) {
		EmployeeBean emp = service.checkIdCode(empId, idCode);
		
		if(emp.getId() == null) {
			mav.setViewName("redirect:/loginPage");
		}else {
			service.updateStateId(empId, "2");
			mav.getModel().put("emp", emp);
			mav.setViewName("backendsystem/AccountOpening");
		}
		
		return mav;
	}
	
	//管理者找員工 查詢、新增、刪除等功能頁面
	@GetMapping("/employeeDataProcessing")
	public String employeeDataProcessing() {
		return "backendsystem/EmployeeDataProcessing";
	}
	
	//登出頁面
	@GetMapping("/singOut")
	public String singOut(HttpSession httpSession) {
		httpSession.removeAttribute("admin");
		return "backendsystem/SingOut";
	}
	
	//忘記密碼時用email來驗證
	@PostMapping("/forgotpwd")
	public ModelAndView forgotPwd(ModelAndView mav,@RequestParam String empEmail,HttpSession httpSession ) {
		EmployeeBean empBean = service.findEmpEmail(empEmail);
		if(empBean == null) {
			mav.getModel().put("errorMsg", empEmail + ",不存在!");
			mav.setViewName("backendsystem/ForgotPassword");
		}else {
			try {
				mailService.sendResetPasswordEmail(empBean,httpSession);
				mav.getModel().put("sendMailMsg", "您的申請提交成功，請查看您的" + empEmail + "信箱");
				mav.setViewName("backendsystem/SendMail");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return mav;
	}
	
	
	//驗證密碼欄位並更新密碼
	@PostMapping("/checkNewPassword")
	public ModelAndView checkNewPassword(ModelAndView mav,HttpSession httpSession,HttpServletRequest request,RedirectAttributes redirectAttributes,
			@RequestParam Integer empId,
			@RequestParam String idCode,
			@RequestParam(value = "newPassword") String newPassword,
			@RequestParam String newPassword2,
			@RequestParam String checkCode) throws WriterException, IOException {
		
		HashMap<String,String> errors = new HashMap<String,String>();
		if(newPassword == null || "".equals(newPassword)) {
			errors.put("newPassword", "新密碼不能為空白!");
		}
		
		if(newPassword2 == null || "".equals(newPassword2)) {
			errors.put("newPassword2", "確認新密碼不能為空白!");
		}
		
		if(!newPassword.equals(newPassword2)) {
			errors.put("passwordError", "兩次輸入密碼不一致!");
		}
		
		String httpSessionCode = (String)httpSession.getAttribute("sessionCode");
		System.out.println("httpSessionCode:" + httpSessionCode);
		if(!checkCode.equals(httpSessionCode)) {
			errors.put("codeError", "驗證碼錯誤!");
		}
		
		System.out.println(errors);
		
		if(!errors.isEmpty()){
			redirectAttributes.addFlashAttribute("errors", errors);
			mav.setViewName("redirect:/resetPassword?empId=" + empId + "&"+"idCode=" + idCode);
			return mav;
		}
		
		System.out.println("newPassword:" + newPassword);
		System.out.println("newPassword2:" + newPassword2);
		System.out.println("checkCode:" + checkCode);
		
		EmployeeBean empBean = service.findById(empId);
		
		//新密碼加鹽寫入資料庫
		String newSalt = "eeit138_" + empBean.getBoardDate() + "_07_" + newPassword2 + empBean.getId();
		String newPassSHA256 = SHA256Utils.getSHA256StrJava(newSalt);
		service.updatePass(empId, newPassSHA256);
		
		//QR code 內容
		String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" +  empBean.getEmpId() + "&c=" + newPassSHA256;
		System.out.println("qrCodeData:"+qrCodeData);
		// QR code寫入位置
		File file = new File("");
		String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empBean.getEmpId() + "\\" + empBean.getEmpId() + "_QR.jpg";
		// 字元編碼
		String charset = "UTF-8"; // "ISO-8859-1"
		Map hintMap = new HashMap();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400,400);
		//QR code照片路徑寫入資料庫
		String Qrcode = empId + "/" + empId + "_QR.jpg";
		empBean.setQrcode(Qrcode);
		service.addEmpInformation(empBean);
		
		EmployeeBean emp = service.findById(empId);
		mav.getModel().put("emp", emp);
		mav.setViewName("backendsystem/ResetPasswordSuccess");
		return mav;
	}
	
	
	//自己修改密碼，更新成功後登出
		@PostMapping("/changeNewPassword")
		public ModelAndView changeNewPassword(ModelAndView mav,HttpServletRequest request,RedirectAttributes redirectAttributes,
				@RequestParam Integer empId,
				@RequestParam(value = "newPassword") String newPassword,
				@RequestParam String newPassword2,
				@RequestParam String oldPass) throws WriterException, IOException {
			
			EmployeeBean empBean = service.findById(empId);
			
			HashMap<String,String> errors = new HashMap<String,String>();
			if(newPassword == null || "".equals(newPassword)) {
				errors.put("newPassword", "新密碼不能為空白!");
			}
			
			if(newPassword2 == null || "".equals(newPassword2)) {
				errors.put("newPassword2", "確認新密碼不能為空白!");
			}
			
			if(!newPassword.equals(newPassword2)) {
				errors.put("passwordError", "兩次輸入密碼不一致!");
			}
			
			System.out.println("empBaneOldPass:" + empBean.getPassword());
			System.out.println("oldPass:" + oldPass);
			
			String salt = "eeit138_" + empBean.getBoardDate() + "_07_" + oldPass + empBean.getId();
			String oldPassSHA256 = SHA256Utils.getSHA256StrJava(salt);
			
			System.out.println("empBaneSHAOldPass:" + oldPassSHA256);
			
			if(!oldPassSHA256.equals(empBean.getPassword())) {
				errors.put("oldPassError", "舊密碼錯誤!");
			}
			
			System.out.println(errors);
			
			if(!errors.isEmpty()){
				redirectAttributes.addFlashAttribute("errors", errors);
				mav.setViewName("redirect:/changePassword?empId=" + empId);
				return mav;
			}
			
			
			String newSalt = "eeit138_" + empBean.getBoardDate() + "_07_" + newPassword2 + empBean.getId();
			String newPassSHA256 = SHA256Utils.getSHA256StrJava(newSalt);
			
			service.updatePass(empId, newPassSHA256);
			EmployeeBean emp = service.findById(empId);
			
			//QR code 內容
			String qrCodeData = "http://localhost:8080/GroupOne/qrpunch?x=" +  empBean.getEmpId() + "&c=" + newPassSHA256;
			System.out.println("qrCodeData:"+qrCodeData);
			// QR code寫入位置
			File file = new File("");
			String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\" + empBean.getEmpId() + "\\" + empBean.getEmpId() + "_QR.jpg";
			// 字元編碼
			String charset = "UTF-8"; // "ISO-8859-1"
			Map hintMap = new HashMap();
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
			QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400,400);
			//QR code照片路徑寫入資料庫
			String Qrcode = empId + "/" + empId + "_QR.jpg";
			empBean.setQrcode(Qrcode);
			service.addEmpInformation(empBean);
			
			mav.getModel().put("emp", emp);
			mav.setViewName("backendsystem/SingOut");
			return mav;
		}
	
	
		//掃描頁面
		@GetMapping("/webCam")
		public String webCam() {
			return "backendsystem/WebCam";
		}
		
		//測試頁面
		@GetMapping("/test")
		public String test() {
			return "backendsystem/test";
		}
	
}
