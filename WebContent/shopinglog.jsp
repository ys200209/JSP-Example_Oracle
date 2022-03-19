<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vw_order.Vw_order" %>
<%@ page import = "vw_order.Vw_orderDAO" %>
<jsp:useBean id="user" class = "user.User" scope = "page"/>
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width"  initial-scale = "1"> <!-- 어느 디바이스에서나 적용되는 부트스트랩 반응형 웹 메타 태그 -->
<link rel = "stylesheet" href = "css/bootstrap.css">
<title>JSP 홈쇼핑 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	} 
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인후 이용해주세요.')");
		script.println("location.href = 'login.jsp' ");
		script.println("</script>");
	}
	
	if(!userID.equals("root")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근 권한이 없습니다.')");
		script.println("location.href = 'main.jsp' ");
		script.println("</script>");
	}
	%>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button"  class = "navbar-toggle collapsed" 
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href = "main.jsp">JSP 홈쇼핑 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href = "main.jsp">메인</a></li>
				<li><a href = "shoping.jsp">주문하기</a></li>
				<li class = "active"><a href = "shopinglog.jsp">주문내역 확인</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded = "false">접속하기<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "rootInfo.jsp">회원정보</a></li>
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<h2 style = "text-align : center">주문 목록</h2><br/>
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
				<thead>
					<tr>
						<th style = "background-color : #eeeeee; text-align : center;">주문 번호</th>
						<th style = "background-color : #eeeeee; text-align : center;">회원 아이디</th>
						<th style = "background-color : #eeeeee; text-align : center;">상품 이름</th>
						<th style = "background-color : #eeeeee; text-align : center;">상품 가격</th>
						<th style = "background-color : #eeeeee; text-align : center;">주문 날짜</th>
					</tr>
				</thead>
				<tbody>
				<%
				Vw_orderDAO vw_order = new Vw_orderDAO();
					ArrayList<Vw_order> list = vw_order.getList();
					for(int i = 0; i < list.size(); i++) {
				%>
					<tr>
						<td><%= list.get(i).getOrderID() %></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getItemName() %></td>
						<td><%= list.get(i).getItemPrice() %></td>
						<td><%= list.get(i).getOrderDate() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>