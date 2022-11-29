	let emailCode = 0;
	let preventDoubleClick = false;

	$(function(){
			$('.emailButton').click(function(){
				let email = $('input[name=email]').val();
				
				if(email == ''){
					alert('이메일을 입력 하세요.');
					return;
				}
				
				if(preventDoubleClick){
					return;
				}
				
				preventDoubleClick = true;
				
				if(email.match(reEmail) && emailCheck == 1){
					
					let jsonData = { "email":email }
					$('.emailResult').css('color','green').text('인증번호 전송중입니다...');
						$.ajax({
							url:'/FarmStory5/user/emailAuth.do',
							method:'get',
							data:jsonData,
							dataType:'json',
							success: function(data){
								
								$('.auth').show();
								if(data.status > 0){
									emailCode = data.code
									isEmailOk = true;
									$('.emailResult').css('color','green').text('인증번호 전송완료.');
								}else{
									$('.emailResult').css('css','red').text('인증번호 전송에 실패했습니다.\n 이메일을 다시 확인해주세요');
								}
							}
						});
					
				}else{
					isEmailOk = false;
					$('.auth').hide();
					$('.emailResult').css('color', 'red').text('사용할 수 없는 이메일입니다.');
				}
			});
			
			$('.emailCodeCheck').click(function(){
				
				let Code = $('input[name=auth]').val();
				
				if(emailCode == Code){
					isEmailAuthOk = true;
					$('.emailResult').css('color','green').text('인증을 완료했습니다.');
				}else{
					isEmailAuthOk = false;
					$('.emailResult').css('color','green').text('인증번호가 틀립니다.\n 다시 시도해주세요');
				}
			});
	});