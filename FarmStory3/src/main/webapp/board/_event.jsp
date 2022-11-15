<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
    <div><img src="/FarmStory3/img/sub_top_tit4.png" alt="EVENT"></div>
    <section class="cate4">
        <aside>
            <img src="/FarmStory3/img/sub_aside_cate4_tit.png" alt="">
            <ul>
                <li class="<%= cate.equals("event") ? "on" : "off" %>"><a href="/FarmStory3/board/list.jsp?group=event&cate=event">.</a></li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/FarmStory3/img/sub_nav_tit_cate4_tit1.png" alt="장보기">
             	<p>
					HOME > 이벤트 > <em>이벤트</em>
				</p>
            </nav>