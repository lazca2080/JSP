package kr.co.farmstory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBCP;
import kr.co.farmstory2.db.Sql;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;

public class articleDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private articleDAO dao;
	
	public int insertArticle(ArticleVO vo) {
		
		int parent = 0;
		
		try {
			logger.debug("insertArticle...");
			
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			Statement stmt = conn.createStatement();
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setInt(3, vo.getFname() == null ? 0 : 1);
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
			psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			conn.commit();
			
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return parent;
		
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try {
			logger.debug("insertFile...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			
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
				vo.setNo(rs.getInt(1));
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

	public FileVO selectFile(String no) {
		
		FileVO vo = null;
		
		try {
			logger.debug("selectFile...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, no);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new FileVO();
				vo.setFno(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setNewName(rs.getString(3));
				vo.setOriName(rs.getString(4));
				vo.setDownload(rs.getInt(5));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public void updateArticle(String no, String title, String content) {
		
		try {
			logger.debug("updateArticle...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public int listTotalNum(String pg) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
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
		
		return total;
	}
	
	public ArticleVO insertComment(ArticleVO comment) {
		ArticleVO vo = null;
		int result = 0;
		try{
			logger.info("insertComment");
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.INSERT_COMMENT);
			psmt1.setInt(1, comment.getParent());
			psmt1.setString(2, comment.getContent());
			psmt1.setString(3, comment.getUid());
			psmt1.setString(4, comment.getRegip());
			
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_PLUS);
			psmt2.setInt(1, comment.getParent());
			
			Statement stmt = conn.createStatement();
			
			psmt2.executeUpdate();
			result = psmt1.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			conn.commit();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getString(2));
				vo.setContent(rs.getString(6));
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
			}
			
			rs.close();
			stmt.close();
			conn.close();
			psmt1.close();
			psmt2.close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		
		return vo;
	}

	public List<ArticleVO> selectCommentList(String no) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.info("selectCommentList...");
			
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, no);
			ResultSet rs   = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getString(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11).substring(2, 10));
				ab.setNick(rs.getString(12));
				
				articles.add(ab);			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return articles;
	}
}
