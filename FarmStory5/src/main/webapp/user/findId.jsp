<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../_header.jsp"/>
<script src="/FarmStory5/js/validation.js"></script>
<script src="/FarmStory5/js/emailauth2.js"></script>
<script>
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
</script>
<main id="user">
    <section class="find findId">
        <form action="#">
            <table border="0">
                <caption>아이디 찾기</caption>
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="name" placeholder="이름 입력"/></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <div>
                            <input type="email" name="email" placeholder="이메일 입력"/>
                            <button type="button" class="btnAuth emailButton">인증번호 받기</button>
                            <span class="emailResult"></span>
                        </div>
                        <div>
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" class="btnConfirm emailCodeCheck">확인</button>
                        </div>
                    </td>
                </tr>                        
            </table>                                        
        </form>
        
        <p>
            회원가입시 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.<br>
            인증번호를 입력 후 확인 버튼을 누르세요.
        </p>

        <div>
            <a href="./login.do" class="btn btnCancel">취소</a>
            <a href="./findIdResult.do" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="../_footer.jsp"/>