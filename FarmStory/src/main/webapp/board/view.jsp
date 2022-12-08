<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	
	pageContext.include("/board/_"+group+".jsp");
%>
<main id="Board">
    <section class="View">
        <table>
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" readonly></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td><a href="#"></a>&nbsp;<span></span>회 다운로드</td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" readonly></textarea></td>
            </tr>
        </table>
        <div>
            <a href="#" class="btn btnRemove">삭제</a>
            <a href="#" class="btn btnModify">수정</a>
            <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnList">목록</a>
        </div>
        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>
            <article>
                <span class="nick"></span>
                <span class="date"></span>
                <p class="content"></p>
                <div>
                    <a href="#" class="remove">삭제</a>
                    <a href="#" class="modify">수정</a>
                </div>
            </article>
			
            <p class="empty">등록된 댓글이 없습니다.</p>

        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#" method="post">
            	<input type="hidden" name="uid">
            	<input type="hidden" name="no">
                <textarea name="content" placeholder="댓글을 입력하세요"></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete">
                </div>
            </form>
        </section>
    </section>
</main>
<%@ include file="/_footer.jsp" %>
