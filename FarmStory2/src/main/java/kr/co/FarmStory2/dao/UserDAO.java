package kr.co.FarmStory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.FarmStory2.bean.TermsBean;
import kr.co.FarmStory2.bean.UserBean;
import kr.co.FarmStory2.db.DBCP;
import kr.co.FarmStory2.db.Sql;

public enum	UserDAO {
	INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void insertUser() {}
	
	public TermsBean selectTerms() {
		
		TermsBean tb = null;
		
		try {
			logger.info("selectTerms...");

			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM `board_terms`");
			
			if(rs.next()) {
				tb = new TermsBean();
				tb.setTerms(rs.getString(1));
				tb.setPrivacy(rs.getString(2));
			}
			
			conn.close();
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return tb;
	}
	
	public UserBean selectUser(String uid, String pass ) {
		
		UserBean ub = null;
		
		try {
			logger.info("selectUser...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareCall(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				ub = new UserBean();
				ub.setUid(rs.getString(1));
				ub.setPass(rs.getString(2));
				ub.setName(rs.getString(3));
				ub.setNick(rs.getString(4));
				ub.setEmail(rs.getString(5));
				ub.setHp(rs.getString(6));
				ub.setGrade(rs.getInt(7));
				ub.setZip(rs.getString(8));
				ub.setAddr1(rs.getString(9));
				ub.setAddr2(rs.getString(10));
				ub.setRegip(rs.getString(11));
				ub.setRdate(rs.getString(12));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("ub : "+ub);
		
		return ub;
	}
	
	public void selectUsers() {}
	
	public int selectUid(String uid) {
		
		int result = 0;
		
		try {
			logger.info("selectUid...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `board_user` WHERE `uid`=?");
			psmt.setString(1, uid);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = 1;
			}else {
				result = 0;
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public int selectNick(String nick) {
		
		int result = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `board_user` WHERE `nick`=?");
			psmt.setString(1, nick);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = 1;
			}else {
				result = 0;
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
}
