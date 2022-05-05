package tw.eeit138.groupone.util.javamail;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;

import tw.eeit138.groupone.service.MailService;
import tw.eeit138.groupone.util.SHA256Utils;

public class test {
	
	@Autowired
	private static MailService mailService;
	
	@Autowired
	private static SHA256Utils shaUtils;
	
	
	public static void main(String [] args) throws Exception {
	
//		mailService.sendSimpleMail();
//		String salt = "eeit138_" + "2022-03-07" + "_07_" + "Passw0rd123@" + "A12qscsacfwq422" ;
//		String password = shaUtils.getSHA256StrJava(salt);
//		
//		String newSalt = "eeit138_" + "2018-07-14" + "_07_" + "Passw0rd123@" + "Aavcadsvdascsa6";
//		String newPassword = shaUtils.getSHA256StrJava(newSalt);
//		
//		String tessalt = "eeit138_" + "2019-09-07" + "_07_" + "Passw0rd123@" + "Lqwfqwvsvsaasascsv765";
//		String tespassword = shaUtils.getSHA256StrJava(tessalt);
//		
//		
//		System.out.println("password:" + password);
//		System.out.println("newPassword:" + newPassword);
//		System.out.println("tespassword:" + tespassword);
		
		File file=new File("D:/gai.jpg"); //指定檔名及路徑
		String name="123";
		String filename=file.getAbsolutePath();
		if(filename.indexOf(".")>=0)
		{
		filename = filename.substring(0,filename.lastIndexOf("."));
		}
	
		System.out.println("file.getParent():"+file.getParent());
		System.out.println("file.renameTo(file2):"+file.renameTo(new File("123.jpg")));
		
		


	}
}
