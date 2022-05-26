<%@page import="java.io.PrintWriter"%>
<%@page import="shoe.ShoeDAO"%>
<%@page import="shoe.Shoe"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="shoe" class="shoe.Shoe" scope="page" />
<jsp:setProperty name="shoe" property="upload_id" />
<jsp:setProperty name="shoe" property="brand" />
<jsp:setProperty name="shoe" property="shoe_name" />
<jsp:setProperty name="shoe" property="color" />
<jsp:setProperty name="shoe" property="quantity" />
<jsp:setProperty name="shoe" property="sizes" />
<jsp:setProperty name="shoe" property="pimg" />
<jsp:setProperty name="shoe" property="price" />
<jsp:setProperty name="shoe" property="type" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BCD MART</title>
</head>
<body>
<%
	String userid = null;
	if(session.getAttribute("userID") != null){
		userid = (String)session.getAttribute("userID");
	}
	// 이미 로그인했으면 회원가입을 할 수 없게 한다
	if(userid == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please Log in!')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
	}

	if(shoe.getShoe_name() == null || shoe.getBrand() == null || shoe.getColor() == null || shoe.getQuantity() == 0 || shoe.getpimg() == null 
	|| shoe.getPrice() == 0 || shoe.getSizes() == 0 || shoe.getType() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You are missing something')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			ShoeDAO dao = ShoeDAO.getInstance();
			int price = dao.FindShoePrice(shoe.getShoe_name(), shoe.getBrand());
			if(shoe.getPrice() != price){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Something is wrong')");
				script.println("history.back()");
				script.println("</script>");
				}
			else{
				int result = dao.sell(shoe.getBrand(), shoe.getShoe_name(), shoe.getColor(), shoe.getQuantity(), shoe.getSizes(), shoe.getpimg());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('The Upload was not valid')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					int result2 = dao.upload(userid);
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Successfully uploaded')");
					script.println("'location.href='buy.jsp'");
					script.println("</script>");
				}
				
			}
		}
		
	
	%>
</body>
</html>