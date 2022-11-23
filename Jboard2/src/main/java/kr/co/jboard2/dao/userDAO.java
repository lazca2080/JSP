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
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.UserVO;

public class userDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void insertUser(UserVO vo) {
		
		try {
			logger.debug("insertUser...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_USER);
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getPass());
			psmt.setString(3, vo.getName());
			psmt.setString(4, vo.getNick());
			psmt.setString(5, vo.getEmail());
			psmt.setString(6, vo.getHp());
			psmt.setString(7, vo.getZip());
			psmt.setString(8, vo.getAddr1());
			psmt.setString(9, vo.getAddr2());
			psmt.setString(10, vo.getRegip());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public TermsVO selectTerms() {
		
		TermsVO vo = null;
		
		try {
			logger.info("selectTerms...");
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_TERMS);
			
			if(rs.next()) {
				vo = new TermsVO();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			
			conn.close();
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return vo;
	}
	
	public UserVO selectUser(String uid, String pass) {
		
		UserVO vo = null;
		
		try {
			logger.debug("selectUser...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return vo;
		
	}
	
	public UserVO selectUserForFindId(String name, String email) {
		
		UserVO vo = null;
		
		try {
			logger.debug("selectUserfForFindId...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_USER_FOR_FINDID);
			psmt.setString(1, name);
			psmt.setString(2, email);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(3));
				vo.setEmail(rs.getString(5));
				vo.setRdate(rs.getString(12));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return vo;
	}
	
	public UserVO selectUserForFindPw(String uid, String email) {
		
		UserVO vo = null;
		
		try {
			logger.debug("selectUserfForFindId...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_USER_FOR_FINDPW);
			psmt.setString(1, uid);
			psmt.setString(2, email);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return vo;
	}
	
	public void selectUsers() {}
	
	public void updateUser() {}
	
	public int updateUserPassword(String pass, String uid) {
		
		int result = 0;
		
		try {
			logger.debug("updateUserPassword...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_USER_PASSWORD);
			psmt.setString(1, pass);
			psmt.setString(2, uid);
			
			result = psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return result;
	}
	
	public void deleteUser() {}
	
	public int findId(String name, String email) {
		
		int result = 0;
		
		try {
			logger.debug("findId...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FINDID);
			psmt.setString(1, name);
			psmt.setString(2, email);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public int checkUid(String uid) {
		
		int result = 0;
		
		try {
			logger.debug("checkUid...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_UID);
			psmt.setString(1, uid);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return result;
		
	}
	
	public int checkNick(String nick) {
		
		int result = 0;
		
		try {
			logger.debug("checkNick...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return result;
	}

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
	
	public void selectArticle() {}
	
	public List<ArticleVO> selectArticles() {
		
		List<ArticleVO> articles = new ArrayList<>();
		
		try {
			logger.debug("selectArticles...");
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_ARTICLES);
			
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
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return articles;
	}

}
