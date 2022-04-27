package com.example.demo.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.vo.UserVO;
import com.example.demo.dao.UserDAO;


@Service
public class UserSVC {
	private HttpSession session;
	
	@Autowired
	public UserSVC(HttpSession session) {
		this.session = session;
	}
	
	@Autowired
	private UserDAO dao;
	
	public boolean insertUser(UserVO user) {
		boolean ok = (dao.insertUser(user))>0;
		return ok;
	}
	
	public boolean login(UserVO user) {
		UserVO u = dao.login(user);
		if(u!=null) {
			session.setAttribute(u.getUid(),u.getPwd());
			return true;
		}else {
			return false;
		}
	}
	
	public boolean isLogin() {
		if(session.getAttribute("uid")!=null) {
			return true;
		}
		return false;
	}
	
	public boolean updateUser(UserVO user) {
		String uid = (String) session.getAttribute("uid");
		user.setUid(uid);
		boolean up = (dao.updateUser(user))>0;
		return up;
	}

	public UserVO readLogin(UserVO vo) {
		return dao.readLogin(vo);
	}
}
