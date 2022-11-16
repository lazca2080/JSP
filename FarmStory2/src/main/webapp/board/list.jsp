<%@page import="kr.co.FarmStory2.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.FarmStory2.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate  = request.getParameter("cate");
	String pg    = request.getParameter("pg");
	ArticleDAO dao = ArticleDAO.getInstance();
	
	int limitStart = 0;       // SQL Limit ?, 10의 ?값 시작값
	int currentPg = 1;        // 현재 페이지 값 로그인페이지에서 넘어올시 첫화면으로 표시하기 위해 1값
	int total = 0;            // 전체 게시글 수
	int lastPageNum = 0;      // 마지막 페이지 값
	int pageGroupCurrent = 1; // 현재 페이지 그룹
	int pageGroupStart = 1;   // 시작 페이지 그룹값
	int pageGroupEnd = 0;     // 마지막 페이지 그룹값
	int pageStartNum = 0;     // 이전 or 다음 버튼 클릭시 시작되는 페이지 그룹 번호
	
	total = dao.selectCountTotal(cate);
	
	// 마지막 페이지 값 계산
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = (total / 10) + 1;
	}
	
	// 현재 페이지 게시물 limitstart 값 계산
	if(pg != null){
		currentPg = Integer.parseInt(pg);
		// pg를 받아올때 로그인페이지에서 바로 넘어오는 경우 null이기 때문에 null 체크를 해준다
	}
	
	limitStart = (currentPg-1) * 10;
	
	// 페이지 그룹 계산
	pageGroupCurrent =  (int)Math.ceil(currentPg / 10.0);
	pageGroupStart = (pageGroupCurrent-1) * 10 + 1;
	pageGroupEnd = pageGroupCurrent * 10;
	
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	
	// 페이지 시작 번호 계산
	pageStartNum = total - limitStart;
	
	// 현재 페이지 게시물 가져오기
	List<ArticleBean> articles = dao.selectArticles(cate, limitStart);
	
	pageContext.include("/board/_"+group+".jsp");
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
		            <% for(ArticleBean ab : articles) { %>
		            <tr>
		                <td><%= pageStartNum-- %></td>
		                <td><a href="./view.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= ab.getNo() %>"><%= ab.getTitle() %></a>[<%= ab.getComment() %>]</td>
		                <td><%= ab.getNick() %></td>
		                <td><%= ab.getRdate().substring(2, 10) %></td>
		                <td><%= ab.getHit() %></td>
		            </tr>
		            <% } %>
		        </table>
		        <div class="page">
		        	<% if(pageGroupStart > 1){ %>
		            <a href="/FarmStory2/board/list.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= pageGroupStart - 1 %>" class="prev">이전</a>
		            <% } %>
		            <% for(int i=pageGroupStart; i<=pageGroupEnd; i++){ %>
		            <a href="/FarmStory2/board/list.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= i %>" class="num <%= (currentPg == i) ? "current":"off" %>"><%= i %></a>
		            <% } %>
		            <% if(pageGroupEnd < lastPageNum) { %>
		            <a href="/FarmStory2/board/list.jsp?group=<%= group %>&cate=<%= cate %>&pg=<%= pageGroupEnd + 1 %>" class="next">다음</a>
		            <% } %>
		        </div>
		        <div>
		            <a href="./write.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnWrite">글쓰기</a>
		        </div>
		    </section>
		</main>
        </article>
    </section>
</div>
<%@ include file="/_footer.jsp" %>