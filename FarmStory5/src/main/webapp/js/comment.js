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
			
			let content = $(this).parent().prev().val();
			let contentVal = $(this).parent().prev();
			let uid     = '${sessUser.uid}';
			let no      = '${vo.no}';
			let cate    = '${cate}'; 
			
			let jsonData = {
					"parent":no,
					"uid":uid,
					"cate":cate,
					"content":content
			}
			
			console.log(content);
			
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
						   
						contentVal.val('');
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
			modify.prev().text('취소 ').attr('class','cancle');
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
						update.prev().text('삭제 ').attr('class','remove');
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