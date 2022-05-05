package tw.eeit138.groupone.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import tw.eeit138.groupone.dao.EmployeeRepository;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.util.GenerateLinkUtils;
import tw.eeit138.groupone.util.SHA256Utils;

@Service
public class MailService {

	private JavaMailSender mailSender;

	@Autowired
	public MailService(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	@Autowired
	private EmployeeRepository empDao;

	@Autowired
	private SHA256Utils shaUtils;

	@Autowired
	freemarker.template.Configuration freemarkerConfig;

	public void prepareAndSend(String recipient, String message) {
		MimeMessagePreparator messagePreparator = mimeMessage -> {
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage);
			messageHelper.setFrom("wsspeter.sw@gmail.com");
			messageHelper.setTo(recipient);
			messageHelper.setSubject(message + "主旨：Hello J.J.Huang");
			messageHelper.setText(message + "內容：這是一封測試信件，恭喜您成功發送了唷");
		};
		try {
			mailSender.send(messagePreparator);
			// System.out.println("sent");
		} catch (MailException e) {
			// System.out.println(e);
			// runtime exception; compiler will not force you to handle it
		}
	}

	public void sendSimpleMail() throws Exception {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("wsspeter.sw@gmail.com");
		message.setTo("amy99588@gmail.com");
		message.setSubject("主旨：Hello J.J.Huang");
		message.setText("內容：這是一封測試信件，恭喜您成功發送了唷");
		mailSender.send(message);
	}

	private static final String ID_CODE = "idCode";

	// 生成重設密碼連結
	@Transactional
	public String generateResetpwdLink(EmployeeBean emp) {
		Integer empId = emp.getEmpId();
		String idCode = shaUtils.generateCheckcode(emp);
		empDao.updateIdCode(empId, idCode);
		return "http://localhost:8080/GroupOne/resetPassword?empId=" + emp.getEmpId() + "&" + ID_CODE + "=" + idCode;
	}

	// 生成啟用帳號連結
	@Transactional
	public String accountOpeningLink(EmployeeBean emp) {
		Integer empId = emp.getEmpId();
		String idCode = shaUtils.generateCheckcode(emp);
		empDao.updateIdCode(empId, idCode);
		String stateId = "1";
		empDao.updateStateId(empId, stateId);
		return "http://localhost:8080/GroupOne/accountOpening?empId=" + emp.getEmpId() + "&" + ID_CODE + "=" + idCode;
	}

	// 管理員帳號
	private static final String FROM = "w@gmail.com";

	// 管理員寄送啟用帳號連結給員工
	public void sendAccountOpeningEmail(EmployeeBean emp) throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setSubject("天食地栗系統：開通帳號");
			helper.setSentDate(new Date());
			helper.setFrom(FROM, "天食地栗 管理員");
			helper.setTo(new InternetAddress(emp.getEmail()));

			// template.html的EL數據
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("empUsername", emp.getUsername());
			model.put("empId", emp.getEmpId());
			model.put("link", accountOpeningLink(emp));
			model.put("imgTitleName", emp.getEmpId());

			// email的HTML內容
			String attachment = FreeMarkerTemplateUtils
					.processTemplateIntoString(freemarkerConfig.getTemplate("accountOpen.html"), model);
			helper.setText(attachment, true);
			// email的HTML內容中的圖片
			File file = new File("");
			String image = file.getAbsolutePath() + "/src/main/webapp/src/img/other/logo.png";
			String qrcode = file.getAbsolutePath() + "/src/main/webapp/src/img/EmpImg/" + emp.getEmpId() + "/"
					+ emp.getEmpId() + "_QR.jpg";
			FileSystemResource img = new FileSystemResource(new File(image));
			FileSystemResource qrcodeImg = new FileSystemResource(new File(qrcode));
			helper.addInline("aaa", img);
			helper.addInline("code", qrcodeImg);

//			helper.setText("<h3>天食地栗 " + emp.getUsername() + " 員工 您好：</h3><h3>開通帳號請點擊下方開通</h3><br/><h2><a href='"
//					+ accountOpeningLink(emp) + "'>開通</a></h2>"
//					+ "<tr><td rowspan=\"3\"><img src=\"cid:aaa\"><td><h5>地址：台北市信義區基隆路二段33號</h5><h5>電話：02 - 2738-5385</h5><h5>營業時間： 12:00 - 21:00, Sun - Sa\r\n"
//					+ "</h5></td</td></tr>", true);
//			File file = new File("");
//			FileSystemResource img = new FileSystemResource(
//					new File(file.getAbsolutePath() + "/src/main/webapp/src/img/other/logo.png"));
//			helper.addInline("aaa", img);
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 管理員寄送驗證碼及連結給員工
	public void sendResetPasswordEmail(EmployeeBean emp, HttpSession session) throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		// 生成亂數
		String code = shaUtils.randomCode();
		session.setAttribute("sessionCode", code);
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setSubject("天食地栗系統：忘記密碼");
			helper.setSentDate(new Date());
			helper.setFrom(FROM, "天食地栗 管理員");
			helper.setTo(new InternetAddress(emp.getEmail()));
			// template.html的EL數據
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("empUsername", emp.getUsername());
			model.put("link", generateResetpwdLink(emp));
			model.put("code", code);
			// email的HTML內容
			String attachment = FreeMarkerTemplateUtils
					.processTemplateIntoString(freemarkerConfig.getTemplate("forgotPassword.html"), model);
			helper.setText(attachment, true);
			// email的HTML內容中的圖片
			File file = new File("");
			String image = file.getAbsolutePath() + "/src/main/webapp/src/img/other/logo.png";
			FileSystemResource img = new FileSystemResource(new File(image));
			helper.addInline("aaa", img);

//				helper.setText("<h3>天食地栗 " + emp.getUsername() + " 員工 您好：</h3><h3>要更新您的密碼,請使用以下連結啟用密碼:</h3><br/><h2><a href='" + generateResetpwdLink(emp) + "'>點集重設置密碼</a></h2>"
//						+ "<h3>驗證碼為:" + code + "</h3>" + "<tr><td rowspan=\"3\"><img src=\"cid:aaa\"><td><h5>地址：台北市信義區基隆路二段33號</h5><h5>電話：02 - 2738-5385</h5><h5>營業時間： 12:00 - 21:00, Sun - Sa\r\n"
//								+ "</h5></td</td></tr>", true);
//				File file = new File("");
//				FileSystemResource img = new FileSystemResource(new File(file.getAbsolutePath() + "/src/main/webapp/src/img/other/logo.png"));
//				helper. addInline("aaa" ,img);

			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
