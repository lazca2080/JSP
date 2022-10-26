<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	ArticleBean ab = null;
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBCP.getConnection();
		psmt = conn.prepareStatement(Sql.SELECT_VIEW);
		psmt.setString(1, no);
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			ab = new ArticleBean();
			ab.setTitle(rs.getString(5));
			ab.setContent(rs.getString(6));
			ab.setFile(rs.getString(7));
		}
		
		conn.close();
		psmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String oriname = null;
	String newname = null;
	
	try{
		conn = DBCP.getConnection();
		psmt = conn.prepareStatement("SELECT * FROM `board_file` WHERE `parent`=?");
		psmt.setString(1, no);
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			oriname = rs.getString(4);
			newname = rs.getString(3);
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<main id="Board">
    <section class="View">
        <table>
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><%= ab.getTitle() %></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td><a href="#"><%= oriname== null ? "없음" : oriname %></a>&nbsp;<span>7</span>회 다운로드</td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" readonly><%= ab.getContent() %></textarea></td>
            </tr>
        </table>
        <div>
            <a href="/Jboard1/list.jsp" class="btn btnRemove">삭제</a>
            <a href="/Jboard1/modify.jsp" class="btn btnModify">수정</a>
            <a href="/Jboard1/list.jsp" class="btn btnList">목록</a>
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
                    <a href="#" class="remove">삭제</a>
                    <a href="#" class="modify">수정</a>
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
                    <input type="submit" value="작성완료" class="btn btnComplete">
                </div>
            </form>
        </section>
    </section>
</main>
<%@ include file="./_footer.jsp" %>