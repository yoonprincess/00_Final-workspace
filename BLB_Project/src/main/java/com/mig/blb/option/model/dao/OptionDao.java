package com.mig.blb.option.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.option.model.vo.Option;

@Repository
public class OptionDao {

	public ArrayList<Option> selectCartOption(SqlSessionTemplate sqlSession, int prodNo) {
		return (ArrayList)sqlSession.selectList("optionMapper.selectCartOption", prodNo);
	}

}
