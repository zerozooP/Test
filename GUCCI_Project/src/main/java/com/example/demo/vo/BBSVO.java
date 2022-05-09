package com.example.demo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class BBSVO {
	
	private int Num;
	private	String uid;
	private String name;
	private String title;
	private String content;
	private String date;
	private int cnt;
	private int reply;
	private int liked;
	private String changeYn;
	private List<Long> fileIdxs;
	
	public BBSVO() {}

	public BBSVO(int num, String uid, String name, String title, String content, 
			String date, String category, int reply, int liked) {
		super();
		Num = num;
		this.uid = uid;
		this.name = name;
		this.title = title;
		this.content = content;
		this.date = date;
		this.reply = reply;
		this.liked = liked;
	}
	
	public String getChangeYn() {
		return changeYn;
	}

	public void setChangeYn(String changeYn) {
		this.changeYn = changeYn;
	}

	public List<Long> getFileIdxs() {
		return fileIdxs;
	}

	public void setFileIdxs(List<Long> fileIdxs) {
		this.fileIdxs = fileIdxs;
	}

	
	public int getLiked() {
		return liked;
	}

	public void setLiked(int liked) {
		this.liked = liked;
	}
	
	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public int getNum() {
		return Num;
	}

	public void setNum(int num) {
		Num = num;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
