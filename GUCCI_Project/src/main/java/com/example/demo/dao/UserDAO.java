package com.example.demo.dao;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Repository;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.demo.mapper.UserXMLMapper;
import com.example.demo.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	private UserXMLMapper UM;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	
	public int insertUser(UserVO user) {
		String encodePassword = passwordEncoder.encode(user.getPwd());
        user.setPwd(encodePassword);
		return UM.insertUser(user);
	}
	
	public UserVO login(UserVO user) {
		 UserVO U = UM.checkById(user.getUid());
		 boolean check = passwordEncoder.matches(user.getPwd(), U.getPwd());
		 if(check) {
			 return U;
		 }else {
			 return null;
		 }
		 
	   }
	
	public UserVO checkById(String uid) {
		return UM.checkById(uid);
	}
	
	public int updateUser(UserVO user) {
		String encodePassword = passwordEncoder.encode(user.getPwd());
		user.setPwd(encodePassword);
		return UM.updateUser(user);
		
	}

	public UserVO readLogin(UserVO vo) {
		return UM.selectLogin(vo);
	}
}
