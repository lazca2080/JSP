/**
 * 
 */

function btnregister(){

	$(function(){
		
		// 데이터 가져오기
		let uid = $('input[name=uid]').val();
		let name = $('input[name=name]').val();
		let hp = $('input[name=hp]').val();
		let age = $('input[name=age]').val();
		
		// JSON 생성
		let jsonData = {
				"uid":uid,
				"name":name,
				"hp":hp,
				"age":age
		};
		
		// 전송하기
		$.ajax({
			url:'./data/register.jsp',
			method:'post',
			data:jsonData,
			datatype:'json',
			success: function(data){
				
				if(data.result == 1){
					alert('입력 성공');
				}else{
					alert('입력 실패!');
				}
			}
		});
	});
}