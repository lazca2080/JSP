package dao;

import bean.TermsBean;
import bean.UserBean;
import db.DBHelper;

public class UserDAO extends DBHelper{
	
	private static UserDAO instance = new UserDAO();
	
	public static UserDAO getinstance() {
		return instance;
	}
	
	private UserDAO() {}
	
	public TermsBean selectTerms() {
		
		TermsBean tb = new TermsBean();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs   = stmt.executeQuery("SELECT * FROM `board_terms`");
			
			if(rs.next()) {
				tb.setTerms(rs.getString(1));
				tb.setPrivacy(rs.getString(2));
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tb;
	}
	
	public void insertUser(UserBean ub) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("INSERT INTO `board_user` VALUSE (?,?,?,?,?,?,?,?,?,?,?,?)");
			psmt.setString(1, ub.getUid());
			psmt.setString(2, ub.getPass());
			psmt.setString(3, ub.getName());
			psmt.setString(4, ub.getNick());
			psmt.setString(5, ub.getEmail());
			psmt.setString(6, ub.getHp());
			psmt.setInt(7, ub.getGrade());
			psmt.setString(8, ub.getZip());
			psmt.setString(9, ub.getAddr1());
			psmt.setString(10, ub.getAddr2());
			psmt.setString(11, ub.getRegip());
			psmt.setString(12, ub.getRdate());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void checkUid() {
		
		
	}
	
	public int checkNick(String uid) {
		
		int result = 0;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("SELECT * FROM `board_user` WHERE `uid`=?");
			psmt.setString(1, uid);
			rs   = psmt.executeQuery();
			
			if(rs.next()) {
				result = 1;
			}else {
				result = 0;
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
