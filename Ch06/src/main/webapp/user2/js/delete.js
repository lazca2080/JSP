
function btndelete(d){
	
	$(function(){
			
		let uid = d.eq(0).text();
			
			let jsonData = {
				"uid" : uid
			};
			
			$.ajax({
			url:'./data/delete.jsp',
			method:'post',
			data:jsonData,
			datatype:'json',
			success: function(data){
				
				if(data.result == 1){
					alert('삭제 성공');
					list();
				}else{
					alert('삭제 실패!');
				}
			}
		});
	});
}