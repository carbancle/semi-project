<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/semi-project/resources/css/style.css" />
	<title></title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container" id="member-join">    
	<div class="row">
		<div class="col">
			<p class="text-head2">회원가입</p>
<%
	// register.jsp에서는 회원가입에 실패한 경우 브라우져에게 재요청 URL(member-join.jsp?login=실패원인)을 응답으로 보낸다.
	
	// member-join.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 회원가입 링크를 눌러서 member-join.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 회원가입에 실패한 경우에만 member-join.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");
%>
<%
	if ("notEqualPwd".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>회원가입 실패</strong> 비밀번호가 일치하지 않습니다.
			</div>
<%
	} else if ("id-exists".equals(error)) {					// register.jsp에서 회원가입을 처리할 때 이미 사용중인 아이디로 밝혀졌다.
%>
			<div class="alert alert-danger">
				<strong>회원가입 실패</strong> 다른 사용자가 사용중인 아이디입니다.
			</div>
<%
	} else if ("email-exists".equals(error)) {			// register.jsp에서 회원가입을 처리할 때 이미 사용중인 이메일로 밝혀졌다.
%>
			<div class="alert alert-danger">
				<strong>회원가입 실패</strong> 다른 사용자가 사용중인 이메일입니다.
			</div>
<%
	}
%>
			<form method="post" action="register.jsp">
				<div class="register-box">
					<div>
						<label class="form-label" for="user-name">이름<span>*</span></label>
						<input type="text" class="form-control" name="name" id="user-name" placeholder="이름을 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="user-id">아이디<span>*</span></label>
						<input type="text" class="form-control" name="id" id="user-id" placeholder="아이디를 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="user-pwd">비밀번호<span>*</span></label>
						<input type="password" class="form-control" name="pwd" id="user-pwd" placeholder="비밀번호를 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="again-pwd">비밀번호 확인<span>*</span></label>
						<input type="password" class="form-control" name="againPwd" id="again-pwd" placeholder="비밀번호를 다시 한 번 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="user-address">주소<span>*</span></label>
						<input type="text" class="form-control" name="address" id="user-address" placeholder="주소를 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="user-email">이메일<span>*</span></label>
						<input type="text" class="form-control" name="email" id="user-email" placeholder="이메일을 입력해주세요." />
					</div>
					<div>
						<label class="form-label" for="user-tel">휴대폰 번호<span>*</span></label>
						<input type="text" class="form-control" name="tel" id="user-tel" placeholder="휴대폰 번호를 입력해주세요." />
					</div>
				</div>
				<div class="btn-box text-center">
					<button type="button" class="btn btn-lg btn-secondary">취소</button>
					<button type="submit" class="btn btn-lg btn-dark">회원가입</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>