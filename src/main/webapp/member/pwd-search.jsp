<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../resources/css/style.css" />
	<title></title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">    
	<div class="row">
		<div class="col">
			<div class="card login-box">
				<p class="text-head1">비밀번호 찾기</p>
<%
	// login.jsp에서는 사용자 인증에 실패한 경우 브라우져에게 재요청 URL(loginform.jsp?login=실패원인)을 응답으로 보낸다.
	// 로그인이 후 사용가능한 JSP페이지를 로그인하지 않고 요청했을 때도 브라우져에게 재요청 URL(loginform.jsp?login=login-required)을 응답으로 보낸다.
	
	// loginform.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 로그인 링크를 눌러서 loginform.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 로그인에 실패한 경우, 로그인이 필요한 JSP를 로그인없이 이용한 경우에만 loginform.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");
	
	if ("emptyt".equals(error)) {						// login.jsp에서 사용자 인증처리를 할 때 id와 password값이 비어 있었다.
%>
			<div class="alert alert-danger">
					<strong>비밀번호를 입력해주세요.</strong>
				</div>
			
<%
	} else if ("mismatch-pwd".equals(error)) {
%>
				<div class="alert alert-danger">
					<strong>비밀번호가 일치하지 않습니다.</strong>
				</div>
<%
	}
%>
			
				<form method="post" action="checkPwdform.jsp">
					<div class="pwd-box">
						<label class="form-label" for="user-password"></label>
						<input class="form-control" type="password" name="pwd" id="user-pwd" placeholder="비밀번호를 입력해주세요." />
					</div>
					<div class="submit-box">
						<button type="submit" class="btn btn-dark" >확인</button>
					</div>
				</form>
				
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>