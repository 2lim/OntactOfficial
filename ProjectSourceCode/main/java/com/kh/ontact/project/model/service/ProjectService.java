package com.kh.ontact.project.model.service;

import java.util.HashMap;
import java.util.List;

import com.kh.ontact.project.model.dto.ProjectDto;
import com.kh.ontact.projectDept.model.dto.ProjectDeptDto;
import com.kh.ontact.projectMember.model.dto.ProjectMemberDto;

public interface ProjectService {
	//프로젝트 전체 목록 : 프로젝트명, 공개여부
	public List<ProjectDto> selectListProject(HashMap<String, String> paramMap) throws Exception;
	List<ProjectDto> selectListProject2(HashMap<String, String> paramMap) throws Exception;
	//프로젝트 목록 : 회사
	public ProjectDto selectOneCompany(String uno) throws Exception;
	
	//프로젝트 목록 : 부서
	public ProjectDto selectOneTeam(HashMap<String, String> paramMap) throws Exception;
	
	//프로젝트 생성
	public void insertProject(ProjectDto pj, ProjectMemberDto pjm, List<ProjectDeptDto> pjdlist) throws Exception;
	
	//미보관 프로젝트
	public List<ProjectDto> selectListPjUns(HashMap<String, String> paramMap) throws Exception;
	
	//읽지않음 프로젝트
	public List<ProjectDto> selectListPjUnread(HashMap<String, String> paramMap) throws Exception;

	// 부서별 보관함 프로젝트 목록
	public List<ProjectDto> selectListPjTeam(HashMap<String, String> paramMap) throws Exception;

	
	// 회사 프로젝트 pno 불러오기
	public String SelectCompanyPno(String cno) throws Exception;
	// 프로젝트명, 프로젝트 글 수 불러오기
	public ProjectDto SelectProName(String pno) throws Exception;
	// 프로젝트 삭제
	public int deleteProject(String pno) throws Exception;
	
}
