<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Arrays" %>
<%@ page import = "java.util.Collections" %>
<%@ page import = "user.User" %>
<%@ page import = "user.UserDAO" %>
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
				<li><a href = "shopinglog.jsp">주문내역 확인</a></li>
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
					<%
						} else{
					%>
						<li><a href = "userInfo.jsp">내정보</a></li>
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
						<li><a href = "drop.jsp">회원탈퇴</a></li>
					<%
						}
					%>
						
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<h2 style = "text-align : center">회원 정보들</h2>
	<%
		UserDAO userDAO1 = new UserDAO();
		String max = userDAO1.maxPrice();
	%>
	<div class = "container">
		<div class = "col-4"></div> 
			 <div class = "jumbotron"  style= "padding-top : 20px;">
				<br/><h3 style = "text-align : center">가장 많이 구매한 유저</h3>
					<h3 style = "text-align : center">아이디 : <%=max%> </h3><br/>
					</div>
					<table class = "table table-bordered" style = "text-align : center; border : 1px solid #dddddd">
						<thead>
							<tr>
								<th style = "background-color : #eeeeee; text-align : center;">회원 아이디</th>
								<th style = "background-color : #eeeeee; text-align : center;">회원 이름</th>
								<th style = "background-color : #eeeeee; text-align : center;">회원 주민번호</th>
								<th style = "background-color : #eeeeee; text-align : center;">회원 성별</th>
								<th style = "background-color : #eeeeee; text-align : center;">회원 이메일</th>
								<th style = "background-color : #eeeeee; text-align : center;">가입 날짜</th>
								<th style = "background-color : #eeeeee; text-align : center;">구매 총액</th>
							</tr>
						</thead>
						<tbody>
							<%
								UserDAO userDAO = new UserDAO();
																		ArrayList<User> list = userDAO.getList();
																		for(int i = 0; i < list.size(); i++) {
																			if(!list.get(i).getUserID().equals("root")) {
							%>
								<tr>
									<td><%= list.get(i).getUserID() %></td>
									<td><%= list.get(i).getUserName() %></td>
									<td><%= list.get(i).getUserSecurity() %></td>
									<td><%= list.get(i).getUserGender() %></td>
									<td><%= list.get(i).getUserEmail() %></td>
									<td><%= list.get(i).getUserJoin() %></td>
									<td><%= userDAO.sum(list.get(i).getUserID()) %></td> 
								</tr>
							<%}} %>
					</tbody>
				</table>
		<div class = "col-4"></div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>