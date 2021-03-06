package com.kh.ontact.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ontact.alert.model.dto.AlertDto;
import com.kh.ontact.alert.model.service.AlertService;
import com.kh.ontact.project.boardall.model.dto.BoardAllDto;
import com.kh.ontact.project.boardall.model.dto.BoardAllViewDto;
import com.kh.ontact.project.boardall.model.service.BoardAllService;
import com.kh.ontact.project.commonboard.model.service.CommonboardService;
import com.kh.ontact.project.files.model.dao.FilesDao;
import com.kh.ontact.project.model.dto.ProjectDto;
import com.kh.ontact.project.model.service.ProjectService;
import com.kh.ontact.project.reply.model.dto.ReplyDto;
import com.kh.ontact.project.reply.model.service.ReplyService;
import com.kh.ontact.project.task.model.dto.TaskDto;
import com.kh.ontact.project.todo.model.service.TodoService;
import com.kh.ontact.projectMember.model.dto.ProjectMemberDto;
import com.kh.ontact.projectMember.model.service.ProjectMemberService;
import com.kh.ontact.users.model.dto.CustomUserDetails;
import com.kh.ontact.users.model.dto.UsersDto;
import com.kh.ontact.users.model.service.UsersService;

@Controller
public class PjDetailControlle {
	@Autowired
	private BoardAllService ballService;
	@Autowired
	private UsersService usersService;
	@Autowired
	ReplyService replyService;
	@Autowired
	BoardAllService baService;
	@Autowired
	ProjectMemberService pmService;
	@Autowired
	AlertService alertService;
	// 은실 임의로 넣음
	@Autowired
	CommonboardService commonboardservice;
	@Autowired
	private TodoService todoService;
	@Autowired
	FilesDao filesdao;
	@Autowired
	ProjectService pjService;
	
	//윤진 : ProejctDetail 전체리스트
	@RequestMapping(value="project/pjdetail", method=RequestMethod.GET)
	public ModelAndView selectListPjDetail(ModelAndView mv, @RequestParam(name="pno") String pno,
			UsersDto dto,@RequestParam(value = "mcount",required = false) String mcount,
			@RequestParam(value = "deleteResult",required = false) String deleteResult) {
		System.out.println("blist 컨트롤러 진입");
		CustomUserDetails user = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		BoardAllDto badto = new BoardAllDto();
		ProjectDto pjdto = new ProjectDto();
		badto.setPno(pno);
		List<BoardAllViewDto> blist = new ArrayList<BoardAllViewDto>();
		List<ProjectMemberDto> ulist = new ArrayList<ProjectMemberDto>();
		String cno = user.getCno();
		String uno = user.getUno();
		List<ReplyDto> rlist = new ArrayList<ReplyDto>();
		List<ReplyDto> rclist = new ArrayList<ReplyDto>();

		dto.setPno(pno);
		dto.setCno(cno);
		dto.setUno(uno);
		AlertDto aldto = new AlertDto();
		aldto.setPno(pno);
		aldto.setUno(uno);

		List<UsersDto> pmlist = new ArrayList<UsersDto>();
		int userListSize = 0;

		try {
			blist = ballService.selectListPjDetail(pno);
			System.out.println("blist:" + blist);

			// 혜원 추가 코드 : 프로젝트 유저리스트
			ulist = usersService.listProjectMember(pno);
			System.out.println("프로젝트 user 리스트" + ulist);
			// 댓글리스트
			rlist = replyService.ListReply(pno);
			System.out.println("글 replylist" + rlist + "글 replylist");
			// 댓글 카운트수
			rclist = replyService.ReplyCount(pno);
			System.out.println("댓글 카운트 list" + rclist);
			userListSize = ulist.size();
			
			//프로젝트 이름 , 글 개수 불러오기
			pjdto=pjService.SelectProName(pno);
			System.out.println("프로젝트 이름 개수:"+pjdto);

			// 프로젝트 초대 리스트
			pmlist = usersService.projectInviteList(dto);
			System.out.println("프로젝트 초대 리스트:" + pmlist);
			// 은실 임의로 넣음
			// mv.addObject("blist", commonboardservice.getCommonboard());
			mv.addObject("file", commonboardservice.getFileboard(pno));

			mv.addObject("pno", pno);
			mv.addObject("blist", blist);
			mv.addObject("userlist", ulist);

			mv.addObject("pjdto", pjdto);
			mv.addObject("rclist", rclist);
			mv.addObject("pmlist", pmlist);
			mv.addObject("replylist", rlist);
			mv.addObject("userListSize", userListSize);
			mv.addObject("userSize", userListSize - 1);
			if (mcount != null) {
				mv.addObject("inviteSuccess", "프로젝트에 " + mcount + "명이 초대되었습니다");
			}
			if(deleteResult!=null) {
				mv.addObject("deleteResult", "해당 프로젝트에 글이 1개 삭제되었습니다.");
			}
			mv.setViewName("project/pjdetail");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	// 내 게시물
	@RequestMapping(value = "project/mydetail", method = RequestMethod.GET)
	public ModelAndView selectMyList(ModelAndView mv, UsersDto dto) {
		System.out.println("mylist 컨트롤러 진입");
		CustomUserDetails user = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		List<BoardAllViewDto> blist = new ArrayList<BoardAllViewDto>();
		List<ReplyDto> rclist = new ArrayList<ReplyDto>();

		String uno = user.getUno();
		dto.setUno(uno);

		try {
			blist = todoService.getBoardAllList(uno);
			//blist = ballService.selectListPjDetail(pno);
		
			// 댓글 카운트수
			rclist = replyService.MyReplyCount(uno);
			System.out.println("댓글 카운트 list" + rclist);

			// 파일
			mv.addObject("file", filesdao.MygetFileboard(uno));
			mv.addObject("blist", blist);
			mv.addObject("rclist", rclist);
			
			mv.setViewName("project/pjdetailmy");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

}
