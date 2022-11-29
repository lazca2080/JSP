package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.userDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.TermsVO;

public enum UserService {
	
	INSTANCE;
	private userDAO dao;
	
	private UserService() { dao = new userDAO(); }
	
	public void insertUser() {}
	
	public TermsVO selectTerms() {
		return dao.selectTerms();
	}
	
	public int insertArticle(ArticleVO vo) {
		return dao.insertArticle(vo);
	}
	
	public void selectArticle() {}
	
	public List<ArticleVO> selectArticles() {
		return dao.selectArticles();
	}
	
	public void updateArticle() {}
}
