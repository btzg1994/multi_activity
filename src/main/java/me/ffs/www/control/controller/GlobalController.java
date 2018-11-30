package me.ffs.www.control.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import me.ffs.www.service.PublicService;



@Controller
@RequestMapping("global")
public class GlobalController {
	private static final Logger logger =LoggerFactory.getLogger(GlobalController.class);
	
	/**
	 * 后台登出
	 * @return
	 */
	@RequestMapping("logout")
	public String logout(HttpSession session){
		session.invalidate();
		return PublicService.BACK_INDEX;
	}
	
	@RequestMapping("404")
	public String p404(){
		return "404";
	}
}
