<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import = "java.io.PrintWriter"%>
<%@ page import = "community.CommunityDAO"%>
<%@ page import = "community.Community"%>
<%@ page import = "user.UserDAO"%>
<%@ page import = "user.User"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>Community</title>
</head>
<body>
<% 
String userid = null;
String nickname= null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(userid).getNickname();
}

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
            if(userid == null) {
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
                    <ul class="dropdown-menu"><li><a href="userpage.jsp">Mypage</a></li> 
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
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">Num</th>
						<th style="background-color: #eeeeee; text-align: center;">Title</th>
						<th style="background-color: #eeeeee; text-align: center;">Writer</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
				</thead>
				<tbody>
					<%
						CommunityDAO com = new CommunityDAO(); // 인스턴스 생성
						ArrayList<Community> list = com.getListComp();
						for(int i = 0; i < list.size(); i++){
							Date dt = com.getDate(list.get(i).getArticle_id());
					%>
					<tr>
						<td><%= list.get(i).getArticle_id() %></td>
						<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td><a href="view.jsp?article_id=<%= list.get(i).getArticle_id() %>">
							<%= list.get(i).getTitle() %></a></td>
						<td><%= list.get(i).getEmail() %></td>
						<td><%= dt %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<!-- 글쓰기 버튼 생성 -->
			<a href="write.jsp" class="btn btn-primary pull-right">Write</a>
		</div>
	</div>

	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>