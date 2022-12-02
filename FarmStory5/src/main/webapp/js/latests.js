$(function(){
	$.ajax({
	url:'/FarmStory5/index.do',
	method:'post',
	data:{ "cate":"notice" },
	dataType:'json',
	success: function(data){
		if(data == ''){
			$('#tabs-1 .txt').append("<li><span>등록된 게시글이 없습니다.</span></li>");
		}else {
			for(let vo of data){
			let url = "/FarmStory5/board/view.do?group=community&cate=notice&pg=1&no="+vo.no;
			$('#tabs-1 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
			}
		}
	}
	});

	$.ajax({
		url:'/FarmStory5/index.do',
		method:'post',
		data:{ "cate":"qna" },
		dataType:'json',
		success: function(data){
			if(data == ''){
				$('#tabs-2 .txt').append("<li><span>등록된 게시글이 없습니다.</span></li>");
			}else{
				for(let vo of data){
				let url = "/FarmStory5/board/view.do?group=community&cate=qna&pg=1&no="+vo.no;
				$('#tabs-2 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
				}	
			}
		}
	});

	$.ajax({
		url:'/FarmStory5/index.do',
		method:'post',
		data:{ "cate":"faq" },
		dataType:'json',
		success: function(data){
			if(data == ''){
				$('#tabs-3 .txt').append("<li><span>등록된 게시글이 없습니다.</span></li>");
			}else{
				for(let vo of data){
				let url = "/FarmStory5/board/view.do?group=community&cate=faq&pg=1&no="+vo.no;
				$('#tabs-3 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
				}
			}
		}
	});
});