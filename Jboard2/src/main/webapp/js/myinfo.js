/**
 * 날짜 : 2022/10/21
   이름 : 박종협
   내용 : 사용자 회원가입 유효성 검사
 */
	// 데이터 검증에 사용하는 정규표현식
	let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	let reName  = /^[가-힣]{2,5}$/;
	let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
	
	// 폼 데이터 검증 결과 상태 변수
	let isPassOk  = true;
	let isNameOk  = true;
	let isNickOk  = true;
	let isEmailOk = true;
	let isEmailAuthOk = true;
	let isHpOk    = true;
	
	$(function(){
		
		// 내 정보 키보드 입력 시 폼 데이터 검증 결과 상태 변수 false로 변경
		$('input[name=pass1]').keydown(function(){ isPassOk = false; });
		$('input[name=pass2]').keydown(function(){ isPassOk = false; });
		$('input[name=name]').keydown(function(){ isNameOk = false; });
		$('input[name=nick]').keydown(function(){ isNickOk = false; });
		$('input[name=email]').keydown(function(){ isEmailOk = false; isEmailAuthOk = false; });
		$('input[name=hp]').keydown(function(){ isHpOk = false; });
		
		// 비밀번호 검사하기
		$('.btnUpdatePass').click(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			if(pass2.match(rePass)){
				if(pass1 == pass2){
					isPassOk = true;
					
					let uid = $('input[name=uid]').val();
			
					let jsonData = {
							"uid":uid,
							"pw":pass2
					}
					$.ajax({
						url:'/Jboard2/user/updatePass.do',
						method:'post',
						data:jsonData,
						dataType:'json',
						success: function(data){
							
							if(data.result > 0){
								alert('비밀번호 변경 성공!');
							}else{
								alert('비밀번호 변경에 실패했습니다.\n 다시 시도해주세요.');
							}
						}
					});
				}else{
					isPassOk = false;
					$('.passResult').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
				}
			}else{
				isPassOk = false;
				$('.passResult').css('color', 'red').text('숫자,영문,특수문자 포함 5자리이상이여야 합니다.');
			}			
			
		});
		
		// 이름 검사하기
		$('input[name=name]').focusout(function(){
			
			let name = $(this).val();
			
			if(name.match(reName)){
				isNameOk = true;
				$('.nameResult').text('');
			}else{
				isNameOk = false;
				$('.nameResult').css('color','red').text('한글로만 이루어진 두글자 이상 문자여야합니다.');
			}
		});
		
		// 별명 검사하기
		$('input[name=nick]').keydown(function(){
			isNickOk = false;
		});
		
		$('#btnNickCheck').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			if(isNickOk){ return; }
			
			if(!nick.match(reNick)){
				isNickOk = false;
				$('.nickResult').css('color', 'red').text('유효하지않는 별명 입니다.');
				return;
			}
			
			let jsonData = { "nick" : nick };
			
			$('.nickResult').css('color', 'black').text('...');
			
			setTimeout(function(){
				$.ajax({
					url:'/Jboard2/user/checkNick.do',
					method:'get',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
						if(data.result == 0){
							$('.nickResult').css('color', 'green').text('사용 가능한 별명 입니다.');
							isNickOk = true;
						}else{
							$('.nickResult').css('color', 'red').text('이미 사용중인 별명 입니다.');
							isNickOk = false;
						}
					}
				});
			},500);

		});
		
		// 이메일 검사하기
		$('input[name=email]').focusout(function(){
			
			let email = $(this).val();
			
			if(email.match(reEmail)){
				isEmailOk = true;
				$('.emailResult').text('');
			}else{
				isEmailOk = false;
				$('.emailResult').css('color','red').text('유효하지 않는 이메일입니다.');
			}
		});
		
		// 이메일 인증 검사하기
		let emailCode = 0;
		
		$('#btnEmailAuth').click(function(){
			
				
				let email = $('input[name=email]').val();
				
				let jsonData = { "email":email }
				
				$.ajax({
					url:'/Jboard2/user/emailAuth.do',
					method:'get',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(data.status == 1){
							// 메일 발송 성공
							emailCode = data.code;
							$('.emailResult').css('color', 'green').text('인증코드를 전송했습니다. 이메일을 확인해주세요');
							$('.auth').show();
						}else{
							// 메일 발송 실패
							check = 0;
							$('.emailResult').css('color', 'red').text('이메일 전송에 실패했습니다. 이메일 확인 후 다시 시도해주세요');
						}
					}
				});
		});
		
		// 이메일 인증코드 확인
		$('#btnEmailConfirm').click(function(){
			
				let code = $('input[name=auth]').val();
				
				if(code == emailCode){
					$('.emailResult').css('color', 'green').text('이메일이 인증되었습니다.');
					isEmailAuthOk = true;
				}else{
					check = 0;
					$('.emailResult').css('color', 'red').text('이메일 인증에 실패했습니다. 다시 시도해주세요');
				}
		});
		
		// 휴대폰 검사하기
		$('input[name=hp]').focusout(function(){
			
			let hp = $(this).val();
			
			if(hp.match(reHp)){
				isHpOk = true;
				$('.hpResult').text('');
			}else{
				isHpOk = false;
				$('.hpResult').css('color','red').text('유효하지 않는 휴대폰입니다.');
			}
		});
		
		// 최종 폼 전송할 때
		$('.register > form').submit(function(){
			
			// 비밀번호 검증
			if(!isPassOk){
				alert('비밀번호가 유효하지 않습니다.');
				return false;
			}	
			
			// 이름
			if(!isNameOk){
				alert('이름이 유효하지 않습니다.');
				return false;
			}	
			
			// 별명 검증
			if(!isNickOk){
				alert('별명이 유효하지 않습니다.');
				return false;
			}	
			
			// 이메일 검증
			if(!isEmailOk){
				alert('이메일이 유효하지 않습니다.');
				return false;
			}
			
			// 이메일 인증 검증
			if(!isEmailAuthOk){
				alert('이메일 인증을 하셔야합니다.');
				return false;
			}
			
			// 휴대폰 검증
			if(!isHpOk){
				alert('휴대폰이 유효하지 않습니다.');
				return false;
			}	
			
			return true;
		});
	});