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
				if(request.getParameter("itemName") == null || request.getParameter("itemContent") == null ) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('제대로 입력을 해주세요.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					System.out.println("11 itemID() = " + itemID);
					System.out.println("11 items.getItemID() = " + items.getItemID());
					System.out.println("11 items.getItemName() = " + items.getItemName());
					System.out.println("11 items.getItemPrice() = " + items.getItemPrice());
					System.out.println("11 items.getItemContent() = " + items.getItemContent());
					ItemsDAO itemsDAO = new ItemsDAO();
					int result = itemsDAO.update(itemID, request.getParameter("itemName"), Integer.parseInt(request.getParameter("itemPrice")), request.getParameter("itemContent"));
					System.out.println("result의 값은 : " + result);
					if(result == -1) { 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('상품수정에 실패하였습니다.')");
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