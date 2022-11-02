<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String no     = request.getParameter("no");
	String pg     = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
%>
<main id="Board">
    <section class="Modify">
        <form action="/Jboard1/proc/modifyProc.jsp" method="post">
			<input type="hidden" name="no" value=<%= no %>>
           	<input type="hidden" name="pg" value=<%= pg %>>
            <table>
                <caption>글수정</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" value="<%= article.getTitle() %>"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="text" id="sub" cols="30" rows="10"><%= article.getContent() %></textarea></td>
                </tr>
            </table>
            <div>
                <a href="/Jboard1/view.jsp?no=<%= no %>&pg=<%= pg %>" class="btn">취소</a>
                <button><input type="submit" value="수정완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>