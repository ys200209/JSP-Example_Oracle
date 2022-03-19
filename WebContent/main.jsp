<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
		<%
			if(userID == null) {
		%>
			<ul class = "nav navbar-nav">
				<li class = "active"><a href = "main.jsp">메인</a></li>
				<li><a href = "shoping.jsp">주문하기</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "drp=opdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded = "false">접속하기<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "login.jsp">로그인</a></li>
						<li><a href = "join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class = "nav navbar-nav">
				<li class = "active"><a href = "main.jsp">메인</a></li>
				<li><a href = "shoping.jsp">주문하기</a></li>
				<% if(userID.equals("root")) {%>
				<li><a href = "shopinglog.jsp">주문내역 확인</a></li>
				<% }%>
			</ul>
			<p style = "text-align : right"><%= userID %> 님이 로그인 하셨습니다.</p>
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
			<%
				}
			%>
		</div>
	</nav>
	<br/><h2 style = "text-align : center">데이터베이스 홈쇼핑 사이트</h2><br/>
	<%
		if(userID == null) {
	%>
		<h3 style = "text-align : center">어서오세요 <a href="login.jsp">로그인</a>후 서비스를 이용하실 수 있습니다.</h3><br/>
		
	<% } else { %>
		<% if(userID.equals("root")) { %>
			<h3 style = "text-align : center">관리자 계정입니다.</h3><br/>
		<%} else { %>
		<h3 style = "text-align : center">회원 계정으로 로그인하였습니다.</h3><br/>
		<%} %>
	<%
	}
	%>
	<!-- <h3 style = "text-align : center">스마트 소프트웨어 이세영</h3> -->
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>