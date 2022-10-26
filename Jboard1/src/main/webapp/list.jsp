<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	List<ArticleBean> article = new ArrayList<>();
	
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_ARTICLE);
		
		while(rs.next()){
			ArticleBean ab = new ArticleBean();
			ab.setNo(rs.getString(1));
			ab.setTitle(rs.getString(5));
			ab.setUid(rs.getString(9));
			ab.setRdate(rs.getString(11));
			
			article.add(ab);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<main id="Board">
    <section class="list">
        <table>
            <caption>글목록</caption>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회수</th>
            </tr>
            <% for(ArticleBean ab : article){ %>
            <tr>
                <td><%= ab.getNo() %></td>
                <td><a href="./view.jsp?no=<%= ab.getNo() %>"><%= ab.getTitle() %></a></td>
                <td><%= ab.getUid() %></td>
                <td><%= ab.getRdate().substring(0, 10) %></td>
                <td>12</td>
            </tr>
            <% } %>
        </table>
        <div class="page">
            <a href="#" class="prev">이전</a>
            <a href="#" class="num current">1</a>
            <a href="#" class="num">2</a>
            <a href="#" class="num">3</a>
            <a href="#" class="next">다음</a>
        </div>
        <div>
            <a href="/Jboard1/write.jsp" class="btn btnWrite">글쓰기</a>
        </div>
    </section>
</main>
<%@ include file="./_footer.jsp" %>