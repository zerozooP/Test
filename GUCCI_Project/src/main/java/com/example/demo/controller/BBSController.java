package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.demo.service.BBSSVC;
import com.example.demo.service.UserSVC;
import com.example.demo.vo.BBSVO;
import com.example.demo.vo.UserVO;
import com.github.pagehelper.PageInfo;

import ch.qos.logback.core.subst.Token.Type;

@Controller
public class BBSController {

	@Autowired
	HttpSession session;
	
	@Autowired
	private UserSVC login;
	
	@Autowired
	private BBSSVC svc;
	
	@PostMapping("/bbs_delete/{num}")
	@ResponseBody
	public String delete(@PathVariable("num")int num) {
		return String.format("{\"deleted\":%b}", svc.delete(num));
	}
	
	@PostMapping("/bbs_edit")
	@ResponseBody
	public String edited(BBSVO vo) {
		return String.format("{\"edited\":%b}", svc.edit(vo));
	}
	
	@GetMapping("/bbs_edit/{num}")
	public String edit(@PathVariable("num")int num, Model m) {
		if(login.isLogin()) {
			m.addAttribute("edit", svc.detail(num));
			return "bbs_edit";
		} else {
			return "login";
		}
	}
	
	@GetMapping("/bbs_detail/{num}")
	public String detail(@PathVariable("num")int num, Model m) {
		m.addAttribute("detail", svc.detail(num));
		String uid = (String)session.getAttribute("uid");
    	m.addAttribute("uid", uid);
		m.addAttribute("reply", svc.reply(num));
		
		return "bbs_detail";
	}
	
	@PostMapping("/bbs_add")
	@ResponseBody
	public String add(BBSVO vo) {
		System.out.println(" name="+vo.getName()+" content="+ vo.getContent());
		return String.format("{\"added\":%b}", svc.add(vo));
	}
	
	@GetMapping("/bbs_add")
	public String addWrite(Model m) {
		if(login.isLogin()) {
			String name = (String)session.getAttribute("name");
			m.addAttribute("name", name);
			return "bbs_add";
		} else {
			return "login";
		}
	}
	
	@GetMapping("/bbs_list/{pgNum}")
	public String GetList(@PathVariable("pgNum")int pg, Model m) {
		PageInfo<BBSVO> pgInfo = svc.getList(pg, 8);
	    m.addAttribute("pageInfo", pgInfo);
	    return "bbs_list";
	}
}
