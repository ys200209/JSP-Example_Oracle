<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "user.User" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "vw_order.Vw_order" %>
<%@ page import = "vw_order.Vw_orderDAO" %>
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
	<h2 style = "text-align : center">내정보</h2>
	<%
		UserDAO userDAO = new UserDAO();
		int point = userDAO.Point(userID);
	%>
	<div class = "container">
		<div class = "col-4"></div> 
			 <div class = "jumbotron"  style= "padding-top : 1px;">
				<br/><h3 style = "text-align : center">아이디 : <%= session.getAttribute("userID")  %></h3>
				<h3 style = "text-align : center">적립된 포인트 : <%= point  %></h3>
					<h3 style = "text-align : center">개인정보 변경하기</h3><br/>
					<div class = "form-group">
						<p  style="text-align : center"><a href="idUpdate.jsp" style="margin-right:15px">아이디 변경</a>
						<a href="pwUpdate.jsp" style="margin-left:15px">비밀번호 변경</a></p>
					</div>
					</div>
					<h3 style = "text-align : center">내가 주문한 상품들</h3><br/>
					<table class = "table table-bordered" style = "text-align : center; border : 1px solid #dddddd">
						<thead>
							<tr>
								<th style = "background-color : #eeeeee; text-align : center;">주문 번호</th>
								<th style = "background-color : #eeeeee; text-align : center;">상품 이름</th>
								<th style = "background-color : #eeeeee; text-align : center;">상품 가격</th>
								<th style = "background-color : #eeeeee; text-align : center;">주문 날짜</th>
							</tr>
						</thead>
						<tbody>
							<%
								Vw_orderDAO vw_orderDAO = new Vw_orderDAO();
								ArrayList<Vw_order> list = vw_orderDAO.getListOrder(userID);
								for(int i = 0; i < list.size(); i++) {
							%>
								<tr>
									<td><%= list.get(i).getOrderID() %></td>
									<td><%= list.get(i).getItemName() %></td>
									<td><%= list.get(i).getItemPrice() %></td>
									<td><%= list.get(i).getOrderDate().substring(0,10) %></td>
								</tr>
							<%
								}
							%>
					</tbody>
				</table>
		<div class = "col-4"></div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>