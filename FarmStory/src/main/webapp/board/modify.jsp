<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<main id="Board">
    <section class="Modify">
        <form action="/Jboard1/proc/modifyProc.jsp" method="post" id="frm">
			<input type="hidden" name="no">
           	<input type="hidden" name="pg">
            <table>
                <caption>글수정</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="text" id="sub" cols="30" rows="10"></textarea></td>
                </tr>
            </table>
            <div>
                <a href="#" class="btn">취소</a>
                <button><input type="submit" value="수정완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
