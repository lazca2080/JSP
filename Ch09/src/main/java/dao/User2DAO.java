package dao;

import db.DBHelper;
import vo.User2VO;

public class User2DAO extends DBHelper{
	
	private static User2DAO instance = new User2DAO();
	
	public static User2DAO getinstance() {
		return instance;
	}
	
	private User2DAO() {}
	
	public void insertUser2(User2VO vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("INSERT INTO `user2` VALUES(?,?,?,?)");
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getName());
			psmt.setString(3, vo.getHp());
			psmt.setInt(4, vo.getAge());
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void selectUser2() {
		
	}
	
	public void selectUser2s() {
		
	}
	
	public void updateUser2() {
		
	}
	
	public void deleteUser2() {
		
	}
	
}
