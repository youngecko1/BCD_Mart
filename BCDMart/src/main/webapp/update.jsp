<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
    <%@ page import = "user.UserDAO" %>
    <%@ page import = "user.User" %>
    <%@ page import = "community.CommunityDAO" %>
    <%@ page import = "community.Community" %>
    <jsp:useBean id="comms" class="community.Community" scope="page"></jsp:useBean>
	<jsp:setProperty name="comms" property="title"/>
	<jsp:setProperty name="comms" property="content"/>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>BCD MART</title>
</head>
<body>
<% 
String user_id = null;
String nickname = null;
	if(session.getAttribute("userID") != null){
		user_id = (String)session.getAttribute("userID");
			UserDAO dao = UserDAO.getInstance();
			nickname = dao.getUserinfo(user_id).getNickname();
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
%>
    <nav class ="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">BCD MART</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li><a href="buy.jsp">BUY</a></li>
                    <li><a href="sell.jsp">SELL</a></li>
                 
                 <li><a href="community.jsp">COMMUNITY</a></li>
                   <li><a href="coupon.jsp">COUPON</a></li>
            
           </ul>
            <%
            if(user_id == null) {
            	 %>
            	<ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">User<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">Login</a></li>
                        <li><a href="join.jsp">Register</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            } else {
            	 %>
            	 <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">Welcome <%= nickname %><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    <li><a href="userpage.jsp">Mypage</a></li>      
                        <li><a href="modify.jsp">Modify</a></li>          
                        <li><a href="logoutAction.jsp">Logout</a></li>                  
                    </ul>
                </li>
            </ul>
            	 <%
            }
            %>
            
        </div>
    </nav>
    <div class = "container">
    <div class = "row">
<form method = "post" action = "updateAction.jsp?article_id=<%= article_id %>">
    <table class = "table table-stripped" style = "text-align: center; border: 1px solid #dddddd">
    <thead>
    <tr>
    <th colspan = "2" style = "background-color: #eeeeee; text-align: center;">Update Article</th>
    </tr>
    </thead>
    <tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="title" name="title" maxlength="50" value = "<%= comm.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>"></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="content" name="content" maxlength="200" style="height: 350px" value = "<%= comm.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>"></td>
						</tr>
					</tbody>

    </tbody>
    <input type = "submit" class = "btn btn-primary pull-right" value = "Update">
    </table>
    
    
    </form>
</div>
    </div>
  

    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>
