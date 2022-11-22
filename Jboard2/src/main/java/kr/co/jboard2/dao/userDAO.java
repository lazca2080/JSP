package kr.co.jboard2.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBCP;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.TermsVO;

public class userDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void insertUser() {}
	
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
	
	public void selectUser() {}
	
	public void selectUsers() {}
	
	public void updateUser() {}
	
	public void deleteUser() {}
	
}
