<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// multipart 폼 데이터 수신
	String savePath = application.getRealPath("/file");
	int maxSize = 1024 * 1024 * 10;
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
												//요청 ,  저장 경로,  파일 크기, 인코딩,       ??

	String title   = mr.getParameter("title");
	String content = mr.getParameter("content");
	String uid     = mr.getParameter("uid");
	String fname   = mr.getFilesystemName("fname");
	String regip   = request.getRemoteAddr();
	Connection conn        = null;
	PreparedStatement psmt = null;
	Statement stmt         = null;
	int parent = 0;
	
	//System.out.println("fname : "+fname);
	
	try{
		conn = DBCP.getConnection();
		// 트랜젝션 시작
		conn.setAutoCommit(false);
		
		psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
		stmt = conn.createStatement();
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setInt(3, fname == null ? 0 : 1);
		psmt.setString(4, uid);
		psmt.setString(5, regip);
		
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
	
	// 파일을 첨부했으면
	if(fname != null){
		
		// 파일명 수정
		int i = fname.lastIndexOf(".");
		String ext = fname.substring(i);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newName = now+uid+ext; // 20221026160425_pjh9527.txt
		
		File f1 = new File(savePath+"/"+fname);
		File f2 = new File(savePath+"/"+newName);
		
		f1.renameTo(f2);
		
		// 파일 테이블 Insert
		
		try{
			conn = DBCP.getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
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
	
	response.sendRedirect("/Jboard1/list.jsp");

%>