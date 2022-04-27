package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.BBSDAO;
import com.example.demo.vo.BBSVO;
import com.example.demo.vo.ReplyVO;
import com.github.pagehelper.PageInfo;

@Service
public class BBSSVC {
	
	@Autowired
	private BBSDAO dao;
	
	public boolean add(BBSVO vo) {
		return dao.add(vo)>0;
	}

	public PageInfo<BBSVO> getList(int pageNum, int pageSize) {
		return dao.getList(pageNum, pageSize);
	}
	
	public List<ReplyVO> reply(int num) {
		return dao.reply(num);
	}

	public BBSVO detail(int num) {
		return dao.detail(num);
	}

	public boolean edit(BBSVO vo) {
		return dao.edit(vo)>0;
	}

	public boolean delete(int num) {
		return dao.delete(num)>0;
	}
}
