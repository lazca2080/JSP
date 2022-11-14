package dao;

import java.util.ArrayList;
import java.util.List;
import db.DBHelper;
import vo.User5VO;

public class User5DAO extends DBHelper{
	
	private static User5DAO instance = new User5DAO();
	public static User5DAO getinstatance() {
		return instance;
	}
	
	private User5DAO() {}
	
	public void insertUser5(User5VO vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("INSERT INTO `user5` VALUES (?,?,?,?,?,?)");
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getName());
			psmt.setString(3, vo.getDate());
			psmt.setString(4, vo.getAge());
			psmt.setString(5, vo.getAddress());
			psmt.setString(6, vo.getHp());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public User5VO selectUser5(String uid) {
		
		User5VO vo = new User5VO();
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("SELECT * FROM `user5` WHERE `uid`=?");
			psmt.setString(1, uid);
			rs   = psmt.executeQuery();
			
			if(rs.next()) {
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setDate(rs.getString(3));
				vo.setAge(rs.getString(4));
				vo.setAddress(rs.getString(5));
				vo.setHp(rs.getString(6));
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
		
	}
	
	public List<User5VO> selectUser5s() {
		
		List<User5VO> users = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs   = stmt.executeQuery("SELECT * FROM `user5`");
			
			while(rs.next()) {
				User5VO vo = new User5VO();
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setDate(rs.getString(3));
				vo.setAge(rs.getString(4));
				vo.setAddress(rs.getString(5));
				vo.setHp(rs.getString(6));
				
				users.add(vo);
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return users;
		
	}
	
	public void updateUser5() {}
	
	public void deleteUser5() {}

}
