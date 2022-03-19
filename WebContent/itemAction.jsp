<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "items.ItemsDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="items" class = "items.Items" scope = "page"/>
<jsp:useBean id="user" class = "user.User" scope = "page"/>
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "items" property = "itemName" />
<jsp:setProperty name = "items" property = "itemPrice" />
<jsp:setProperty name = "items" property = "itemContent" />
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
			if (userID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요')");
				script.println("location.href = 'login.jsp' ");
				script.println("</script>");
			} else {
				if(items.getItemName() == null || items.getItemPrice() == 0 || items.getItemContent() == null ) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('제대로 입력을 해주세요.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					ItemsDAO itemsDAO = new ItemsDAO();
					int result = itemsDAO.itemupdate(items.getItemName(), items.getItemPrice(), items.getItemContent());
					System.out.println("result의 값은 : " + result);
					if(result == -1) { 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('상품추가에 실패하였습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'shoping.jsp' ");
						script.println("</script>");
					}
				}				
			}
	%>
</body>
</html>