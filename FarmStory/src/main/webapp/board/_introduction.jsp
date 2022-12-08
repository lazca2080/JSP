<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
            <div><img src="../img/sub_top_tit1.png" alt="INTRODUCTION"></div>
            <section class="cate1">
                <aside>
                    <img src="../img/sub_aside_cate1_tit.png" alt="팜스토리 소개"/>

                    <ul class="lnb">
                        <li class="<%= cate.equals("hello") ? "on":"off" %>"><a href="/FarmStory/board/list.jsp?group=introduction&cate=hello">인사말</a></li>
                        <li class="<%= cate.equals("hello") ? "on":"off" %>"><a href="/FarmStory/board/list.jsp?group=introduction&cate=hello">찾아오시는길</a></li>
                    </ul>

                </aside>
                <article>
                    <nav>
                        <img src="../img/sub_nav_tit_cate1_tit1.png" alt="인사말"/>
                        <p>
                            HOME > 팜스토리소개 > <em>인사말</em>
                        </p>
                    </nav>