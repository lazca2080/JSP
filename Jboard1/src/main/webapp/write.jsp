<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script>
</script>
<main id="Board">
    <section class="Write">
        <form action="/Jboard1/proc/writeProc.jsp" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="uid" value="<%= ub.getUid() %>">
            <table>
                <caption>글쓰기</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="content" id="sub" cols="30" rows="10"></textarea></td>
                </tr>
                <tr>
                    <th>첨부</th>
                    <td><input type="file" name="fname"></td>
                </tr>
            </table>
            <div>
                <a href="/Jboard1/list.jsp" class="btn">취소</a>
                <button><input type="submit" value="작성완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>