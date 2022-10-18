<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<main id="Board">
    <section class="Modify">
        <form action="#">
            <table>
                <caption>글수정</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="text" id="sub" cols="30" rows="10"></textarea></td>
                </tr>
                <tr>
                    <th>첨부</th>
                    <td><input type="file" name="파일선택"></td>
                </tr>
            </table>
            <div>
                <a href="/Jboard1/view.jsp" class="btn">취소</a>
                <button><input type="submit" value="수정완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>