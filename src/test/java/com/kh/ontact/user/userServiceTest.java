package com.kh.ontact.user;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kh.ontact.users.model.dao.UsersDao;
import com.kh.ontact.users.model.dto.UsersDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class userServiceTest {
	@Autowired
	private UsersDao userDao;
	
	//ȸ������ �׽�Ʈ...
//	@Test
//	public void userJoin() throws Exception{
//		UserDto dto = new UserDto();
//		dto.setUemail("test");
//		dto.setUname("test");
//		dto.setUpwd("test");
//		
//		userDao.joinBusiness(dto);
//	}
	
	//���̵� �ߺ��˻�
	@Test
	public void memberIdChk() throws Exception{
		String id="admin";//����
		String id2="test";//����x
		userDao.emailChk(id);
		userDao.emailChk(id2);
	}
}
