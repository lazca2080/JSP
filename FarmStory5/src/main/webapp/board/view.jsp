<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
<script src="/FarmStory5/js/comment.js"></script>
<main id="board">
    <section class="view">
        
        <table border="0">
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${vo.title}" readonly/></td>
            </tr>
            <c:if test="${not empty fv}">
            <tr>
                <th>파일</th>
                <td><a href="#">${fv.oriName}</a>&nbsp;<span>${fv.download}</span>회 다운로드</td>
            </tr>
            </c:if>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" readonly>${vo.content}</textarea>
                </td>
            </tr>                    
        </table>
        
        <div>
        	<c:if test="${vo.uid == sessUser.uid}">
            <a href="./delete.do?group=${group}&cate=${cate}&no=${vo.no}&pg=${pg}" class="btn btnRemove">삭제</a>
            <a href="./modify.do?group=${group}&cate=${cate}&no=${vo.no}&pg=${pg}" class="btn btnModify">수정</a>
            </c:if>
            <a href="./list.do?group=${group}&cate=${cate}&pg=${pg}" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>
            <c:forEach var="comment" items="${comment}">              
			<article>
                <span class="nick">${comment.nick}</span>
                <span class="date">${comment.rdate}</span>
                <p class="content">${comment.content}</p>
                <c:if test="${comment.uid == sessUser.uid}">
                <div>
                    <a href="#" class="remove" data-no="${comment.no}" data-parent="${comment.parent}">삭제</a>
                    <a href="#" class="modify" data-no="${comment.no}">수정</a>
                </div>
                </c:if>
            </article>
            </c:forEach>
			
			<c:if test="${empty comment}">
            <p class="empty">등록된 댓글이 없습니다.</p>
            </c:if>
            
        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="/FarmStory5/board/commentList.do" method="post">
                <textarea name="content"></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
</article>
    </section>
</div>
<jsp:include page="../_footer.jsp"/>