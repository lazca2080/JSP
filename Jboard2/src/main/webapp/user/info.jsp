<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		
		$('.btnNext').click(function(e){
			e.preventDefault();
			
			//let uid = '${sessUser.uid}';
			
			let uid = $('input[name=uid]').val();
			let pw  = $('input[name=pass]').val();
			
			if(pw != ''){
				let jsonData = {
						"uid":uid,
						"pw":pw
				}
				$.ajax({
					url:'/Jboard2/user/userCheck.do',
					method:'post',
					data:jsonData,
					dataType:'json',
					success: function(data){
							
						if(data.result > 0){
							location.href = "/Jboard2/user/myinfo.do";
						}else{
							alert('일치하는 회원이 없습니다.');
						}
					}
				});
			}else{
				alert('비밀번호를 입력하세요');
				return;
			}
		});
	});
	
</script>
<main id="user">
    <section class="find findId">
    	<input type="hidden" name="uid" value="${sessUser.uid}">
        <form action="#">
            <table border="0">
                <caption>비밀번호 확인</caption>
                <tr>
                    <td>이름</td>
                    <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
                </tr>                     
            </table>                                        
        </form>
        
        <p>
            회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
        </p>

        <div>
            <a href="/Jboard2/list.do" class="btn btnCancel">취소</a>
            <a href="#" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>