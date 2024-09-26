package com.edu.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainController {
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
//    @RequestMapping("/home")  // iframe을 포함하는 부모 페이지
//    public ModelAndView home2() {
//        return new ModelAndView("/pages/home")  // home 페이지에서 iframe 포함
//                .addObject("code", "home");
//    }
//
//    @RequestMapping("/home/chat")  // iframe 내에서 보여질 페이지 (정적 리소스)
//    public String chat() {
//        return "redirect:/chat/index.html";  // static/chat/index.html로 리다이렉트
//    }

}