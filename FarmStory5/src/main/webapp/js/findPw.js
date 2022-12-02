$(function(){
	$('.btnNext').click(function(e){
			e.preventDefault();
			
			if(!isEmailAuthOk){
				alert('이메일 인증을 먼저하세요');
				return;
			}
			
			let uid   = $('input[name=uid]').val();
			let email = $('input[name=email]').val();
			
			console.log(uid);
			console.log(email);
			
			let jsonData = {
					"uid":uid,
					"email":email
			}
			
			$.ajax({
				url:'/FarmStory5/user/findPw.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success: function(data){
					if(data.result > 0){
						location.href="/FarmStory5/user/findPwChange.do"
					}else{
						alert('이름과 이메일이 일치하는 회원이 없습니다.\n 다시 시도해주세요');
					}
				}
			});
		});
});