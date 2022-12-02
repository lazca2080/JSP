package kr.co.farmstory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mysql.cj.protocol.Resultset;

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
			psmt.setString(1, vo.getCate());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getContent());
			psmt.setInt(4, vo.getFname() == null ? 0 : 1);
			psmt.setString(5, vo.getUid());
			psmt.setString(6, vo.getRegip());
			
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
	
	public ArticleVO selectArticle(String no, String cate) {
		
		ArticleVO vo = null;
		
		try {
			logger.debug("selectArticle...");
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt1.setString(1, no);
			psmt1.setString(2, cate);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			conn.commit();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setUid(rs.getString(9));
			}
			
			conn.close();
			psmt1.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public List<ArticleVO> selectArticles(int limitStart, String cate) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.debug("selectArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, limitStart);
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
	
	public List<ArticleVO> searchArticleTitle(String cate, String search, int limitStart) {
		
		List<ArticleVO> searchs = new ArrayList<>();
		
		try {
			logger.debug("searchArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SEARCH_ARTICLES_TITLE);
			psmt.setString(1, cate);
			//psmt.setString(2, option);
			psmt.setString(2, "%"+search+"%");
			psmt.setInt(3, limitStart);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setComment(rs.getInt(3));
				vo.setTitle(rs.getString(5));
				vo.setNick(rs.getString(12));
				vo.setHit(rs.getInt(8));
				vo.setRdate(rs.getString(11).substring(2, 10));
				
				searchs.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return searchs;
	}
	
	public List<ArticleVO> searchArticleContent(String cate, String search, int limitStart) {
		
		List<ArticleVO> searchs = new ArrayList<>();
		
		try {
			logger.debug("searchArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SEARCH_ARTICLES_CONTENT);
			psmt.setString(1, cate);
			//psmt.setString(2, option);
			psmt.setString(2, "%"+search+"%");
			psmt.setInt(3, limitStart);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setComment(rs.getInt(3));
				vo.setTitle(rs.getString(5));
				vo.setNick(rs.getString(12));
				vo.setHit(rs.getInt(8));
				vo.setRdate(rs.getString(11).substring(2, 10));
				
				searchs.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return searchs;
	}
	
	public List<ArticleVO> searchArticleComment(String cate, String search, int limitStart) {
		
		List<ArticleVO> searchs = new ArrayList<>();
		
		try {
			logger.debug("searchArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SEARCH_ARTICLES_COMMENT);
			psmt.setString(1, cate);
			//psmt.setString(2, option);
			psmt.setString(2, "%"+search+"%");
			psmt.setInt(3, limitStart);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setComment(rs.getInt(3));
				vo.setTitle(rs.getString(5));
				vo.setNick(rs.getString(12));
				vo.setHit(rs.getInt(8));
				vo.setRdate(rs.getString(11).substring(2, 10));
				
				searchs.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return searchs;
	}
	
	public List<ArticleVO> searchArticleNick(String cate, String search, int limitStart) {
		
		List<ArticleVO> searchs = new ArrayList<>();
		
		try {
			logger.debug("searchArticles...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SEARCH_ARTICLES_NICK);
			psmt.setString(1, cate);
			//psmt.setString(2, option);
			psmt.setString(2, "%"+search+"%");
			psmt.setInt(3, limitStart);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setComment(rs.getInt(3));
				vo.setTitle(rs.getString(5));
				vo.setNick(rs.getString(12));
				vo.setHit(rs.getInt(8));
				vo.setRdate(rs.getString(11).substring(2, 10));
				
				searchs.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return searchs;
	}
	
	public List<ArticleVO> selectLatest(String cate1, String cate2, String cate3) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.debug("selectLatest...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_LATEST);
			psmt.setString(1, cate1);
			psmt.setString(2, cate2);
			psmt.setString(3, cate3);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setRdate(rs.getString(3).substring(2, 10));
				
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
	
	public List<ArticleVO> selectLatest2(String cate) {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.debug("selectLatest...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_LATEST2);
			psmt.setString(1, cate);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setRdate(rs.getString(3).substring(2, 10));
				
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
	
	public void updateArticle(String no, String title, String content, String cate) {
		
		try {
			logger.debug("updateArticle...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.setString(4, cate);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public void deleteArticle(String no, String cate) {
		try {
			logger.debug("deleteArticle...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.setString(3, cate);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public List<ArticleVO> getLatests(String cate) {
		
		List<ArticleVO> latests = new ArrayList<>();
		
		try {
			logger.debug("getLatests...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_GET_LATESTS);
			psmt.setString(1, cate);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				
				latests.add(vo);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return latests;
	}
	
	public int listTotalNum(String cate) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL);
			psmt.setString(1, cate);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return total;
	}
	
	public int titleTotalNum(String cate, String option) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_TITLE);
			psmt.setString(1, cate);
			psmt.setString(2, option);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return total;
	}
	
	public int contentTotalNum(String cate, String option) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_CONTENT);
			psmt.setString(1, cate);
			psmt.setString(2, option);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return total;
	}
	
	public int commentTotalNum(String cate, String option) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_COMMENT);
			psmt.setString(1, cate);
			psmt.setString(2, option);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return total;
	}
	
	public int nickTotalNum(String cate, String option) {
		
		logger.debug("pageNum...");
		
		int total = 0;
		
		// 전체 게시물 갯수 구하기
		try {
			logger.debug("selectCountTotal...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_NICK);
			psmt.setString(1, cate);
			psmt.setString(2, option);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
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
			psmt1.setString(5, comment.getCate());
			
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
	
	public int[] deleteComment(String no, String parent) {
		
		int comment = 0;
		int total = 0;
		
		try {
			logger.debug("deleteComment...");
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.DELETE_COMMENT);
			psmt1.setString(1, no);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_MINUS);
			psmt2.setString(1, parent);
			PreparedStatement psmt3 = conn.prepareStatement(Sql.SELECT_COMMENTS_TOTAL);
			psmt3.setString(1, parent);
			
			comment = psmt1.executeUpdate();
			psmt2.executeUpdate();
			ResultSet rs = psmt3.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			conn.commit();
			
			conn.close();
			psmt1.close();
			psmt2.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			
		}
		
		int[] result = {comment, total};
		
		return result;
	}
	
	public int updateComment(String content, String no) {
		
		int result = 0;
		
		try {
			logger.debug("updateComment...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
			result = psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return result;
	}
}
