<%@page import="bean.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	String uid   = request.getParameter("uid");
	String pass  = request.getParameter("pass1");
	String name  = request.getParameter("name");
	String nick  = request.getParameter("nick");
	String email = request.getParameter("email");
	String hp 	 = request.getParameter("hp");
	String grade = request.getParameter("grade");
	String zip 	 = request.getParameter("zip");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String regip = request.getRemoteAddr();
	String rdate = request.getParameter("rdate");
	
	
	UserBean ub = new UserBean();
	ub.setUid(uid);
	ub.setPass(pass);
	ub.setName(name);
	ub.setNick(nick);
	ub.setEmail(email);
	ub.setHp(hp);
	ub.setGrade(grade);
	ub.setZip(zip);
	ub.setAddr1(addr1);
	ub.setAddr2(addr2);
	ub.setRegip(regip);
	
	UserDAO.getinstance().insertUser(ub);
	
	response.sendRedirect("/FarmStory2/user/login.jsp");
%>