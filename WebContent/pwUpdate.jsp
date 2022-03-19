<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
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
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded = "false">접속하기<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "userInfo.jsp">내정보</a></li>
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
						<li><a href = "drop.jsp">회원탈퇴</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class = "container">
		<div class = "col-lg-4"></div> 
		<div class = "col-lg-4">
			 <div class = "jumbotron"  style= "padding-top : 20px;">
				<form method = "post" action = "pwUpdateAction.jsp" autocomplete="off">
					<h3 style = "text-align : center">비밀번호 변경</h3>
					<div class = "form-group">
						<input type = "password" class = " form-control" placeholder="현재 비밀번호" name = "userPassword" maxlength = "20">
					</div>
					<div class = "form-group">
						<input type = "password" class = " form-control" placeholder="변경할 비밀번호(4자리 이상)" name = "userUpdatePassword" maxlength = "20">
					</div>
					<div class = "form-group">
						<input type = "password" class = " form-control" placeholder="변경할 비밀번호 확인" name = "userPasswordCheck" maxlength = "20">
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "변경하기">
				</form>
			</div>
		</div>
		<div class = "col-lg-4"></div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>