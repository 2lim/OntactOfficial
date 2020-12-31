package com.kh.ontact.users.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ontact.users.model.dto.UsersDto;

@Repository("usersDao")
public class UsersDao {
	@Autowired
	private SqlSession sqlSession;
	
	//ȸ�� ȸ������
	public void joinBusiness(UsersDto dto) throws Exception{
		sqlSession.insert("Users.joinBusiness",dto);
	}
	
	//���̵� �ߺ�üũ
	public int emailChk(String uemail) throws Exception{
		int result = sqlSession.selectOne("Users.emailChk",uemail);
		return result;
	}

}
