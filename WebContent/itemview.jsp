<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "items.Items" %>
<%@ page import = "items.ItemsDAO" %>
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
		String userID = (String)session.getAttribute("userID");
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
		int itemID = 0;
		if(request.getParameter("itemID") != null) {
			itemID = Integer.parseInt(request.getParameter("itemID"));
		}
		if(itemID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 상품입니다.')");
			script.println("location.href = 'shoping.jsp' ");
			script.println("</script>");
		}
		Items items = new ItemsDAO().getItems(itemID);
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
				<% }%>
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
						<th colspan = "3" style = "background-color : #eeeeee; text-align : center;">상품 세부정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style ="width:20%">상품 번호</td>
						<td colspan="2"><%= items.getItemID() %></td>
					</tr>
					<tr>
						<td>상품 이름</td>
						<td colspan="2"><%= items.getItemName() %></td>
					</tr>
					<tr>
						<td>상품 가격</td>
						<td colspan="2"><%= items.getItemPrice() %></td>
					</tr>
					<tr>
						<td>상품 설명</td>
						<td colspan="2" style = "min-height:200px; text-align:left"><%= items.getItemContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href = "shoping.jsp" class="btn btn-primary">목록</a>
			
			<%
				if(userID != null && userID.equals("root")) {
			%>
					<a href = "update.jsp?itemID=<%= items.getItemID() %>" class = "btn btn-primary">수정</a>
					<a href = "deleteAction.jsp?itemID=<%= items.getItemID() %>" class = "btn btn-primary">삭제</a>
			<%
				}
			%>  
			
			<a href = "buyAction.jsp?itemID=<%= items.getItemID() %>" class = "btn btn-primary pull-right">구매하기</a>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>