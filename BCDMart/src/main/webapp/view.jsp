<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.Community" %>
<%@ page import="community.CommunityDAO" %>
        <%@ page import = "user.UserDAO" %>
       <%@ page import = "user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<jsp:useBean id="community" class="community.Community" scope="page" />
<jsp:setProperty name="community" property="title" />
<jsp:setProperty name="community" property="article_id" />
<jsp:setProperty name="community" property="content" />
<title>BCD MART</title>
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
	String nickname = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
				UserDAO dao = UserDAO.getInstance();
				nickname = dao.getUserinfo(userID).getNickname();
			}
		

		// bbsID를 초기화 시키고
		// 'bbsID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int article_id = 0;
		if(request.getParameter("article_id") != null){
			article_id = Integer.parseInt(request.getParameter("article_id"));
			session.setAttribute("article_id", article_id);
			}
			
		
		
		// 만약 넘어온 데이터가 없다면
		if(article_id == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This article is not valid')");
			script.println("location.href='community.jsp'");
			script.println("</script");
		}
		
		// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
		CommunityDAO dao = new CommunityDAO();
		Community bbs = dao.getCommunity(article_id);
		

		int count = 0;

		if(session.getAttribute("count") != null)
		{
			count = ((Integer)session.getAttribute("count")).intValue();
			
		}

		else
		{
			count = 0;	
		}

		count++;
		dao.setViewCnt(bbs.getArticle_id());
		%>


		<%
		session.setAttribute("count", new Integer(count));
		
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
            if(userID == null) {
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
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 글 보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">Community List</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">Title</td>
						<td colspan="2"><%= bbs.getTitle().replaceAll(" ", "&nbsp;")
								.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>Writer</td>
						<td colspan="2"><%= bbs.getEmail() %></td>
					</tr>
					<tr>
						<td>Date</td>
						<td colspan="2"><%= dao.getDate(article_id) %></td>
					</tr>
					<tr>
						<td>Likes</td>
						<td colspan="2"><%= bbs.getLikes() %></td>
					</tr>
					<tr>
						<td>Views</td>
						<td colspan="2"><%= count %></td>
					</tr>
					<tr>
						<td>Content</td>
						<td colspan="2" style="height: 200px;"><%= bbs.getContent().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>

				</tbody>
			</table>
			<div>
			<a href="community.jsp" class="btn btn-primary">List</a>
			<a href="likeaction.jsp" class="btn btn-primary">Like</a>
			<%
				if(userID != null && userID.equals(bbs.getEmail())){
			%>
					<a href="update.jsp?article_id=<%= article_id %>" class="btn btn-primary">Modify</a>
					<a href="deleteAction.jsp?article_id=<%= article_id %>" class="btn btn-primary">Delete</a>
			<%
				}
			%>
			</div>
			
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			
		</div>
	</div>
	<!-- 게시판 글 보기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>