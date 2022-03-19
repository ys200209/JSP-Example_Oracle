<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "items.Items" %>
<%@ page import = "items.ItemsDAO" %>
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
<style type="text/css">
		a, a:hover{
			color : #000000;
			text-decoration : none;
		}
</style>
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
				<li class = "active"><a href = "shoping.jsp">주문하기</a></li>
				<% if(userID.equals("root")) {%>
				<li><a href = "shopinglog.jsp">주문내역 확인</a></li>
				<% } %>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle" 
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded = "false">접속하기<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
					<%
						if(userID.equals("root")) {
					%>
						<li><a href = "rootInfo.jsp">회원정보</a></li>
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
					<% } else{ %>
						<li><a href = "userInfo.jsp">내정보</a></li>
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
						<li><a href = "drop.jsp">회원탈퇴</a></li>
					<% } %>
						
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
				<thead>
					<tr>
						<th style = "background-color : #eeeeee; text-align : center;">상품 번호</th>
						<th style = "background-color : #eeeeee; text-align : center;">상품 이름</th>
						<th style = "background-color : #eeeeee; text-align : center;">상품 가격</th>
						<th style = "background-color : #eeeeee; text-align : center;">구매 선택</th>
					</tr>
				</thead>
				<tbody>
				<%
					ItemsDAO itemDAO = new ItemsDAO();
					ArrayList<Items> list = itemDAO.getList();
					for(int i = 0; i < list.size(); i++) {
				%>
					<tr>
						<td><%= list.get(i).getItemID() %></td>
						<td><%= list.get(i).getItemName() %></td>
						<td><%= list.get(i).getItemPrice() %></td>
						<td><a href = "itemview.jsp?itemID=<%= list.get(i).getItemID() %>" class = "btn btn-primary">구매하기</a></td>
					</tr>
				<%
					}
				%>
					
				</tbody>
			</table>
			<%
			if(userID.equals("root")) {
			%>
			<a href = "itemupdate.jsp" class = "btn btn-primary pull-right">상품 추가</a>
			<%
			}
			%>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>