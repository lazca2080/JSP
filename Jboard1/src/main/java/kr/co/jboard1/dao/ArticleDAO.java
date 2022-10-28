package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.bean.FileBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.Sql;

// DAO(Data Access Object) : 데이터베이스 처리 클래스
public class ArticleDAO {
	
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	
	private ArticleDAO() {}
	
	// 기본 CRUD
	public int insertArticle(ArticleBean article) {
		
		int parent = 0;
		
		try{
			Connection conn = DBCP.getConnection();
			// 트랜젝션 시작
			conn.setAutoCommit(false);
			
			PreparedStatement  psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			Statement stmt = conn.createStatement();
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFname() == null ? 0 : 1);
			psmt.setString(4, article.getUid());
			psmt.setString(5, article.getRegip());
			
			psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			
			// 작업 확정
			conn.commit();
			
			
			if(rs.next()){
				parent = rs.getInt(1);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			stmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return parent;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int selectCountTotal() {
		
		int total = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			rs.close();
			conn.close();
			stmt.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
	
	public ArticleBean selectArticle(String no) {
		
		ArticleBean ab = null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setFno(rs.getInt(12));
				ab.setPno(rs.getInt(13));
				ab.setNewName(rs.getString(14));
				ab.setOriName(rs.getString(15));
				ab.setDownload(rs.getInt(16));
			}
			
			
			conn.close();
			psmt.close();
			rs.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return ab;
	}
	
	public List<ArticleBean> selectArticles(int limitStart) {
		
		List<ArticleBean> article = new ArrayList<>();
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, limitStart);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				
				article.add(ab);
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return article;
	}
	
	public FileBean selectFile(String parent) {
		
		FileBean fb = null;
		
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, parent);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
			}
			
			conn.close();
			psmt.close();
			rs.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return fb;
	}
	
	public void updateArticle() {
		
	}
	
	public void updateArticleHit(String no) {
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void updateFileDownload(int fno) {
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setInt(1, fno);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}
	
	public void deleteArticle() {
		
	}
}
