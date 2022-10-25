<%@page import="config.DBCP"%>
<%@page import="Bean.ProductBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	List<ProductBean> product = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `product`");
		
		while(rs.next()){
			ProductBean pb = new ProductBean();
			pb.setPrno(rs.getString(1));
			pb.setPrname(rs.getString(2));
			pb.setPrstock(rs.getString(3));
			pb.setPrprice(rs.getString(4));
			pb.setPrcompany(rs.getString(5));
			
			product.add(pb);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>product::list</title>
		<!-- 
			날짜 : 2022/10/25
			이름 : 박종협
			내용 : SQL 응용 수행평가
		 -->
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(function(){
			
			$(document).on('click', '#btnOrder', function(e){
				e.preventDefault();
				
				let prodno = $(this).val();
				
				$('section').empty();
				$('nav').empty().append("<h4>주문하기</h4>");
				
				let table = "<table border='1'>";
				   table += "<tr>";
				   table += "<td>상품번호</td>";
				   table += "<td><input type='text' name='prodno' value='"+prodno+"' placehorder=''></td>";
				   table += "</tr>";
				   table += "<tr>";
				   table += "<td>수량</td>";
				   table += "<td><input type='text' name='orcount' placehorder=''></td>";
				   table += "</tr>";
				   table += "<tr>";
				   table += "<td>주문자</td>";
				   table += "<td><input type='text' name='orid' placehorder=''></td>";
				   table += "</tr>";
				   table += "<tr>";
				   table += "<td colspan='2' align='right'><input type='submit' id='submit' value='주문하기'></td>";
				   table += "</tr>";
				   table += "</table>";
				   
				$('section').append(table);
			});
			
			$(document).on('click', '#submit', function(e){
				e.preventDefault();
				
				let prodno  = $('input[name=prodno]').val();
				let orcount = $('input[name=orcount]').val();
				let orid    = $('input[name=orid]').val();
				
				let jsondata = {
						"prodno":prodno,
						"orcount":orcount,
						"orid":orid
				};
				
				$.ajax({
					url:'./proc/orRegister.jsp',
					method:'post',
					data:jsondata,
					datatype:'json',
					success: function(data){
						
						console.log(data.result);
						
						if(data.result == 1){
							alert('주문완료!');
						}else{
							alert('주문실패!');
						}
					}
				});
			});
		});

	</script>
	<body>
		<h3>상품목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<% for(ProductBean pb : product) { %>
			<tr>
				<td><%= pb.getPrno() %></td>
				<td><%= pb.getPrname() %></td>
				<td><%= pb.getPrstock() %></td>
				<td><%= pb.getPrprice() %></td>
				<td><%= pb.getPrcompany() %></td>
				<td>
					<button id="btnOrder" value="<%= pb.getPrno() %>">주문</button>
				</td>
			</tr>
			<% } %>
		</table>
		<nav></nav>
		<section></section>
	</body>
</html>