<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "calculator.Bbs" %>
<%@ page import = "calculator.BbsDAO" %>
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
		int bbsID = 0;
		
		if(request.getParameter("bbsID") != null) {
			System.out.println("bbsID null이 아닙니다. : " + request.getParameter("bbsID"));
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0) {
			System.out.println("bbsID 0입니다. : " + request.getParameter("bbsID"));
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp' ");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		System.out.println("(main) session.getAttribute(userID) = " + userID);
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
				<li class = "active"><a href = "bbs.jsp">게시판</a></li>
			</ul>
		<%
		if(userID == null) {
		%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
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
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "true"
						aria-expanded = "false">접속하기<span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan = "3" style = "background-color : #eeeeee; text-align : center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style ="width:20%">글제목</td>
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,10) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style = "min-height:200px; text-align:left"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href = "bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a href = "update.jsp?bbsID=<%= bbsID %>" class = "btn btn-primary">수정</a>
					<a href = "deleteAction.jsp?bbsID=<%= bbsID %>" class = "btn btn-primary">삭제</a>
			<%
				}
			%>
			<input type = "submit"  class = "btn btn-primary pull-right" value = "글쓰기">
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>