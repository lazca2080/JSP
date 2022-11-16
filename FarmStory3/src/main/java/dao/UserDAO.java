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
			String sql = "INSERT INTO `board_user` set ";
				sql	+= "`uid`=?,";
				sql	+= "`pass`=SHA2(?, 256),";
				sql	+= "`name`=?,";
				sql	+= "`nick`=?,";
				sql	+= "`email`=?,";
				sql	+= "`hp`=?,";
				sql	+= "`zip`=?,";
				sql	+= "`addr1`=?,";
				sql	+= "`addr2`=?,";
				sql	+= "`regip`=?,";
				sql	+= "`rdate`=NOW()";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, ub.getUid());
			psmt.setString(2, ub.getPass());
			psmt.setString(3, ub.getName());
			psmt.setString(4, ub.getNick());
			psmt.setString(5, ub.getEmail());
			psmt.setString(6, ub.getHp());
			psmt.setString(7, ub.getZip());
			psmt.setString(8, ub.getAddr1());
			psmt.setString(9, ub.getAddr2());
			psmt.setString(10, ub.getRegip());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void checkUid() {
		
		
	}
	
	public int checkUid(String uid) {
		
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

	public int checkNick(String nick) {
		
		int result = 0;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("SELECT * FROM `board_user` WHERE `nick`=?");
			psmt.setString(1, nick);
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

	public UserBean checkLogin(String uid, String pass) {
		
		UserBean ub = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("SELECT * FROM `board_user` WHERE `uid`=? && `pass`= SHA2(?, 256)");
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs   = psmt.executeQuery();
			
			if(rs.next()) {
				ub = new UserBean();
				ub.setUid(rs.getString(1));
				ub.setPass(rs.getString(2));
				ub.setName(rs.getString(3));
				ub.setNick(rs.getString(4));
				ub.setEmail(rs.getString(5));
				ub.setHp(rs.getString(6));
				ub.setGrade(rs.getString(7));
				ub.setZip(rs.getString(8));
				ub.setAddr1(rs.getString(9));
				ub.setAddr2(rs.getString(10));
				ub.setRegip(rs.getString(11));
				ub.setRdate(rs.getString(12));
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ub;
		
	}
	
}
