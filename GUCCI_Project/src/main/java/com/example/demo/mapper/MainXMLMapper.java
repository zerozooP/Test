package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.CalendarVO;


@Mapper
public interface MainXMLMapper {
	List<CalendarVO> selectAllCalendar();
}
