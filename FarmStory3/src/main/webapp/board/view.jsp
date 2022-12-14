<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate  = request.getParameter("cate");
	pageContext.include("/board/_"+group+".jsp");
%>

            <main id="Board">
                <section class="View">
                    <table>
                        <caption>글보기</caption>
                        <tr>
                            <th>제목</th>
                            <td>제목입니다.</td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td><a href="#">2020년 상반기 매출자료.xls</a>&nbsp;<span>7</span>회 다운로드</td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td><textarea name="content" readonly>내용 샘플입니다.</textarea></td>
                        </tr>
                    </table>
                    <div>
                        <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnRemove">삭제</a>
                        <a href="./modify.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnModify">수정</a>
                        <a href="./list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnList">목록</a>
                    </div>
                    <!-- 댓글목록 -->
                    <section class="commentList">
                        <h3>댓글목록</h3>
                        <article>
                            <span class="nick">길동이</span>
                            <span class="date">20-05-20</span>
                            <p class="content">
                                댓글 샘플입니다.
                            </p>
                            <div>
                                <a href="#">삭제</a>
                                <a href="#">수정</a>
                            </div>
                        </article>

                        <p class="empty">등록된 댓글이 없습니다.</p>

                    </section>

                    <!-- 댓글쓰기 -->
                    <section class="commentForm">
                        <h3>댓글쓰기</h3>
                        <form action="#">
                            <textarea name="content"></textarea>
                            <div>
                                <a href="#" class="btn btnCanvel">취소</a>
                                <input type="sumit" value="작성완료" class="btn btnComplete">
                            </div>
                        </form>
                    </section>
                </section>
            </main>
        </article>
    </section>
</div>
<%@ include file="/_footer.jsp" %>