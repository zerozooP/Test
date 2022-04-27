package com.example.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.UserVO;

@Mapper
public interface UserXMLMapper {
	int insertUser(UserVO user);
	UserVO getUser(UserVO user);
	UserVO checkById(String uid);
	int updateUser(UserVO user);
	UserVO selectLogin(UserVO vo);
	
}
