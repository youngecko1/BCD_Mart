<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="nickname" />
<jsp:setProperty name="user" property="password" />
<jsp:setProperty name="user" property="last_name" />
<jsp:setProperty name="user" property="first_name" />
<jsp:setProperty name="user" property="cell_num" />
<jsp:setProperty name="user" property="district" />
<jsp:setProperty name="user" property="balance" />
<jsp:setProperty name="user" property="gender" />
<jsp:setProperty name="user" property="email" />
<jsp:setProperty name="user" property="joindate" />
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
	if(userid != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Already Logged in')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
		if(user.getEmail() == null || user.getPassword() == null || user.getFirst_name()== null ||
			user.getGender() == null || user.getEmail() == null || user.getLast_name() == null || user.getCell_num() == null || user.getDistrict() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You missed some parts')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('This email already exists')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				session.setAttribute("userID", user.getEmail());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Successfully joined')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>