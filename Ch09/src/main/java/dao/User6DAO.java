package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User6VO;

public class User6DAO extends DBHelper{
	
	private static User6DAO instance = new User6DAO();
	
	public static User6DAO getinstance() {
		return instance;
	}
	
	private User6DAO() {}
	
	public void insertUser6(User6VO vo) {
			
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("INSERT INTO `user6` VALUES(?,?,?,?,?,?,?)");
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getName());
			psmt.setString(3, vo.getDate());
			psmt.setInt(4, vo.getGender());
			psmt.setInt(5, vo.getAge());
			psmt.setString(6, vo.getAddr());
			psmt.setString(7, vo.getHp());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void seleceUser6() {}
	
	public List<User6VO> seleceUser6s() {
		
		List<User6VO> users = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs   = stmt.executeQuery("SELECT * FROM `user6`");
			
			while(rs.next()) {
				User6VO vo = new User6VO();
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setDate(rs.getString(3));
				vo.setGender(rs.getInt(4));
				vo.setAge(rs.getInt(5));
				vo.setAddr(rs.getString(6));
				vo.setHp(rs.getString(7));
				
				users.add(vo);
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return users;
		
	}
	
	public void updateUser6() {}
	
	public void deleteUSer6() {}
}
