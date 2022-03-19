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
<jsp:setProperty name = "user" property = "userName" />
<jsp:setProperty name = "user" property = "userGender" />
<jsp:setProperty name = "user" property = "userEmail" />
<jsp:setProperty name = "user" property = "userSecurity" />
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
			if (userID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인 중입니다.')");
				script.println("location.href = 'main.jsp' ");
				script.println("</script>");
			}
			if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserEmail() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				if(user.getUserPassword().length() < 4) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호 길이가 적당하지 않습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					UserDAO userDAO = new UserDAO();
					int result = userDAO.join(user);
					if(result == -1) { 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('이미 존재하는 아이디입니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else { //회원가입에 성공 한다면
						//session.setAttribute("userID", user.getUserID());
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('회원가입이 성공적으로 이루어졌습니다.')");
						script.println("location.href = 'login.jsp' ");
						script.println("</script>");
					}
				}
			}
	%>
</body>
</html>