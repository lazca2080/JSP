package kr.co.jboard1.dao;

public class UserDAO {

	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	// 기본 CRUD
	public static void insertUser() {}
	public static void selectUser() {}
	public static void selectUsers() {}
	public static void updateUser() {}
	public static void deleteUser() {}
}
