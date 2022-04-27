package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.example.demo.dao.UserDAO;
import com.example.demo.service.UserSVC;
import com.example.demo.vo.UserVO;

@SessionAttributes("uid")
@Controller
public class UserController {
	
	@Autowired
	private UserDAO dao;
	
	@Autowired
	private UserSVC svc;
	
	@Autowired
	HttpSession session;
	
	@PostMapping("/insertuser")
	@ResponseBody
	public String insertUser(UserVO user) {
		System.out.println(user);
		return String.format("{\"insertuser\":%b}", dao.insertUser(user));
	}
	
	@PostMapping("/login")
	@ResponseBody
	public String login(UserVO user, Model model) {
		UserVO vo = svc.readLogin(user);
		boolean ok = svc.login(user);
		if(ok) {
			model.addAttribute("uid",user.getUid());
			session.setAttribute("name", vo.getName());
		}
		return String.format("{\"ok\":%b}", ok);
	}
	
	@GetMapping("/logout")
	@ResponseBody
	public boolean logout(SessionStatus status) {
		status.setComplete(); // 세션에 저장된 모든 데이터를 삭제함
		return status.isComplete();
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateUser(UserVO user, Model model) {
		return String.format("{\"update\":%b}", svc.updateUser(user));
	}
	
}
