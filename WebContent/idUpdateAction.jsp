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
		if(user.getUserID() == null || user.getUserPassword() == null || request.getParameter("userUpdateID") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if(session.getAttribute("userID").equals(request.getParameter("userID"))) { //현재 아이디와 입력한 현재 아이디가 실제로 일치 한다면.
				UserDAO userDAO = new UserDAO();
				int result = userDAO.idupdate(user.getUserID(), request.getParameter("userUpdateID"), user.getUserPassword());
				if(result == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 아이디가 존재합니다.')");
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
				else { //회원정보 변경 성공
					session.setAttribute("userID", request.getParameter("userUpdateID"));
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원정보가 성공적으로 변경되었습니다.')");
					script.println("location.href = 'userInfo.jsp' ");
					script.println("</script>");
				}
			}
			else{ // 입력한 현재 아이디가 잘못되었다면
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('현재 아이디가 올바르지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>