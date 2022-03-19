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
		if(user.getUserPassword() == null || request.getParameter("userUpdatePassword") == null || request.getParameter("userPasswordCheck") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if(request.getParameter("userUpdatePassword").length() < 4) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호 길이가 적당하지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				UserDAO userDAO = new UserDAO();
				int result = userDAO.pwupdate((String) session.getAttribute("userID"), user.getUserPassword(), 
						request.getParameter("userUpdatePassword"), request.getParameter("userPasswordCheck"));
				if(result == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호가 틀립니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else if(result == 0) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호 확인이 일치하지 않습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else { //회원정보 변경 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원정보가 성공적으로 변경되었습니다.')");
					script.println("location.href = 'userInfo.jsp' ");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>