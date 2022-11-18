package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DBCP;
import vo.BookVO;
import vo.CustomerVO;

public class CustomerDAO {
	
	private static CustomerDAO instance = new CustomerDAO();
	
	public static CustomerDAO getInstance() {
		return instance;
	}
	
	private CustomerDAO() {};
	
	public List<CustomerVO> selectCustomers() {
		
		List<CustomerVO> customers = new ArrayList<>();
		
		try {
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
			
			while(rs.next()) {
				CustomerVO vo = new CustomerVO();
				vo.setId(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setAddr(rs.getString(3));
				vo.setHp(rs.getString(4));
				
				customers.add(vo);
			}
			
			conn.close();
			stmt.close();
			rs.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return customers;
		
	}
	
	public CustomerVO selectCustomer(String id) {
		
		CustomerVO vo = null;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `customer` WHERE `custId`=?");
			psmt.setString(1, id);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new CustomerVO();
				vo.setId(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setAddr(rs.getString(3));
				vo.setHp(rs.getString(4));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public void insertCustomer(CustomerVO vo) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("INSERT INTO `customer` (`name`,`address`,`phone`) VALUES (?,?,?)");
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddr());
			psmt.setString(3, vo.getHp());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void updateCustomer(CustomerVO vo) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("UPDATE `customer` SET `name`=?, `address`=?, `phone`=? WHERE `custId`=?");
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddr());
			psmt.setString(3, vo.getHp());
			psmt.setString(4, vo.getId());
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void deleteCustomer(String id) {
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement("DELETE FROM `customer` WHERE `custId`=?");
			psmt.setString(1, id);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
