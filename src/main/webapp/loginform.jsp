<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/css/style.css" />
	<title></title>
</head>
<body>
<%@ include file="common/navbar.jsp" %>
<div class="container">    
	<div class="row">
		<div class="col">
			<div class="card login-box">
				<p class="text-head1">로그인</p>
<%
	// login.jsp에서는 사용자 인증에 실패한 경우 브라우져에게 재요청 URL(loginform.jsp?login=실패원인)을 응답으로 보낸다.
	// 로그인이 후 사용가능한 JSP페이지를 로그인하지 않고 요청했을 때도 브라우져에게 재요청 URL(loginform.jsp?login=login-required)을 응답으로 보낸다.
	
	// loginform.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 로그인 링크를 눌러서 loginform.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 로그인에 실패한 경우, 로그인이 필요한 JSP를 로그인없이 이용한 경우에만 loginform.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");
	String user = request.getParameter("user");
	if ("empty".equals(error)) {						// login.jsp에서 사용자 인증처리를 할 때 id와 password값이 비어 있었다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 아이디와 비밀번호는 필수입력값입니다.
			</div>
			
<%
	} else if ("emptyt".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 비밀번호는 필수입력값입니다.
			</div>
<%
	} else if ("notfound-member".equals(error)) {			// login.jsp에서 사용자 인증처리를 할 때 id에 해당하는 회원정보가 검색되지 않았다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 회원정보가 존재하지 않습니다.
			</div>
<%	
	} else if ("mismatch-pwd".equals(error)) {			// login.jsp에서 사용자 인증처리를 회원가입시 입력한 비밀번호와 로그인시 입력한 비밀번호가 일치하지 않았다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 비밀번호가 일치하지 않습니다.
			</div>
<%		
	} else if("login-required".equals(error)) {			// 로그인 후 사용가능한 JSP 페이지를 로그인없이 요청했다.
%>
			<div class="alert alert-danger">
				<strong>로그인 필수!!</strong> 로그인이 필요한 페이지를 요청하였습니다.
			</div>
<%
	} else if ("deleted-user".equals(error)) {
%>
			<div class="alert alert-danger">
				탈퇴한 회원은 로그인할 수 없습니다. <br> 서비스 이용을 원하시면, 다시 회원가입을 진행해 주세요.
			</div>
<%
	} else if ("undefined".equals(user)) {
%>
			<div class="alert alert-danger">
				로그인이 필요한 페이지를 요청하였습니다.
			</div>
<%
	}
%>
				<form method="post" action="login.jsp">
					<div class="id-box">
						<label class="form-label" for="user-id"></label>
						<input class="form-control" type="text" name="id" id="user-id" placeholder="아이디를 입력해주세요." />
					</div>
					<div class="pwd-box">
						<label class="form-label" for="user-pwd"></label>
						<input class="form-control" type="password" name="pwd" id="user-pwd" placeholder="비밀번호를 입력해주세요." />
					</div>
					<div class="submit-box">
						<button type="submit" class="btn btn-dark" >로그인</button>
					</div>
				</form>
				<div class="link-box">
					<div class="row">
						<div class="col p-0 text-center"><a href="mypage/id-search.jsp">아이디 찾기</a></div>
						<div class="col p-0 text-center"><a href="mypage/pwd-search.jsp">비밀번호 찾기</a></div>
						<div class="col p-0 text-center"><a href="member/member-join.jsp">회원가입 </a></div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<%@ include file="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>