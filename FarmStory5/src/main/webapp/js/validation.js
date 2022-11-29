	// 데이터 검증에 사용하는 정규표현식
	let reUid   = /^[a-z]+[a-z0-9]{5,19}$/g;
	let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	let reName  = /^[가-힣]+$/;
	let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
	
	// 폼 데이터 검증 결과 상태 변수
	let isUidOk   = false;
	let isPassOk  = false;
	let isNameOk  = false;
	let isNickOk  = false;
	let isEmailOk = false;
	let isEmailAuthOk = false;
	let isHpOk    = false;
	
	// 이메일 중복 체크 이후 인증번호 연계 코드
	let emailCheck = 0;

	$(function(){
		
		$('.uidCheck').click(function(){
			
			let uid = $('input[name=uid]').val();
			
			let jsonData = { "uid":uid };
			
			$('.uidResult').css('color','black').text('중복 확인중입니다...');
			
			setTimeout(function(){
				$.ajax({
					url:'/FarmStory5/user/checkUid.do',
					method:'get',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(uid.match(reUid)){
							
							if(data.result == 0){
								isUidOk = true;
								$('.uidResult').css('color', 'green').text('유효한 아이디입니다.');
							}else{
								isUidOk = false;
								$('.uidResult').css('color', 'red').text('이미 사용중인 아이디입니다.');
							}
						}else{
							isUidOk = false;
							$('.uidResult').css('color', 'red').text('아이디 양식에 맞지않습니다.');
						}		
					}
				});
			}, 500);
		});
		
		$('input[name=pass2]').focusout(function(){
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass2.match(rePass)){
				
				if(pass1 == pass2){
					isPassOk = true;
					$('.passResult').css('color', 'green').text('사용 가능한 비밀번호입니다.');
				}else{
					isPassOk = false;
					$('.passResult').css('color', 'red').text('서로 다른 비밀번호입니다.');	
				}
			}else{
				isPassOk = false;
				$('.passResult').css('color', 'red').text('비밀번호 양식에 맞지않습니다.');
			}
		});
		
		$('input[name=name]').focusout(function(){
			
			let name = $('input[name=name]').val();
			
			if(name.match(reName)){
				isNameOk = true;
				$('.nameResult').css('color', 'greem').text('');
			}else{
				isNameOk = false;
				$('.nameResult').css('color', 'red').text('두 글자 이상 한글이여야 합니다..');
			}
			
		});
		
		$('.nickCheck').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			let jsonData = { "nick":nick }
			
			$('.nickResult').css('color','black').text('중복 확인중입니다...');
			
			setTimeout(function(){
				$.ajax({
					url:'/FarmStory5/user/checkNick.do',
					method:'get',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(nick.match(reNick)){
							if(data.result == 0){
								isNickOk = true;
								$('.nickResult').css('color', 'green').text('사용 가능한 별명입니다.');
							}else{
								isNickOk = false;
								$('.nickResult').css('color', 'red').text('이미 사용중인 별명입니다.');	
							}
						}else{
							isNickOk = false;
							$('.nickResult').css('color', 'red').text('별명 양식에 맞지않습니다.');
						}
					}
				});
			}, 1000);
		});
		
		$('.emailCheck').click(function(){
			
			let email = $('input[name=email]').val();
			
			let jsonData = { "email":email };
			
			$.ajax({
				url:'/FarmStory5/user/checkEmail.do',
				method:'get',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result == 1){
						isEmailOk = false;
						$('.emailResult').css('color','red').text('이미 사용중인 이메일 입니다..');
					}else{
						isEmailOk = true;
						emailCheck = 1;
						$('.emailResult').css('color','green').text('사용 가능한 이메일 입니다.');
					}
				}
			});
		});
		
		$('.hpCheck').click(function(){
			
			let hp = $('input[name=hp]').val();
			
			if(hp.match(reHp)){
				$('.hpResult').css('color', 'green').text('');
				
				let jsonData = { "hp":hp };
				
				$.ajax({
					url:'/FarmStory5/user/checkHp.do',
					method:'get',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(data.result > 0){
							isHpOk = false;
							$('.hpResult').css('color', 'red').text('이미 사용중인 번호입니다.');
						}else{
							isHpOk = true;
							$('.hpResult').css('color', 'green').text('사용 가능한 번호입니다.');
						}
					}
				});
			}else{
				isHpOk = false;
				$('.hpResult').css('color', 'red').text('번호 양식에 맞지 않습니다.');
			}
		});
		
		$('.register > form').submit(function(){
			
			// ID 검증
			if(!isUidOk){
				alert('아이디를 확인하세요.');
				return false;
			}	
			
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