<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
<main id="board">
    <section class="list">                
        <form action="/FarmStory5/board/list.do" method="get">
        	<input type="hidden" name="group" value="${group}">
        	<input type="hidden" name="cate" value="${cate}">
        	<input type="hidden" name="pg" value="1">
        	<select name="option">
        		<option value="title">제목</option>
        		<option value="content">내용</option>
        		<option value="nick">글쓴이</option>
        		<option value="content">댓글</option>
        	</select>
            <input type="text" name="search" placeholder="검색할 단어를 입력해주세요.">
            <input type="submit" value="검색">
        </form>
        
        <table border="0">
            <caption>글목록</caption>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회</th>
            </tr>
            <c:choose>
            <c:when test="${not empty article}">
            <c:forEach var="article" items="${article}">
            	<c:set var="i" value="${i + 1}"/>
            <tr>
                <td>${pnum.pageStartNum - i}</td>
                <td><a href="./view.do?group=${group}&cate=${cate}&no=${article.no}&pg=${pnum.currentPg}">${article.title} [${article.comment}]</a></td>
                <td>${article.nick}</td>
                <td>${article.rdate}</td>
                <td>${article.hit}</td>
            </tr>
            </c:forEach>
          	</c:when>
            <c:otherwise>
            <tr>
            	<td></td>
                <td class="solo"><a>등록된 게시글이 없습니다.</a></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </c:otherwise>
            </c:choose>
        </table>
		
        <div class="page">
        <c:choose>
        <c:when test="${empty option}">
        	<c:if test="${pnum.pageGroupStart gt 1}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${pnum.pageGroupStart -1}" class="prev">이전</a>
            </c:if>
            <c:forEach var="i" begin="${pnum.pageGroupStart}" end="${pnum.pageGroupEnd}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${i}" class="num ${pnum.currentPg eq i ? 'current' : 'off' }">${i}</a>
            </c:forEach>
            <c:if test="${pnum.pageGroupEnd lt pnum.lastPageNum}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${pnum.pageGroupEnd + 1}" class="next">다음</a>
            </c:if>
        </c:when>
        <c:otherwise>
 	       	<c:if test="${pnum.pageGroupStart gt 1}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${pnum.pageGroupStart -1}&option=${option}&search=${search}" class="prev">이전</a>
            </c:if>
            <c:forEach var="i" begin="${pnum.pageGroupStart}" end="${pnum.pageGroupEnd}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${i}&option=${option}&search=${search}" class="num ${pnum.currentPg eq i ? 'current' : 'off' }">${i}</a>
            </c:forEach>
            <c:if test="${pnum.pageGroupEnd lt pnum.lastPageNum}">
	            <a href="/FarmStory5/board/list.do?group=${group}&cate=${cate}&pg=${pnum.pageGroupEnd + 1}&option=${option}&search=${search}" class="next">다음</a>
            </c:if>
        </c:otherwise>
        </c:choose>
        </div>
        <c:if test="${not empty sessUser}">
        <a href="./write.do?group=${group}&cate=${cate}" class="btn btnWrite">글쓰기</a>
        </c:if>
    </section>
</main>
</article>
    </section>
</div>
<jsp:include page="../_footer.jsp"/>