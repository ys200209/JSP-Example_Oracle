<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "items.ItemsDAO" %>
<%@ page import = "items.Items" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!--<jsp:useBean id="items" class = "items.Items" scope = "page"/>
<jsp:setProperty name = "items" property = "itemID" />
<jsp:setProperty name = "items" property = "itemName" />
<jsp:setProperty name = "items" property = "itemPrice" />
<jsp:setProperty name = "items" property = "itemContent" />-->

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
			if(!userID.equals("root")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('접근 권한이 없습니다.')");
				script.println("location.href = 'login.jsp' ");
				script.println("</script>");
			}
			int itemID = 0;
			if(request.getParameter("itemID") != null) {
				itemID = Integer.parseInt(request.getParameter("itemID"));
			}
			Items items1 = new ItemsDAO().getItems(itemID);
			if(itemID == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 상품입니다.')");
				script.println("location.href = 'shoping.jsp' ");
				script.println("</script>");
			} else {
				ItemsDAO itemsDAO = new ItemsDAO();
				int result = itemsDAO.delete(itemID);
				System.out.println("result의 값은 : " + result);
				if(result == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('상품삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('상품을 성공적으로 삭제하였습니다. ')");
					script.println("location.href = 'shoping.jsp' ");
					script.println("</script>");
				}
			}
	%>
</body>
</html>