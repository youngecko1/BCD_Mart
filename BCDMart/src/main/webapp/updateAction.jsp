<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.CommunityDAO" %>
    <%@ page import = "community.Community" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:useBean id="comms" class="community.Community" scope="page"></jsp:useBean>
	<jsp:setProperty name="comms" property="title"/>
	<jsp:setProperty name="comms" property="content"/>
<title>BCD MART</title>
</head>
<body>
    <%
    String user_id = null;
    if(session.getAttribute("userID") != null) {
    	user_id = (String) session.getAttribute("userID");
    }
    if(user_id == null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('Need to log in.')");
         script.println("location.href = 'login.jsp'");
         script.println("</script>");
    }
    int article_id = 0;
    if(request.getParameter("article_id") != null){
    	article_id = Integer.parseInt(request.getParameter("article_id"));
    }
    if(article_id == -1) {
    	 PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Not valid article.')");
        script.println("location.href = 'community.jsp'");
        script.println("</script>");
    }
    
    CommunityDAO dao = CommunityDAO.getInstance();
    		Community comm = dao.getCommunity(article_id);
  
    if(!user_id.equals(comm.getEmail())) {
    	 PrintWriter script = response.getWriter();
    	    script.println("<script>");
    	    script.println("alert('You are not the owner of the article.')");
    	    script.println("location.href = 'community.jsp'");
    	    script.println("</script>");
    }
    else {
        if(request.getParameter("title") == null) {
        	    	 PrintWriter script = response.getWriter();
        	         script.println("<script>");
        	         script.println("alert('The title is not written.')");
        	         script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        	         script.println("</script>");
        	    }

        	    else {
        	    			int result = dao.modify(request.getParameter("title"), request.getParameter("content"), article_id);
                	    	if(result == -1) {
                	    		PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('Failed to update.')");
                	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	            script.println("</script>");
                	           
                	            
                	    	} 
                	    	else {
                	            PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('Successfully updated')");
                	            script.println("location.href = 'community.jsp'");
                	            script.println("</script>");
                	        }
                	    }
        	    		}
    %>
 
</body>
</html>
