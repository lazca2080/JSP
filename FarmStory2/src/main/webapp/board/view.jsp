<%@page import="kr.co.FarmStory2.bean.ArticleBean"%>
<%@page import="kr.co.FarmStory2.dao.ArticleDAO"%>
<%@page import="kr.co.FarmStory2.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String group = request.getParameter("group");
	String cate  = request.getParameter("cate");
	String no    = request.getParameter("no");
	String regip = request.getRemoteAddr();
	String uid   = sessuser.getUid();
	String nick  = sessuser.getNick();
	
	ArticleBean ab = ArticleDAO.getInstance().selectArticle(no);
	
	pageContext.include("/board/_"+group+".jsp");
%>
<script>
	
	$(function(){
		
		$('.btnComplete').click(function(){
			
			let uid     = "<%= uid %>";
			let parent  = "<%= no %>";
			let cate    = "<%= cate %>";
			let nick    = "<%= nick %>";
			let content = $('textarea[name=content]').val();
			
			let jsonData = {
					"uid" : uid,
					"regip" : regip,
					"parent" : parent,
					"cate" : cate,
					"content" : content
			}
			
			$.ajax({
				url:'./proc/commentWriteProc.jsp',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result == 1){
						
						let tags = "<span class='nick'>"+nick+"</span>";
						   tags += "<span class='date'>"++"</span>";
						
                        <span class="nick">길동이</span>
                        <span class="date">20-05-20</span>
                        <p class="content">
                            댓글 샘플입니다.
                        </p>
                        <div>
                            <a href="#">삭제</a>
                            <a href="#">수정</a>
                        </div>
						
					}else{
						alert('등록 실패');
					}
				}
			});
			
		});		
		
		
	});

</script>
            <main id="Board">
                <section class="View">
                    <table>
                        <caption>글보기</caption>
                        <tr>
                            <th>제목</th>
                            <td><%= ab.getTitle() %></td>
                        </tr>
                        <% if(ab.getFile() > 0) { %>
                        <tr>
                            <th>첨부파일</th>
                            <td><a href="./proc/downloadProc.jsp"><%= ab.getOriName() %></a>&nbsp;<span><%= ab.getDownload() %></span>회 다운로드</td>
                        </tr>
                        <% } %>
                        <tr>
                            <th>내용</th>
                            <td><textarea name="content" readonly><%= ab.getContent() %></textarea></td>
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
                        <form action="./proc/commentWriteProc.jsp?group=<%= group %>&cate=<%= cate %>&no=<%= no %>">
                            <textarea name="content"></textarea>
                            <div>
                                <a href="/FarmStory2/board/list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnCanvel">취소</a>
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