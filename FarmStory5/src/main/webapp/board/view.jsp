<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
<script>
	$(function(){
		
		// 댓글 리스트
		/*
		$.ajax({
			url:'/FarmStory5/board/commentList.do',
			method:'get',
			data:{"parent":'${vo.no}'},
			dataType:'json',
			success:function(data){
				
				if(data == ""){
					$('.commentList').append("<p class='empty'>등록된 댓글이 없습니다.</p>");
				}else{
					$(data).each(function(){
						let tags = "<article>";
						   tags += "<span class='nick'>"+this.nick+"</span>";
						   tags += "<span class='date'> "+this.rdate+"</span>";
						   tags += "<p class='content'>"+this.content+"</p>";
						   tags += "<div>";
						   tags += "<a href='#' class='remove' data-no='"+this.no+"' data-parent='"+this.parent+"'>삭제 </a>";
						   tags += "<a href='#' class='modify' data-no='"+this.no+"'>수정</a>";
						   tags += "</article>";
						
						$('.commentList').append(tags);
						$('.empty').hide();
					});						
				}
			}
		});
		*/
		
		// 댓글 작성
		$('.btnComplete').click(function(e){
			e.preventDefault();
			
			let content = $(this).parent().prev().text();
			let uid     = '${sessUser.uid}';
			let no      = '${vo.no}';
			let cate    = '${cate}'; 
			
			let jsonData = {
					"parent":no,
					"uid":uid,
					"cate":cate,
					"content":content
			}
			
			$.ajax({
				url:'/FarmStory5/board/commentWrite.do',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
					if(data.result == 1){
						let tags = "<article>";
						   tags += "<span class='nick'>"+data.nick+"</span>";
						   tags += "<span class='date'> "+data.rdate+"</span>";
						   tags += "<p class='content'>"+data.content+"</p>";
						   tags += "<div>";
						   tags += "<a href='#' class='remove' data-no='"+data.no+"' data-parent='"+data.parent+"'>삭제 </a>";
						   tags += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
						   tags += "</article>";
						
						$('.commentList').append(tags);
						$('.empty').hide();
						
					}else{
						alert('다시 시도해주세요');
					}
				}
			});
		});
		
		// 댓글 쓰기 취소
		$('.btnCancel').click(function(e){
			e.preventDefault();
			let content = $(this).parent().prev().val('');
		});
		
		// 댓글 수정
		$(document).on('click','.modify', function(e){
			e.preventDefault();
			
			let content = $(this).parent().prev();
			let modify  = $(this);
			
			modify.text('수정완료').attr('class','update');
			modify.prev().text('취소').attr('class','cancle');
			content.hide();
			content.before("<textarea name='content'>"+content.text()+"</textarea>");
			
		});
		
		// 댓글 수정완료
		$(document).on('click','.update',function(e){
			e.preventDefault();
			
			let content  = $(this).parent().prev();
			let update   = $(this);
			let textarea = $(this).parent().prev().prev();
			let no       = $(this).attr('data-no');
			let comment  = textarea.val();
			
			console.log(comment);
			console.log(no);
			
			let jsonData = {
					"content":comment,
					"no":no
			}
			
			$.ajax({
				url:'/FarmStory5/board/commentModify.do',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result == 1){
						textarea.hide();
						content.show().text(textarea.val());
						update.text('수정').attr('class','modify');
						update.prev().text('삭제').attr('class','remove');
					}else{
						alert('댓글 수정에 실패했습니다.\n 새로고침 후 다시 시도해주세요');
					}
					
				}
			});
		});
		
		// 댓글 수정취소
		$(document).on('click','.cancle',function(e){
			e.preventDefault();
			let textarea = $(this).parent().prev().prev();
			let content  = $(this).parent().prev();
			textarea.hide();
			content.show();
			$(this).text('삭제').attr('class','remove');
			$(this).next().text('수정').attr('class','modify');
		});
		
		// 댓글 삭제
		$(document).on('click','.remove',function(e){
			e.preventDefault();
			
			let no      = $(this).attr('data-no');
			let parent  = $(this).attr('data-parent');
			let article = $(this).parent().parent();
			
			console.log(no);
			console.log(parent);
			
			let jsonData = {
					"no":no,
					"parent":parent
			}
			
			$.ajax({
				url:'/FarmStory5/board/commentDelete.do',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
						
					if(data.result == 1){
						article.hide();
						
						if(data.total == 0){
							$('.commentList').append("<p class='empty'>등록된 댓글이 없습니다.</p>");
						}
					}else{
						alert('댓글 삭제에 실패했습니다.\n 다시 시도해주세요');
					}
				}
			});
		});
	});
</script>
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