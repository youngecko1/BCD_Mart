<%@page import="java.io.PrintWriter"%>
<%@page import="shoe.ShoeDAO"%>
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
	String upload_id = null;
	if(session.getAttribute("upload_id") != null){
		upload_id = (String)session.getAttribute("upload_id");
	}	

	if(upload_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This shoe is no longer available')");
		script.println("location.href='buy.jsp'");
		script.println("</script");
	}
	
			ShoeDAO dao = ShoeDAO.getInstance();
			int result = dao.buy(userid, upload_id);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Failed uploading')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Successfully Purchased')");
				script.println("location.href='buy.jsp'");
				script.println("</script>");
			}
		
		
		
	%>
</body>
</html>