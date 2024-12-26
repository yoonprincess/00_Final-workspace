package com.mig.blb.option.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.option.model.dao.OptionDao;
import com.mig.blb.option.model.vo.Option;

@Service
public class OptionServiceImple implements OptionService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private OptionDao optionDao;
	
	@Override
	public ArrayList<Option> selectCartOption(int prodNo) {
		return optionDao.selectCartOption(sqlSession, prodNo);
	}

	@Override
	@Transactional
	public int insertOption(Map<String, Object> option) {
		return optionDao.insertOption(sqlSession, option);
	}

	@Override
	public List<Object> selectOptionList() {
		return optionDao.selectOptionList(sqlSession);
	}

	@Override
	@Transactional
	public int updateOption(Option option) {
		return optionDao.updateOption(sqlSession, option);
	}

}
