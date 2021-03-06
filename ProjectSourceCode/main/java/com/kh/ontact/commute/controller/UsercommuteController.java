package com.kh.ontact.commute.controller;

import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.ontact.commute.model.dto.CommuteDto;
import com.kh.ontact.commute.model.service.CommuteService;
import com.kh.ontact.users.model.dto.CustomUserDetails;
import com.google.gson.Gson;

@Controller
public class UsercommuteController {
	
	@Autowired
	private CommuteService commuteServ;
	public static final int LIMIT = 10;
	
//	출퇴근 메인페이지
	@RequestMapping(value = "/commute/dailylist", method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView selectDailCommute(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "cstate", required = false) String cstate,
			@RequestParam(name = "startdate", required = false) String startdate,
			@RequestParam(name = "enddate", required = false) String enddate,
			Authentication authentication, HttpServletRequest request, ModelAndView mv) {
		System.out.println("출퇴근 리스트진입");
		try {
			//세션값
			CustomUserDetails userdetail = (CustomUserDetails) authentication.getPrincipal();
			String uno=userdetail.getUno();
			System.out.println(uno);
			
			//검색
			String state = cstate;
			
			String start =  startdate;
			
			String end = enddate;
			
		
			HashMap<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("cstate", state);
			paramMap.put("startdate", start);
			paramMap.put("enddate", end);
			paramMap.put("uno", uno);
			
			//페이징
			int currentPage = page;
			int listCount1 = commuteServ.allListCount(uno);
			int listCount2 = commuteServ.listCount(paramMap);
			int maxPage1 = (int) ((double) listCount1 / LIMIT + 0.9);
			int maxPage2 = (int) ((double) listCount2 / LIMIT + 0.9);
			System.out.println(listCount1);
			System.out.println(listCount2);
		    
			if (startdate == null || startdate == "" && enddate == null || enddate == "" && cstate == null || cstate == "") {
				System.out.println("if로 들어옴");
				mv.addObject("list", commuteServ.selectDailyCommute(currentPage, LIMIT, uno));
				mv.addObject("currentPage", currentPage);
				mv.addObject("maxPage", maxPage1);
				mv.addObject("listCount", listCount1);
				mv.setViewName("commute/dailycommute");
			} else if(startdate != null || startdate != "" && enddate != null || enddate != "" && cstate != null || cstate != "") {
				System.out.println("else로 들어옴");
				mv.addObject("currentPage", currentPage);
				mv.addObject("maxPage", maxPage2);
				mv.addObject("listCount", listCount2);
				mv.addObject("list", commuteServ.searchDailyCommute(paramMap));
				mv.setViewName("commute/dailycommute");
			}
//			if (paramMap != null && !paramMap.equals("")) {
//				mv.addObject("list", commuteServ.searchDailyCommute(paramMap));
//			} else {
//				mv.addObject("list", commuteServ.selectDailyCommute(currentPage, LIMIT));
//				mv.addObject("currentPage", currentPage);
//				mv.addObject("maxPage", maxPage);
//				mv.addObject("listCount", listCount);
//				mv.setViewName("user/commute/dailycommute");
//			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("errorPage");
		}
		return mv;
	}
	//qr 새창 띄우기
	@RequestMapping(value = "/commute/qrenter", method = RequestMethod.GET)
	public ModelAndView qrenter(ModelAndView mv) {
		System.out.println("스캐너호출");
		mv.setViewName("commute/qrenter");
		return mv;
	}
	@RequestMapping(value = "/commute/qrleave", method = RequestMethod.GET)
	public ModelAndView qrscanner(ModelAndView mv) {
		System.out.println("스캐너호출");
		mv.setViewName("commute/qrleave");
		return mv;
	}
	
	//QR 인서트 - 출근
	@RequestMapping(value = "/commute/enter", method = RequestMethod.GET)
	public String insertEnter(CommuteDto c, Authentication authentication,
			HttpServletRequest request, RedirectAttributes rttr) {
		try {
			System.out.println("인서트진입");
			
			CustomUserDetails userdetail = (CustomUserDetails) authentication.getPrincipal();
		    
		    String uname=userdetail.getUname();
		    
		    
			String enterInfo = request.getParameter("enterInfo");
			System.out.println(enterInfo);
			String [] array = enterInfo.split(",");
		
			for(int i=0; i<array.length; i++) {
				System.out.println(array[i]);
			}

			String cstarttime = array[0];
			String dno = array[1];
			String uno = array[2];
			
			c.setUno(uno);
			c.setCstarttime(cstarttime);
			c.setDname(dno);
			
			//QR시간
			String day1 = array[0]; 
			java.sql.Timestamp t1 = java.sql.Timestamp.valueOf(day1);
			System.out.println("결과확인 " + t1);
			
			//기준시간
			String day2 = "2021-01-01 09:01:00"; // 형식을 지켜야 함
			java.sql.Timestamp t2 = java.sql.Timestamp.valueOf(day2);
			System.out.println("결과확인 " + t2);
			
			SimpleDateFormat sdf = new SimpleDateFormat("HHmm"); 
			
			String s1 = sdf.format(t1);
			String s2 = sdf.format(t2);
			int qrT = Integer.parseInt(s1);
			int standardT = Integer.parseInt(s2);
			
			System.out.println("qrT " + qrT );
			System.out.println("standardT " + standardT);
			if(qrT > standardT) {
				System.out.println("aaa로 ");
				int state = 1;
				c.setCstate(state);
				c.setCreason("지각");
				System.out.println("지각");
			} else {
				System.out.println("bbb로 ");
				int state = 0;
				c.setCstate(state);
				System.out.println("정상출근");
			}
			
			commuteServ.insertEnter(c);
			rttr.addFlashAttribute("message", "window.open(\"about:blank\", \"_self\").close();");
			rttr.addFlashAttribute("alert", "alert(\"출근이 인증되었습니다.\");");
		} catch(Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", e.getMessage());
			return "redirect:erropage";
		}
		return "redirect:qrenter";
	}
	
	//QR 인서트 - 퇴근
	@RequestMapping(value = "/commute/leave", method = RequestMethod.GET)
	public String updateLeave(CommuteDto c, HttpServletRequest request, RedirectAttributes rttr) {
		try {
			System.out.println("퇴근인서트진입");
			String enterInfo = request.getParameter("enterInfo");
			System.out.println(enterInfo);
			String [] array = enterInfo.split(",");

			for(int i=0; i<array.length; i++) {
				System.out.println(array[i]);
			}
			String cendtime = array[0];
			System.out.println("aa" + cendtime);
			String dno = array[1];
			System.out.println("bb" + cendtime);
			String uno = array[2];
			System.out.println(" cc" + uno);
			c.setCendtime(cendtime);
			c.setUname(uno);
			
			commuteServ.updateLeave(c);
			rttr.addFlashAttribute("message", "window.open(\"about:blank\", \"_self\").close();");
			rttr.addFlashAttribute("alert", "alert(\"퇴근이 인증되었습니다.\");");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", e.getMessage());
			return "redirect:erropage";
		}
		return "redirect:qrleave";
	}
	//
	//월근무내역
	@RequestMapping(value = "/commute/monthlylist", method = RequestMethod.GET)
	public ModelAndView selectMonthCommute(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "startdate", required = false) String startdate,
			@RequestParam(name = "enddate", required = false) String enddate,
			Authentication authentication, HttpServletRequest request, ModelAndView mv) {
		
		System.out.println("월근무 리스트진입");
		
		try {
			//세션값
			CustomUserDetails userdetail = (CustomUserDetails) authentication.getPrincipal();
			String uno=userdetail.getUno();
			System.out.println(uno);
			// 한 페이지당 출력할 목록 갯수, 페이징
			int currentPage = page;

			//검색
			String start =  startdate;
			System.out.println("start" + start);
			String end = enddate;
			System.out.println("end" + end);
			
			HashMap<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("uno", uno);
			paramMap.put("startdate", start);
			paramMap.put("enddate", end);

			int allListCount = commuteServ.mAllCount(uno);
			System.out.println("카운트1 : " + allListCount);
			int allmaxPage = (int) ((double) allListCount / LIMIT + 0.9);
			
			int searchListCount = commuteServ.msearchCount(paramMap);
			System.out.println("카운트2 : " + searchListCount);
			int searchmaxPage = (int) ((double) searchListCount / LIMIT + 0.9);
			
			//
			if (startdate == null && enddate == null) {
				System.out.println("if로 들어옴");
				mv.addObject("list", commuteServ.selectMonthCommute(currentPage, LIMIT, uno));
				System.out.println("결과 확인 : "+ commuteServ.selectMonthCommute(currentPage, LIMIT, uno));
				mv.addObject("currentPage", currentPage);
				mv.addObject("maxPage", allmaxPage);
				mv.addObject("listCount", allListCount);
				mv.setViewName("commute/monthcommute");
			} else if(startdate != null && enddate != null) {
				System.out.println("else로 들어옴");
				mv.addObject("list", commuteServ.searchMonthCommute(paramMap));
				System.out.println("결과 확인 : " + commuteServ.searchMonthCommute(paramMap));
				mv.addObject("currentPage", currentPage);
				mv.addObject("maxPage", searchmaxPage);
				mv.addObject("listCount", searchListCount);
				mv.setViewName("commute/monthcommute");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("errorPage");
		}
		return mv;
	}
	@ResponseBody
	@RequestMapping(value = "/commute/getDailyCommute", method = RequestMethod.GET)
    public String getDailyVisitor(String month, Authentication authentication){
		//세션값
		CustomUserDetails userdetail = (CustomUserDetails) authentication.getPrincipal();
	    String uno=userdetail.getUno();
	    
		String cooContractNo = uno;
        System.out.println(cooContractNo);
        Gson gson = new Gson();
        HashMap<String,String> map = new HashMap<String,String>();
        map.put("month", month);

        List<CommuteDto> list= commuteServ.testCommute(uno);
        System.out.println("여기" + list);
        return gson.toJson(list);
    }
	
}

