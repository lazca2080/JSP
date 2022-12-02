$(function(){
			$('.btnNext').click(function(e){
			e.preventDefault();
			
			let name  = $('input[name=name]').val();
			let email = $('input[name=email]').val();
			
			let jsonData = {
					"name":name,
					"email":email
			}
			
			$.ajax({
				url:'/FarmStory5/user/findId.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result > 0){
						location.href="/FarmStory5/user/findIdResult.do";
					}else{
						alert('일치하는 회원이 없습니다.\n 이름과 이메일을 다시 확인해주세요');
					}
				}
			});
		});
});