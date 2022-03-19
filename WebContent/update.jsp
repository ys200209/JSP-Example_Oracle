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
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} else {
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
		System.out.println("items.getItemID() = " + items.getItemID());
		if(!userID.equals("root")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 권한이 없습니다.')");
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
				<li><a href = "bbs.jsp">게시판</a></li>
				<li><a href = "shoping.jsp">주문하기</a></li>
			</ul>
		</div>
	</nav>
	<div class = "container">
		<div class = "col-lg-4"></div> 
		<div class = "col-lg-4">
			 <div class = "jumbotron"  style= "padding-top : 20px;">
				<form method = "post" action = "updateAction.jsp?itemID=<%= items.getItemID() %>&" autocomplete="off">
					<h3 style = "text-align : center">상품 정보 수정</h3>
					<div class = "form-group">
						<input type = "text" class = " form-control" placeholder="상품 이름" name = "itemName" maxlength = "20" autocomplete="off" value = "<%= items.getItemName() %>" >
					</div>
					<div class = "form-group">
						<input type = "text" class = " form-control" placeholder="상품 가격" name = "itemPrice" maxlength = "20" autocomplete="off" value = "<%= items.getItemPrice() %>">
					</div>
					<div class = "form-group">
						<input type = "text" class = " form-control" placeholder = "상품 설명" name = "itemContent" maxlength = "512" style = "height : 150px" autocomplete="off" value = "<%= items.getItemContent() %>">
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "상품 재등록">
				</form>
			</div>
		</div>
		<div class = "col-lg-4"></div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>