$(function(){
	$.ajax({
	url:'/FarmStory5/index.do',
	method:'post',
	data:{ "cate":"notice" },
	dataType:'json',
	success: function(data){
		for(let vo of data){
			let url = "/FarmStory5/board/view.do?group=community&cate=notice&pg=1&no="+vo.no;
			$('#tabs-1 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
		}
	}
	});

	$.ajax({
		url:'/FarmStory5/index.do',
		method:'post',
		data:{ "cate":"qna" },
		dataType:'json',
		success: function(data){
			for(let vo of data){
				let url = "/FarmStory5/board/view.do?group=community&cate=qna&pg=1&no="+vo.no;
				$('#tabs-2 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
			}
		}
	});

	$.ajax({
		url:'/FarmStory5/index.do',
		method:'post',
		data:{ "cate":"faq" },
		dataType:'json',
		success: function(data){
			for(let vo of data){
				let url = "/FarmStory5/board/view.do?group=community&cate=faq&pg=1&no="+vo.no;
				$('#tabs-3 .txt').append("<li><a href='"+url+"'>"+vo.title+"</a></li>");
			}
		}
	});
});