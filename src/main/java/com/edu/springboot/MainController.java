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
	
	@RequestMapping("/release.do")
	public String release() {
		return "common/release";
	}
	


}