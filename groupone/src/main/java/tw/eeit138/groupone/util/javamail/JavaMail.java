package tw.eeit138.groupone.util.javamail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class JavaMail {
	//--------------------基本資料
	private String userName = "wsspeter.sw@gmail.com" ; //寄件者email
	private String password = "kfqjpyooxhcdegqs" ; //帳號者密碼
	private String customer = "amy99588@gmail.com" ; //收件者email
	private String subject = "測試信件" ; //信件標題
	private String txt = "信件內容文字" ; //信件內容

	
	public void SendMail() {
	//--------------------連線設定
	Properties prop = new Properties();
	//設定連線方式為smtp
	//https://reurl.cc/k7vaz9
	prop.setProperty("mail.transport.protocol", "smtp");
	//host : smtp.gmail.com
	prop.setProperty("mail.host", "smtp.gmail.com");

	prop.put("mail.smtp.port", "587");
	//寄件者帳號需要驗證：是
	prop.put("mail.smtp.auth", "true");
	
	prop.put("mail.smtp.starttls.enable", "true");
	prop.put("mail.smtp.starttls.required","true");
	prop.put("mail.smtp.ssl.trust", "host-url");
	//需要安全資料傳輸層 (SSL)：是
	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	//安全資料傳輸層 (SSL) 通訊埠：465
	prop.put("mail.smtp.socketFactory.port", "587");
	//連線資訊
	prop.put("mail.debug", "true");
		
	//--------------------帳號驗證
	//--------------------Session javamail api 默認設定屬性
	//透過匿名類別抓帳號密碼
	Session session = Session.getDefaultInstance(prop, new Authenticator() {

		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(userName, password);
		}
	});
	
	
	//--------------------Message 放入基本資料
	MimeMessage message = new MimeMessage(session);
	
	
	try {
		//寄件者
		//匿名類別寫法
		message.setSender(new InternetAddress(userName));
		
		//收件者
		message.setRecipient(RecipientType.TO, new InternetAddress(customer));
		
		//標題
		message.setSubject(subject);
		
		//內容/格式
		message.setContent(txt, "text/html;charset=UTF-8");
		
		//--------------------Transport將Message傳出去
		Transport transport = session.getTransport();
		transport.send(message);
		
		transport.close();
	} catch (AddressException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (MessagingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	
	}
	
}
