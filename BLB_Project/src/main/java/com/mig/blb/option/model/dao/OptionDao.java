package com.mig.blb.option.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.option.model.vo.Option;

@Repository
public class OptionDao {

	public ArrayList<Option> selectCartOption(SqlSessionTemplate sqlSession, int prodNo) {
		return (ArrayList)sqlSession.selectList("optionMapper.selectCartOption", prodNo);
	}

	public int insertOption(SqlSessionTemplate sqlSession, Map<String, Object> option) {
		return sqlSession.insert("optionMapper.insertOption", option);
	}

	public List<Object> selectOptionList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("optionMapper.selectOptionList");
	}

	public int updateOption(SqlSessionTemplate sqlSession, Option option) {
		return sqlSession.update("optionMapper.updateOption", option);
	}

}
