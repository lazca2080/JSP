<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	
	$(function(){
		$('.commentForm > form').submit(function(){
			
			let no       = $(this).children('input[name=no]').val();
			let uid      = $(this).children('input[name=uid]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content  = textarea.val();
			
			if(content == ''){
				alert('댓글을 작성하세요.');
				return false;
			}
			
			let jsonData = {
					"no": no,
					"uid": uid,
					"content": content
			};
			
			$.ajax({
				url:'/Jboard2/commentWrite.do',
				method:'POST',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result > 0){
						
						let article = "<article>"
						   article += "<span class='nick'>"+data.nick+"</span>"
						   article += "<span class='date'>&nbsp"+data.date+"</span>"
						   article += "<p class='content'>"+data.content+"</p>"
						   article += "<div>"
						   article += "<a href='#' class='remove' data-no='"+data.no+"' data-parent='"+data.parent+"'>삭제</a>&nbsp"
						   article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>"
						   article += "</div>"
						   article += "</article>"
						
						$('.commentList > .empty').hide();
						$('.commentList').append(article);
						
						textarea.val('');
					}
				}
			});
			return false;
		});
		
		let no = $('.commentForm > form').children('input[name=no]').val();
		let jsonData = { 'no':no }
		$.ajax({
			url:'/Jboard2/commentList.do',
			method:'get',
			data:jsonData,
			dataType:'json',
			success: function(data){
				for(let list of data){
					let tags = "<article>";
					   tags += "<span class='nick'>"+list.nick+" </span>";
					   tags += "<span class='date'>"+list.rdate+"</span>";
					   tags += "<p class='content'>"+list.content+"</p>";
					   tags += "<div>";
					   tags += "<a href='#'>삭제 </a>";
					   tags += "<a href='#'>수정</a>";
					   tags += "</div>";
					   tags += "</article>";
					   
				    $('.commentList > .empty').hide(); 
					$('.commentList').append(tags);
				}
			}
		});
		
		/*
		let url = "/Jboard2/commentList.do?no="+no		
		$.get(url, function(data){
			for(let list of data){
				let tags = "<article>";
				   tags += "<span class='nick'>"+list.nick+" </span>";
				   tags += "<span class='date'>"+list.rdate+"</span>";
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
		*/
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
            <c:if test="${vo.file gt 0}">
            <tr>
                <th>파일</th>
                <td><a href="/Jboard2/download.do?parent=${vo.no}">${fv.oriName}</a>&nbsp;<span>${vo.file}</span>회 다운로드</td>
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
            <a href="/Jboard2/delete.do?no=${vo.no}&pg=${pg}" class="btn btnRemove">삭제</a>
            <a href="/Jboard2/modify.do?no=${vo.no}&pg=${pg}" class="btn btnModify">수정</a>
            <a href="/Jboard2/list.do?pg=${pg}" class="btn btnList">목록</a>
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
            	<input type="hidden" name="uid" value="${sessUser.uid}">
            	<input type="hidden" name="no" value="${vo.no}">
                <textarea name="content">댓글내용 입력</textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>