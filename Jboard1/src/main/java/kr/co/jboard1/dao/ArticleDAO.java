package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonObject;

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
	
	public ArticleBean insertComment(ArticleBean comment) {
		
		ArticleBean article = null;
		int result = 0;
		try{
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			Statement stmt = conn.createStatement();
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			
			result = psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			conn.commit();
			
			if(rs.next()) {
				article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setContent(rs.getString(6));
				article.setRdate(rs.getString(11).substring(2, 10));
				article.setNick(rs.getString(12));
			}
			
			rs.close();
			stmt.close();
			conn.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return article;
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
	
	public List<ArticleBean> selectComments(String parent) {
		List<ArticleBean> comments = new ArrayList<>();
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean comment = new ArticleBean();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString(11));
				comment.setNick(rs.getString(12));
				
				comments.add(comment);
			}
			conn.close();
			psmt.close();
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return comments;
		
	}
	
	public void selectComment() {
		
	}
	
	public void updateArticle(String title, String content, String no) {
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
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
	
	public int updateComment(String no, String content) {
		
		int result = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
			result = psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void deleteArticle(String no) {

		try {
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			
			conn.close();
			psmt.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String deleteFile(String no) {
		
		String newName = null;
		
		try {
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_FILE);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.DELETE_FILE);
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt1.executeQuery(); 
			psmt2.executeUpdate();
			
			conn.commit();
			
			if(rs.next()) {
				newName = rs.getString(3);
			}
			
			conn.close();
			psmt1.close();
			psmt2.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return newName;
	}
	
	public int deleteComment(String no) {
		
		int result = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			psmt.setString(1, no);
			
			result = psmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
