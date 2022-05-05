package tw.eeit138.groupone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.eeit138.groupone.service.MailService;

@Controller
public class MailController {
	@Autowired
	 private MailService mailService;
	 //spring mail測試用
	 @GetMapping("/sendmail")
	 @ResponseBody
	 public String hello(){
	  mailService.prepareAndSend("amy99588@gmail.com","Sample mail subject4");//要寄給的信箱,信件內容
	  
	  return "Mail sent4";
	 }
	 
	 @GetMapping("/sendmail2")
	 @ResponseBody
	 public String hello2() throws Exception{
	 mailService.sendSimpleMail();
	  
	  return "Mail sent5";
	 }
	 
	 

	
}
