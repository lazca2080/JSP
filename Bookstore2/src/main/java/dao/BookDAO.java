package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DBCP;
import vo.BookVO;

public class BookDAO {
	
	private static BookDAO instance = new BookDAO();
	
	public static BookDAO getInstance() {
		return instance;
	}
	
	private BookDAO() {};
	
	public List<BookVO> selectBooks() {
		
		List<BookVO> books = new ArrayList<>();
		
		try {
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM `book`");
			
			while(rs.next()) {
				BookVO bb = new BookVO();
				bb.setId(rs.getString(1));
				bb.setName(rs.getString(2));
				bb.setPub(rs.getString(3));
				bb.setPrice(rs.getString(4));
				
				books.add(bb);
			}
			
			conn.close();
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return books;
	}
	
	public BookVO selectBook(String id) {
		
		BookVO vo = null;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `book` WHERE `bookid`=?");
			psmt.setString(1, id);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new BookVO();
				vo.setId(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setPub(rs.getString(3));
				vo.setPrice(rs.getString(4));
			}
				
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return vo;
	}
	
	public void insertBook(BookVO vo) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("INSERT INTO `book` VALUES(?,?,?,?)");
			psmt.setString(1, vo.getId());
			psmt.setString(2, vo.getName());
			psmt.setString(3, vo.getPub());
			psmt.setString(4, vo.getPrice());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateBook(BookVO vo) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("UPDATE `book` SET `bookname`=?, `publisher`=?, `price`=? WHERE `bookid`=?");
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getPub());
			psmt.setString(3, vo.getPrice());
			psmt.setString(4, vo.getId());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void deleteBook(String id) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("DELETE FROM `book` WHERE `bookid`=?");
			psmt.setString(1, id);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
