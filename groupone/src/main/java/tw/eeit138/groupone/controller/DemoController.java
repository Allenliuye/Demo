package tw.eeit138.groupone.controller;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import tw.eeit138.groupone.model.DemoBean;
import tw.eeit138.groupone.service.DemoService;
import tw.eeit138.grouponeutil.AES256Encryption;
import tw.eeit138.grouponeutil.Gsons;

@Controller

public class DemoController {
	@Autowired
	private DemoService service;

	// 新增
	@RequestMapping(value = "/ad")
	public ModelAndView postNewDemoBean(ModelAndView mav, String c_base64, String c_aes256) {
		DemoBean db = new DemoBean();

		try {

			// 存入金鑰base64
			byte[] encodedBytes = Base64.getEncoder().encode(c_base64.getBytes());
			String encodedStr = new String(encodedBytes);
			db.setC_base64(encodedStr);
			// 加密
			byte[] data = AES256Encryption.encrypt(c_aes256.getBytes(), encodedBytes);
			// 存入密文
			db.setC_aes256(new String(data));
		} catch (Exception e) {
			e.printStackTrace();
		}
		DemoBean lastestdb = service.insert(db);

		mav.getModel().put("lastestDB", lastestdb);

		return mav;
	}

	// 查詢
	@RequestMapping(value = "/st")
	public ModelAndView find(ModelAndView mav,

			String c_aes256) {

		List<DemoBean> DemoBean = service.selectAll();
//		System.out.println(DemoBean.toString());
//		ArrayList<Object> list1 = new ArrayList<>();
//		int lcsycount = DemoBean.size();
//		for (int i = 0; i < lcsycount; i++) {
//			String c_base64 = DemoBean.get(i).getC_base64();
//			byte[] decodedBytes = Base64.getDecoder().decode(c_base64.getBytes());
//			String decodedStr = new String(decodedBytes);
//			
//			System.out.println(decodedStr);
//			list1.add(decodedStr);
//
//		}
	
//byte[] decodedBytes = Base64.getDecoder().decode(list1.getBytes());
//		List<Gsons>Gsons = new ArrayList<Gsons>();
//        	Gson gson = new Gson();
//			DemoBean db = new DemoBean();
//			String c_base64 =db.getC_base64();
//			byte[] decodedBytes = Base64.getDecoder().decode(c_base64.getBytes());
//			String decodedStr = new String(decodedBytes);
//		decodedStr = gson.toJson(Gsons);

//			System.out.println(decodedStr);

		mav.getModel().put("DemoBean", DemoBean);
		mav.setViewName("st");

		return mav;

	}
	
	@GetMapping("/delete")
	public ModelAndView deletePage(ModelAndView mav, @RequestParam(name = "id") Integer idx) {
		service.deletePage(idx);
		mav.setViewName("redirect:/list");
		return mav;
	}

}
