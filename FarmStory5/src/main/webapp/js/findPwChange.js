$(function(){
			$('.btnNext').click(function(e){
			e.preventDefault();
			
			let uid = '${sessFindPass.uid}';
			let pass = $('input[name=pass2]').val();
			
			let jsonData = {
					"uid":uid,
					"pass":pass,
			}
			
			console.log(uid);
			
			$.ajax({
				url:'/FarmStory5/user/findPwChange.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result == 1){
						alert('비밀번호를 변경했습니다.\n 다시 로그인 해주세요');
						location.href="/FarmStory5/user/login.do";
					}else{
						alert('비밀번호 변경에 실패했습니다. \n 다시 시도해주세요');
					}
				}
			});
			});
});