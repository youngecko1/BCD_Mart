<%@page import="java.io.PrintWriter"%>
<%@page import="community.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="community" class="community.Community" scope="page" />
<jsp:setProperty name="community" property="title" />
<jsp:setProperty name="community" property="content" />
<jsp:setProperty name="community" property="article_id" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BCD MART</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userid = null;
		if(session.getAttribute("userID") != null){
			userid = (String)session.getAttribute("userID");
		}
		int aid = 0;
		if(session.getAttribute("article_id") != null){
			aid = ((Integer)(session.getAttribute("article_id"))).intValue();
		}
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userid == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please Log in!')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			// 입력이 안 된 부분이 있는지 체크한다
			if(aid == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Some attributes are missing')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				CommunityDAO bbsDAO = new CommunityDAO();
				bbsDAO.setLikes(aid);
				// 데이터베이스 오류인 경우
				
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Successfully Liked')");
					script.println("location.href='community.jsp'");
					script.println("</script>");
				
			}
		}
	
	%>
</body>
</html>