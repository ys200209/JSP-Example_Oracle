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
<title>JSP 홈쇼핑 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
			UserDAO userDAO = new UserDAO();
			int result = userDAO.drop(user, userID);
			System.out.println("result의 값은 : " + result);
			if(result == -1) { //회원탈퇴 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(result == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 일치하지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { //회원탈퇴 성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원탈퇴가 성공적으로 이루어졌습니다.')");
				session.invalidate();
				script.println("location.href = 'login.jsp' ");
				script.println("</script>");
			}
	%>
</body>
</html>