/**
 * 
 */

function list(){

$(function(){
	
	$('section').empty();
	$('nav').empty().append("<h4>user2 목록</h4><a href='#' id='userAdd'>user2 등록</a>");
	
	$.get('./data/list.jsp', function(data){
		
	let table = "<table border='1'>";
	   table += "<tr>";
	   table += "<th>아이디</th>";
	   table += "<th>이름</th>";
	   table += "<th>휴대폰</th>";
	   table += "<th>나이</th>";
	   table += "<th>관리</th>";
	   table += "</tr>";
	   table += "</table>";
		
	$('section').append(table);
		
	for(let user of data){
		let tr = "<tr id='users'>"
		   tr += "<td>"+user.uid+"</td>";
		   tr += "<td>"+user.name+"</td>";
		   tr += "<td>"+user.hp+"</td>";
		   tr += "<td>"+user.age+"</td>";
		   tr += "<td>" 
		   tr += "<a href='#' id='modify'>수정</a>"
		   tr += "<a href='#' id='delete'>삭제</a>" 
		   tr += "</td>" 
		   tr += "</tr>";
		   
		$('table').append(tr);
	}
		
	});
	
});
}