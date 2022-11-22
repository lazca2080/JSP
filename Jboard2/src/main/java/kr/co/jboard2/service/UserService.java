package kr.co.jboard2.service;

import kr.co.jboard2.dao.userDAO;
import kr.co.jboard2.vo.TermsVO;

public enum UserService {
	
	INSTANCE;
	private userDAO dao;
	
	private UserService() { dao = new userDAO(); }
	
	public void insertUser() {}
	
	public TermsVO selectTerms() {
		return dao.selectTerms();
	}
}
