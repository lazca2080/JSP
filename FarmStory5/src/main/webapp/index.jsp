<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"></jsp:include>
<script src="/FarmStory5/js/latests.js"></script>
<main>
    <div class="slider">
        <ul>
            <li><img src="./img/main_slide_img1.jpg" alt="슬라이더1"></li>
            <li><img src="./img/main_slide_img2.jpg" alt="슬라이더2"></li>
            <li><img src="./img/main_slide_img3.jpg" alt="슬라이더3"></li>
        </ul>

        <img src="./img/main_slide_img_tit.png" alt="사람과 자연을 사랑하는 팜스토리"/>

        <div class="banner">
            <img src="./img/main_banner_txt.png" alt="GRAND OPEN"/>
            <img src="./img/main_banner_tit.png" alt="팜스토리 오픈기념 30% 할인 이벤트"/>
            <img src="./img/main_banner_img.png" alt="과일"/>
        </div>
    </div>

    <div class="quick">
        <a href="/FarmStory5/board/list.do?group=community&cate=menu&pg=1"><img src="./img/main_banner_sub1_tit.png" alt="오늘의 식단"></a>
        <a href="/FarmStory5/board/list.do?group=community&cate=chef&pg=1"><img src="./img/main_banner_sub2_tit.png" alt="나도 요리사"></a>                
    </div>

    <div class="latest">
        <div>
            <a href="/FarmStory5/board/list.do?group=croptalk&cate=grow&pg=1"><img src="./img/main_latest1_tit.png" alt="텃밭 가꾸기"/></a>
            <img src="./img/main_latest1_img.jpg" alt="이미지"/>
            <table border="0">
            <c:choose>
            <c:when test="${not empty grow}">
            <c:forEach var="vo1" items="${grow}">
                <tr>
                    <td>></td>
                    <td><a href="/FarmStory5/board/view.do?group=croptalk&cate=grow&pg=1&no=${vo1.no}">${vo1.title}</a></td>
                    <td>${vo1.rdate}</td>
                </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            	<span>등록된 게시글이 없습니다.</span>
            </c:otherwise>
            </c:choose>
            </table>
        </div>
        <div>
            <a href="/FarmStory5/board/list.do?group=croptalk&cate=school&pg=1"><img src="./img/main_latest2_tit.png" alt="귀농학교"/></a>
            <img src="./img/main_latest2_img.jpg" alt="이미지"/>
            <table border="0">
            <c:choose>
            <c:when test="${not empty school}">
            <c:forEach var="vo2" items="${school}">
                <tr>
                    <td>></td>
                    <td><a href="/FarmStory5/board/view.do?group=croptalk&cate=grow&pg=1&no=${vo2.no}">${vo2.title}</a></td>
                    <td>${vo2.rdate}</td>
                </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            	<span>등록된 게시글이 없습니다.</span>
            </c:otherwise>
            </c:choose>
            </table>
        </div>
        <div>
            <a href="/FarmStory5/board/list.do?group=croptalk&cate=story&pg=1"><img src="./img/main_latest3_tit.png" alt="농작물 이야기"/></a>
            <img src="./img/main_latest3_img.jpg" alt="이미지"/>
            <table border="0">
            <c:choose>
            <c:when test="${not empty story}">
            <c:forEach var="vo3" items="${story}">
                <tr>
                    <td>></td>
                    <td><a href="/FarmStory5/board/view.do?group=croptalk&cate=grow&pg=1&no=${vo3.no}">${vo3.title}</a></td>
                    <td>${vo3.rdate}</td>
                </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            	<span>등록된 게시글이 없습니다.</span>
            </c:otherwise>
            </c:choose>
            </table>
        </div>
    </div>

    <div class="info">
        <div>
            <img src="./img/main_sub2_cs_tit.png" class="tit" alt="고객센터 안내"/>
            <div class="tel">
                <img src="./img/main_sub2_cs_img.png" alt="">
                <img src="./img/main_sub2_cs_txt.png" alt="1666-777">
                <p class="time">
                    평일: AM 09:00 ~ PM 06:00<br>
                    점심: PM 12:00 ~ PM 01:00<br>
                    토, 일요일, 공휴일 휴무
                </p>
            </div>
            <div class="btns">
                <a href="/FarmStory5/board/list.do?group=community&cate=qna&pg=1"><img src="./img/main_sub2_cs_bt1.png" alt="1:1 고객문의"></a>
                <a href="/FarmStory5/board/list.do?group=community&cate=faq&pg=1"><img src="./img/main_sub2_cs_bt2.png" alt="자주묻는질문"></a>
                <a href="#"><img src="./img/main_sub2_cs_bt3.png" alt="배송조회"></a>
            </div>
        </div>
        <div>
            <img src="./img/main_sub2_account_tit.png" class="tit" alt="계좌안내"/>
            <p class="account">
                기업은행 123-456789-01-01-012<br />
                국민은행 01-1234-56789<br />
                우리은행 123-456789-01-01-012<br />
                하나은행 123-456789-01-01<br />
                예 금 주 (주)팜스토리
            </p>
        </div>
        <div>
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">공지사항</a></li>
                    <li><a href="#tabs-2">1:1 고객문의</a></li>
                    <li><a href="#tabs-3">자주묻는 질문</a></li>
                </ul>
                <div id="tabs-1">
                    <ul class="txt">
                    </ul>
                </div>
                <div id="tabs-2">
                    <ul class="txt">
                    </ul>
                </div>
                <div id="tabs-3">
                    <ul class="txt">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="./_footer.jsp"></jsp:include>        