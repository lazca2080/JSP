package kr.co.jboard2.service.article;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.articleDAO;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.PagenumVO;

public enum ArticleService {
	
	INSTANCE;
	private articleDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private ArticleService() { dao = new articleDAO(); }
	
	public void insertArticle(ArticleVO vo) {
		dao.insertArticle(vo);
	}
	
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	
	public List<ArticleVO> selectArticles(int limitStart) {
		return dao.selectArticles(limitStart);
	}
	
	public void updateArticle() {}
	
	public PagenumVO pageNum(String pg) {
		return dao.pageNum(pg);
	}
}
