<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<main id="Board">
    <section class="list">
        <table>
            <caption>글목록</caption>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회수</th>
            </tr>
            <tr>
                <td>11</td>
                <td><a href="#">1[1]</a></td>
                <td>11</td>
                <td>11</td>
                <td>11</td>
            </tr>
        </table>
        <div class="page">
            <a href="#" class="prev">이전</a>
            <a href="#" class="num">1</a>
            <a href="#" class="next">다음</a>
        </div>
        <div>
            <a href="/Jboard1/write.jsp" class="btn btnWrite">글쓰기</a>
        </div>
    </section>
</main>
<%@ include file="./_footer.jsp" %>