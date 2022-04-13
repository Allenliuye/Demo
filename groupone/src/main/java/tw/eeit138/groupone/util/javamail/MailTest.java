package tw.eeit138.groupone.util.javamail;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

public class MailTest {
	private static JavaMailSender mailSender;

	@Autowired
	public MailTest(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public static void main(String[] args) throws Exception {
		Date date = new Date();
		
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String bDate = ft.format(date);
		System.out.println("date.getTime():" + date.getTime());
		System.out.println("date.getDay():" + date.getDay());
		System.out.println("bDate:" + bDate );
		
		sendSimpleMail();
	}
	
	public static void sendSimpleMail() throws Exception {
		SimpleMailMessage message = new SimpleMailMessage();
//		message.setFrom("wsspeter.sw@gmail.com");
		message.setTo("amy99588@gmail.com");
		message.setSubject("主旨：Hello J.J.Huang");
		message.setText("內容：這是一封測試信件，恭喜您成功發送了唷");
		System.out.println("SendMial");
		mailSender.send(message);
	}

}
