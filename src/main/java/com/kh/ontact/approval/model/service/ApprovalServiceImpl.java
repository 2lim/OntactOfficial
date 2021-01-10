package com.kh.ontact.approval.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.ontact.approval.model.dao.ApprovalDao;
import com.kh.ontact.approval.model.dto.ApprovalDto;


@Service("ApproService")
@Repository
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private ApprovalDao apDao;
	
	@Override
	public void insertApproval(ApprovalDto dto) throws Exception{
		apDao.insertApproval(dto);
	}

}