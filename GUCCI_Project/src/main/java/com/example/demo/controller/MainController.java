package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.demo.dao.UserDAO;
import com.example.demo.service.MainSVC;
import com.example.demo.service.UserSVC;
import com.example.demo.vo.CalendarVO;
import com.example.demo.vo.UserVO;

@SessionAttributes("uid")
@Controller
public class MainController {
	
	@Autowired
	private MainSVC mSvc;
	
	@Autowired
	private UserDAO dao;
	
	@Autowired
	private UserSVC svc;

	@GetMapping("/index")
	public String indexPage(Model model) {
		if(svc.isLogin()) {
			return "index";
		}else {
			model.addAttribute("msg","로그인 후에 사용해주세요");
			return "login";
		}
	}

	@GetMapping("/charts")
	public String charts() {
		return "charts";
	}
	
	@GetMapping("/charts2")
	public String charts2() {
		
		return "charts2";
	}
	
	@GetMapping("/password")
	public String password() {
		return "password";
	}
	
	@GetMapping("/update")
	public String updatePage(Model model) {
		String uid = (String) model.getAttribute("uid");
		if(svc.isLogin()) {
			UserVO user = dao.checkById(uid);
			model.addAttribute("user",user);
			return "password";
		}else {
			model.addAttribute("msg","로그인 후에 사용해주세요");
			return "login";
		}
	}
	
	@GetMapping("/login")
	public String loginPage() {
		if(svc.isLogin()) {
			return "index";
		}else {
			return "login";
		}
	}
	
	@GetMapping("/adduser")
	public String addUser() {
		return "register";
	}
	
	@GetMapping("/tables")
	public String tables() {
		return "tables";
	}
	
	@GetMapping("/layout-static")
	public String layout_static() {
		return "layout-static";
	}
	
	@GetMapping("/layout-sidenav-light")
	public String layout_sidenav_light() {
		return "layout-sidenav-light";
	}

	@GetMapping("/calendar")
	public String calendar(HttpServletRequest request) {
		List<CalendarVO> list =mSvc.getCalendar();
		request.setAttribute("calendarList", list);
		return "calendar";
	}
	
	@GetMapping("/calendar2")
	public String calendar2() {
		return "calendar2";
	}
	
	
	@GetMapping("/401")
	public String error401() {
		return "401";
	}
	
	@GetMapping("/404")
	public String error404() {
		return "404";
	}
	
	@GetMapping("/500")
	public String error500() {
		return "500";
	}

}
