package kr.co.jboard2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBCP;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.PagenumVO;

public class articleDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private articleDAO dao;
	
	public void insertArticle(ArticleVO vo) {
		
		try {
			logger.debug("insertArticle...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setInt(3, vo.getFile());
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public ArticleVO selectArticle(String no) {
		
		ArticleVO vo = null;
		
		try {
			logger.debug("selectArticle...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public List<ArticleVO> selectArticles(int limitStart) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.debug("selectArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, limitStart);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setComment(rs.getInt(3));
				vo.setTitle(rs.getString(5));
				vo.setNick(rs.getString(12));
				vo.setHit(rs.getInt(8));
				vo.setRdate(rs.getString(11).substring(2, 10));
				
				articles.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return articles;
	}

	public PagenumVO pageNum(String pg) {
		
		logger.debug("pageNum...");
		
		int limitStart = 0;       // SQL Limit ?, 10의 ?값 시작값
		int currentPg = 1;        // 현재 페이지 값 로그인페이지에서 넘어올시 첫화면으로 표시하기 위해 1값
		int total = 0;            // 전체 게시글 수
		int lastPageNum = 0;      // 마지막 페이지 값
		int pageGroupCurrent = 1; // 현재 페이지 그룹
		int pageGroupStart = 1;   // 시작 페이지 그룹값
		int pageGroupEnd = 0;     // 마지막 페이지 그룹값
		int pageStartNum = 0;     // 이전 or 다음 버튼 클릭시 시작되는 페이지 그룹 번호
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		// 페이지 마지막 번호 계산
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = (total / 10) + 1;
		}
		
		// 현재 페이지 게시물 limit 시작값 계산
		if(pg != null){
			currentPg = Integer.parseInt(pg);
			// pg를 받아올때 로그인페이지에서 바로 넘어오는 경우 null이기 때문에 null 체크를 해준다
		}
		
		limitStart = (currentPg - 1) * 10;
		
		// 페이지 그룹 계산
		pageGroupCurrent =  (int)Math.ceil(currentPg / 10.0);
		pageGroupStart = (pageGroupCurrent-1) * 10 + 1;
		pageGroupEnd = pageGroupCurrent * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		// 페이지 시작 번호 계산
		pageStartNum = (total - limitStart)+1;
		
		PagenumVO vo = new PagenumVO();
		vo.setLimitStart(limitStart);
		vo.setCurrentPg(currentPg);
		vo.setTotal(total);
		vo.setLastPageNum(lastPageNum);
		vo.setPageGroupCurrent(pageGroupCurrent);
		vo.setPageGroupStart(pageGroupStart);
		vo.setPageGroupEnd(pageGroupEnd);
		vo.setPageStartNum(pageStartNum);
		
		return vo;
	}
}
