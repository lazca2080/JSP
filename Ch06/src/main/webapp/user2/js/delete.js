
function btndelete(){
	
	$(function(){
		
			$.ajax({
			url:'./data/delete.jsp',
			method:'post',
			data:jsonData,
			datatype:'json',
			success: function(data){
				
				if(data.result == 1){
					alert('입력 성공');
					list();
				}else{
					alert('입력 실패!');
				}
			}
		});
	});
}