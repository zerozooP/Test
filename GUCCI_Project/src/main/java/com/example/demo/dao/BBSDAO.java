package com.example.demo.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.mapper.BBSXMLMapper;
import com.example.demo.vo.BBSVO;
import com.example.demo.vo.ReplyVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Repository
public class BBSDAO {
	
	@Autowired
	private BBSXMLMapper m;
	
	private HttpSession session;

	@Autowired
	public BBSDAO(HttpSession session) {
		this.session = session;
	}
	

	public int add(BBSVO vo) {
		SimpleDateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
        Calendar calendar = Calendar.getInstance();
        Date dateObj = calendar.getTime();
        
        String formattedDate = dtf.format(dateObj);
		String uid = (String)session.getAttribute("uid");
		String name = (String)session.getAttribute("name");
		vo.setUid(uid);
		vo.setName(name);
		vo.setDate(formattedDate);
		return m.insertAdd(vo);
	}
	
	public List<ReplyVO> reply(int num) {
		return m.selectReply(num);
	}


	public PageInfo<BBSVO> getList(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
	    PageInfo<BBSVO> pageInfo = new PageInfo<>(m.getList());
	    return pageInfo;
	}


	public BBSVO detail(int num) {
		m.updateCnt(num);
		return m.detail(num);
	}


	public int edit(BBSVO vo) {
		return m.edit(vo);
	}


	public int delete(int num) {
		return m.delete(num);
	}
}
