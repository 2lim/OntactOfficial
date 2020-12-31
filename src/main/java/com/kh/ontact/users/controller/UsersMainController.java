package com.kh.ontact.users.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ontact.company.model.dto.CompanyDto;
import com.kh.ontact.users.model.dto.UsersDto;
import com.kh.ontact.users.model.service.UsersService;

@Controller
public class UsersMainController {
	@Autowired
	UsersService uservice;

	@Autowired
	BCryptPasswordEncoder pwdEncoder;

	private static final Logger logger = LoggerFactory.getLogger(UsersMainController.class);

	// ����ȭ�� �̵�
	@RequestMapping("/main")
	public String main() {
		return "users/main";
	}

	// ����Ͻ� ȸ������â �̵�
	@RequestMapping(value = "/busjoin", method = RequestMethod.GET)
	public String joinBusiness() {
		return "users/join";
	}

	// ����Ͻ� ȸ������
	@RequestMapping(value = "/busjoin", method = RequestMethod.POST)
	public String joinBusiness(UsersDto userdto, CompanyDto companydto) {
		logger.info("userInfo");
		try {
			String inputPass = userdto.getUpwd();
			String pwd = pwdEncoder.encode(inputPass);
			userdto.setUpwd(pwd);
			String uname = userdto.getUname();
			companydto.setCeo(uname);
			uservice.joinBusiness(userdto, companydto); // ���Ը޼ҵ�
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "users/main";
	}

	// ���̵� �ߺ�üũ
	@RequestMapping(value = "/emailChk", method = RequestMethod.POST)
	@ResponseBody
	public String emailChk(String uemail) {
		logger.info("memberIdChk() ����");
		String val = null;
		try {
			int result = uservice.emailChk(uemail);
			logger.info("����� = " + result);
			if (result != 0) {
				val = "fail"; // �ߺ� ���̵� ����
			} else {
				val = "success"; // �ߺ� ���̵� x
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return val;
	}

	// �α����������� �̵�
	@RequestMapping(value = "/loginform", method = RequestMethod.GET)
	public String loginFor(Locale locale, Model model) {
		logger.info("Welcome Login Form!");

		return "users/login";
	}

//	//�α���
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public void loginPage(String error, String logout, Model model) {
//		logger.info("�α��� �������� �̵�~");
//		logger.info("err :" + error);
//		logger.info("logout : " + logout);
//		if (error != null) {
//			model.addAttribute("error", "�α��� ����");
//		}
//		if (logout != null) {
//			model.addAttribute("logout", "�α׾ƿ�");
//		}
//	}

	// ���� ���� ������
	@RequestMapping(value = "/access_denied", method = RequestMethod.GET)
	public String accessDeniedPage() {
		logger.info("���ٱ��Ѿ���");
		return "users/accessDenied";
	}

	@RequestMapping(value = "/login-processing", method = RequestMethod.POST)
	public void loginProcessing(String error) {
		logger.info("login-processing!");
		logger.info("err :" + error);
	}
	
	//�����ڱ��� �׽�Ʈ��
	@RequestMapping(value = "/admin/adminHome.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome Admin Home!");
		
		return "admin/adminHome";
	}

	// ���� ���� �׽�Ʈ
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public String member() {
		return "intro/introduction";
	}

}
