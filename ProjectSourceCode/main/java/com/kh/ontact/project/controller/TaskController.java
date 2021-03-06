package com.kh.ontact.project.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ontact.alert.model.service.AlertService;
import com.kh.ontact.chat.model.dto.ChatDto;
import com.kh.ontact.chatalert.model.dto.ChatAlertDto;
import com.kh.ontact.chatmember.model.dto.ChatMemberDto;
import com.kh.ontact.project.boardall.model.dto.BoardAllDto;
import com.kh.ontact.project.boardall.model.service.BoardAllService;
import com.kh.ontact.project.commonboard.model.service.CommonboardService;
import com.kh.ontact.project.files.model.dto.FilesDto;
import com.kh.ontact.project.reply.model.dto.ReplyDto;
import com.kh.ontact.project.reply.model.service.ReplyService;
import com.kh.ontact.project.task.model.dto.TaskDto;
import com.kh.ontact.project.task.model.service.TaskService;
import com.kh.ontact.projectMember.model.dto.ProjectMemberDto;
import com.kh.ontact.projectMember.model.service.ProjectMemberService;
import com.kh.ontact.users.model.dto.CustomUserDetails;
import com.kh.ontact.users.model.dto.UsersDto;
import com.kh.ontact.users.model.service.UsersService;

@Controller
public class TaskController {
	@Autowired
	TaskService taskService;
	@Autowired
	ReplyService replyService;
	@Autowired
	BoardAllService baService;
	@Autowired
	UsersService usersService;
	@Autowired
	ProjectMemberService pmService;
	@Autowired
	AlertService alertService;
	//은실 임의로 넣음
	@Autowired
	CommonboardService commonboardservice;
	
	//혜원 코드
	@RequestMapping(value="/project/projecttest",method=RequestMethod.GET)
	public ModelAndView headerTEST(ModelAndView mv) {
		mv.setViewName("project/projectmaintest");
		return mv;
	}
	
	//업무 내용 insert
		@RequestMapping(value="/project/taskinsert",method=RequestMethod.POST)
		public ModelAndView taskinsert(ModelAndView mv, @RequestParam(name = "tasktitle") String tasktitle,
				@RequestParam(name = "taskradio") String taskradio,
				@RequestParam(name = "taskname") String taskname,@RequestParam(name = "taskstartdate") Date taskstartdate,
				@RequestParam(name = "taskenddate") Date taskenddate,@RequestParam(name = "trate") String trate,
				@RequestParam(name = "taskpri") String taskpri,@RequestParam(name = "bopen") int taskopen,
				@RequestParam(name = "pno") String pno,@RequestParam(name = "taskcontent") String taskcontent,
				BoardAllDto dto,TaskDto tdto,FilesDto file, Authentication authentication) {
				CustomUserDetails userdetail = (CustomUserDetails) authentication.getPrincipal();
				String uno=userdetail.getUno();
				String uname=userdetail.getUname();
				
				dto.setPno(pno);
				dto.setBname(tasktitle);
				dto.setUno(uno);
				dto.setBopen(taskopen);
				dto.setUname(uname);
				dto.setBtype(2);
				
				tdto.setTaskmanager(taskname);
				tdto.setTend(taskenddate);
				tdto.setTstart(taskstartdate);
				tdto.setTpriority(taskpri);
				tdto.setTstate(taskradio);
				tdto.setTmemo(taskcontent);
				
				ProjectMemberDto pmdto= new ProjectMemberDto();
				BoardAllDto badto = null;
				pmdto.setUno(uno);
				pmdto.setPno(pno);
				
				try {
					int rs =taskService.insertTask(file, tdto, dto);
					System.out.println(rs+"업무 insert 성공");
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				mv.addObject("pno", pno);
				mv.setViewName("redirect:/project/pjdetail");
			return mv;
		}
		
		//프로젝트 디테일로 들어가기 ( task만 가지고 들어감 + 추가 예정 )  
		@RequestMapping(value="/project/projectDetail",method=RequestMethod.GET)
		public ModelAndView projectDetail(ModelAndView mv, @RequestParam(name = "pno") String pno,UsersDto dto,
				@RequestParam(value = "mcount",required = false) String mcount) {
			CustomUserDetails user = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String cno = user.getCno();
			String uno = user.getUno();
			List<ReplyDto> rlist = new ArrayList<ReplyDto>();
			List<ReplyDto> rclist = new ArrayList<ReplyDto>();
			List<TaskDto> list= new ArrayList<TaskDto>();
			List<ProjectMemberDto> ulist= new ArrayList<ProjectMemberDto>();
			
			dto.setPno(pno);
			dto.setCno(cno);
			dto.setUno(uno);
			List<UsersDto> pmlist = new ArrayList<UsersDto>();
			int userListSize = 0;
			try {
				//업무글리스트
				list = taskService.ListTaskAll(pno);
				System.out.println("글 blist"+list+"글 blist");
				//댓글리스트
				rlist=replyService.ListReply(pno);
				System.out.println("글 replylist"+rlist+"글 replylist");
				//댓글 카운트수
				rclist=replyService.ReplyCount(pno);
				System.out.println("댓글 카운트 list"+rclist);
				//프로젝트 유저리스트
				ulist=usersService.listProjectMember(pno);
				System.out.println("프로젝트 user 리스트"+ulist);
				userListSize = ulist.size();
				//프로젝트 초대 리스트
				pmlist=usersService.projectInviteList(dto);
				System.out.println("프로젝트 초대 리스트:"+pmlist);
				//은실 임의로 넣음
				mv.addObject("blist", commonboardservice.getCommonboard());
				mv.addObject("file", commonboardservice.getFileboard(pno));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			mv.addObject("rclist", rclist);
			mv.addObject("pmlist", pmlist);
			mv.addObject("tasklist", list);
			mv.addObject("replylist", rlist);
			mv.addObject("userlist", ulist);
			mv.addObject("userListSize", userListSize);
			mv.addObject("userSize", userListSize-1);
			if(mcount!=null) {
				mv.addObject("inviteSuccess", "프로젝트에 "+mcount+"명이 초대되었습니다");
			}
			mv.addObject("pno", pno);
			mv.setViewName("project/pjdetail");
			//mv.setViewName("project/test01");
			return mv;
		}
		
		// task 글 삭제
		@RequestMapping(value="/project/taskdelete",method=RequestMethod.GET)
		public ModelAndView taskdelete(ModelAndView mv, @RequestParam(name = "bno") int bno,
				@RequestParam(name = "pno") String pno) {
			System.out.println("bno"+bno);
			System.out.println("pno"+pno);
			int rs = 0;
			try {
				rs =taskService.deleteTask(bno);
				System.out.println(rs+"개 삭제 : task");
			} catch (Exception e) {
				e.printStackTrace();
			}
			mv.addObject("pno", pno);
			mv.addObject("deleteResult", rs);
			mv.setViewName("redirect:/project/pjdetail");
			return mv;
		}
		
		//업무 state ajax변경 -01
		@ResponseBody
		@RequestMapping(value="/project/taskstate01")
		public int taskstate01(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.taskStateUpdate01(bno);
				System.out.println(rs+"업데이트 ajax  : state 1");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 state ajax변경 -02
		@ResponseBody
		@RequestMapping(value="/project/taskstate02")
		public int taskstate02(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.taskStateUpdate02(bno);
				System.out.println(rs+"업데이트 ajax  : state 2");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 state ajax변경 -03
		@ResponseBody
		@RequestMapping(value="/project/taskstate03")
		public int taskstate03(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.taskStateUpdate03(bno);
				System.out.println(rs+"업데이트 ajax : state 3");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 state ajax변경  -04
		@ResponseBody
		@RequestMapping(value="/project/taskstate04")
		public int taskstate04(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.taskStateUpdate04(bno);
				System.out.println(rs+"업데이트 ajax  : state 4");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		
		
		//업무 달성률 ajax변경  -00
		@ResponseBody
		@RequestMapping(value="/project/tasktrate00")
		public int tasktrate00(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate00(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 달성률 ajax변경  -20
		@ResponseBody
		@RequestMapping(value="/project/tasktrate20")
		public int tasktrate20(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate20(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 달성률 ajax변경  -40
		@ResponseBody
		@RequestMapping(value="/project/tasktrate40")
		public int tasktrate40(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate40(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 달성률 ajax변경  -60
		@ResponseBody
		@RequestMapping(value="/project/tasktrate60")
		public int tasktrate60(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate60(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 달성률 ajax변경  -80
		@ResponseBody
		@RequestMapping(value="/project/tasktrate80")
		public int tasktrate80(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate80(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 달성률 ajax변경  -100
		@ResponseBody
		@RequestMapping(value="/project/tasktrate100")
		public int tasktrate100(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.trateUpdate100(bno);
				System.out.println(rs+"업데이트 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 우선순위 ajax변경  -Lv1
		@ResponseBody
		@RequestMapping(value="/project/tprilv1")
		public int tprilv1(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.tpriLv1(bno);
				System.out.println(rs+"업데이트 업무 우선순위 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 우선순위 ajax변경  -Lv2
		@ResponseBody
		@RequestMapping(value="/project/tprilv2")
		public int tprilv2(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.tpriLv2(bno);
				System.out.println(rs+"업데이트 업무 우선순위 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 우선순위 ajax변경  -Lv3
		@ResponseBody
		@RequestMapping(value="/project/tprilv3")
		public int tprilv3(ModelAndView mv,int bno,String pno) {
			int rs =0;
			try {
				rs=taskService.tpriLv3(bno);
				System.out.println(rs+"업데이트 업무 우선순위 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 담당자 변경
		@ResponseBody
		@RequestMapping(value="/project/taskresupdate")
		public int taskResUpdate(ModelAndView mv,int bno,String pno,String taskres) {
			int rs =0;
			TaskDto dto= new TaskDto();
			dto.setBno(bno);
			dto.setTaskmanager(taskres);
			try {
				rs=taskService.tResUpdate(dto);
				System.out.println(rs+"업무 담당자 변경 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 시작일 변경
		@ResponseBody
		@RequestMapping(value="/project/tstartupdate")
		public int tstartUpdate(ModelAndView mv,int bno,String pno,Date tstart) {
			int rs =0;
			TaskDto dto= new TaskDto();
			dto.setBno(bno);
			dto.setTstart(tstart);
			try {
				rs=taskService.tstartUpdate(dto);
				System.out.println(rs+"업무 시작날짜 변경 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//업무 시작일 변경
		@ResponseBody
		@RequestMapping(value="/project/tendupdate")
		public int tendUpdate(ModelAndView mv,int bno,String pno,Date tend) {
			int rs =0;
			TaskDto dto= new TaskDto();
			dto.setBno(bno);
			dto.setTend(tend);
			try {
				rs=taskService.tendUpdate(dto);
				System.out.println(rs+"업무 마지막 날짜 변경 ajax");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return rs;
		}
		//그래프 변경 
		@ResponseBody
		@RequestMapping(value="/project/tstatereport")
		public List<Integer> tstateReport(ModelAndView mv, @RequestParam(name = "pno") String pno) {
			List<Integer> slist = new ArrayList<Integer>();
			try {
				slist=taskService.taskStateList(pno);
				//System.out.println("그래프"+slist);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return slist;
		}
		
		
		
	
}