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
	
	ArticleBean ab = ArticleDAO.getInstance().selectArticle(no);
	
	pageContext.include("/board/_"+group+".jsp");
%>
<script>
	$(function(){
		
		// 댓글 작성
		$('.commentForm > form').submit(function(e){
			
			e.preventDefault();
			
			let uid     = $(this).children('input[name=uid]').val();
			let content = $(this).children('textarea[name=content]').val();
			let cate    = $(this).children('input[name=cate]').val();
			let group   = $(this).children('input[name=group]').val();
			let no      = $(this).children('input[name=no]').val();
			
			let jsonData = {
					"uid" : uid,
					"content" : content,
					"cate" : cate,
					"no" : no,
			}
			
			$.ajax({
				url:'./proc/commentWriteProc.jsp',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
					let tags = "<article>";
					   tags += "<span class='nick'>"+data.nick+" </span>";
					   tags += "<span class='date'>"+data.rdate+"</span>";
					   tags += "<p class='content'>"+data.content+"</p>";
					   tags += "<div>";
					   tags += "<a href='#'>삭제 </a>";
					   tags += "<a href='#'>수정</a>";
					   tags += "</div>";
					   tags += "</article>";
					
					$('.commentList > .empty').hide();   
					$('.commentList').append(tags);
				}
			});
			
		});
		
		let cate    = $('.commentForm > form').children('input[name=cate]').val();
		let group   = $('.commentForm > form').children('input[name=group]').val();
		let no      = $('.commentForm > form').children('input[name=no]').val();
		
		let url = "/FarmStory2/board/proc/commentListProc.jsp?group="+group+"&cate="+cate+"&no="+no		
		$.get(url, function(data){
			for(let list of data){
				let tags = "<article>";
				   tags += "<span class='nick'>"+list.nick+" </span>";
				   tags += "<span class='date'>"+list.rdate.substring(2,10)+"</span>";
				   tags += "<p class='content'>"+list.content+"</p>";
				   tags += "<div>";
				   tags += "<a href='#'>삭제 </a>";
				   tags += "<a href='#'>수정</a>";
				   tags += "</div>";
				   tags += "</article>";
				   
			    $('.commentList > .empty').hide(); 
				$('.commentList').append(tags);
			}
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
                        <p class="empty">등록된 댓글이 없습니다.</p>

                    </section>

                    <!-- 댓글쓰기 -->
                    <section class="commentForm">
                        <h3>댓글쓰기</h3>
                        <form action="#">
                        	<input type="hidden" name="group" value="<%= group %>">
                        	<input type="hidden" name="cate" value="<%= cate %>">
                        	<input type="hidden" name="no" value="<%= no %>">
                        	<% if(sessuser != null) { %>
                        	<input type="hidden" name="uid" value="<%= sessuser.getUid() %>">
                        	<% }else { %>
                        	<input type="hidden" name="uid" value="nobody">
                        	<% } %>
                            <textarea name="content"></textarea>
                            <div>
                                <a href="/FarmStory2/board/list.jsp?group=<%= group %>&cate=<%= cate %>" class="btn btnCanvel">취소</a>
                                <input type="submit" value="작성완료" class="btn btnComplete">
                            </div>
                        </form>
                    </section>
                </section>
            </main>
        </article>
    </section>
</div>
<%@ include file="/_footer.jsp" %>