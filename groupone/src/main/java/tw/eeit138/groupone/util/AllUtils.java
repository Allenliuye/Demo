package tw.eeit138.groupone.util;

import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import tw.eeit138.groupone.model.EmployeeBean;

public class AllUtils {

	private static final String FROM = "wsspeter.sw@gmail.com";
	
	private JavaMailSender mailSender;
	 
    @Autowired
    public AllUtils(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
	
	public void sendResetPasswordEmail(EmployeeBean emp) {
		
		
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setSubject("找回您的帳號與密碼");
			helper.setSentDate(new Date());
			helper.setFrom(new InternetAddress(FROM));
			helper.setReplyTo(new InternetAddress(emp.getEmail()));
			helper.setText("要使用新的密碼,請使用以下連結啟用密碼:,<br/><a href+'" + GenerateLinkUtils.generateResetpwdLink(emp) + "'>點集重設置密碼</a>" , "text/html;charset=UTF-8");
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
//	// 生成驗證帳戶的SHA256驗證碼
//	// 要激活的emp帳戶
//	// return將用戶名和密碼組合後,通過SHA256加密後會產生長度為64的十六進制字串
//	public static String generateCheckcode(EmployeeBean emp) {
//		String username = emp.getUsername();
//		String boardDate = emp.getBoardDate();
//		StringBuilder str = new StringBuilder();
//		Random random = new Random();
//		for (int i = 0; i < 6; i++) {
//			str.append(random.nextInt(10));
//		}
//		String ran = str.toString();
//		return getSHA256StrJava(username + ":" + boardDate + ":" + ran);
//	}
//
//	
//	/**
//	* 利用java原生的摘要實現SHA256加密
//	* @param str 加密後的報文
//	* @return
//	*/
//	public static String getSHA256StrJava(String str) {
//		MessageDigest messageDigest;
//		String encodeStr = "";
//		try {
//			messageDigest = MessageDigest.getInstance("SHA-256");
//			messageDigest.update(str.getBytes("UTF-8"));
//			encodeStr = byte2Hex(messageDigest.digest());
//		} catch (NoSuchAlgorithmException e) {
//			e.printStackTrace();
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		return encodeStr;
//	}
//	
//	/**
//	* 將byte轉為16進位制
//	* @param bytes
//	* @return
//	*/
//	private static String byte2Hex(byte[] bytes) {
//		StringBuffer stringBuffer = new StringBuffer();
//		String temp = null;
//		for (int i = 0; i < bytes.length; i++) {
//			temp = Integer.toHexString(bytes[i] & 0xFF);
//			if (temp.length() == 1) {
//				// 1得到一位的進行補0操作
//				stringBuffer.append("0");
//			}
//			stringBuffer.append(temp);
//		}
//		return stringBuffer.toString();
//	}

//	//md5編碼
//	private static String md5(String string) {
//		MessageDigest md = null;
//		try {
//			md = MessageDigest.getInstance("md5");
//			md.update(string.getBytes());
//			byte[] md5Bytes = md.digest();
//			return bytes2Hex(md5Bytes);
//		} catch (NoSuchAlgorithmException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
//
//	//md5要使用到編碼方法
//	private static String bytes2Hex(byte[] byteArray) {
//		StringBuffer strBuf = new StringBuffer();
//		for (int i = 0; i < byteArray.length; i++) {
//			if (byteArray[i] >= 0 && byteArray[i] < 16) {
//				strBuf.append("0");
//			}
//			strBuf.append(Integer.toHexString(byteArray[i] & 0xFF));
//		}
//		return strBuf.toString();
//	}

//	// 隨機產生6位數
//	public String randomCode() {
//		StringBuilder str = new StringBuilder();
//		Random random = new Random();
//		for (int i = 0; i < 6; i++) {
//			str.append(random.nextInt(10));
//		}
//		return str.toString();
//	}
}
