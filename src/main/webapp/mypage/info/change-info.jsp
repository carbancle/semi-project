<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="/semi-project/resources/css/style.css" />
    <title>개인정보 수정</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">    
<%
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(loginUserInfo.getNo());
	
	String referer = request.getHeader("referer");

	if (referer == null) {
%>
		<script>
			alert("정상적인 경로를 통해 다시 접근해 주세요.");
			history.back();
		</script>
<%
		return;
	}
%>
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>마이페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
		<div class="col-2 p-0 aside">
			<span class="aside-title">마이 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../main.jsp" class="nav-link p-0">마이페이지</a></li>
			</ul>
			<span class="aside-title d-block mt-4">개인정보</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="pwd-confirm2.jsp" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="pwd-confirm.jsp" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="leaveform.jsp" class="nav-link p-0">회원 탈퇴</a></li>
			</ul>
			<span class="aside-title d-block mt-4">쇼핑수첩</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="../claim/cancel-main.jsp" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
			</ul>
		</div>
		<!-- //aside 끝 -->
		<div class="offset-md-1 col-9 p-0">
			<div class="row">
				<div class="col">
					<p class="text-head2">개인정보 변경</p>
						<form method="get" action="change-infoform.jsp">
							<div class="register-box">
								<div>
									<label class="form-label" for="user-name">이름</label> <input
										type="text" class="form-control" name="name" id="user-name"
										value="<%=loginUserInfo.getName() %>" disabled="disabled">
								</div>
								<div>
									<label class="form-label" for="user-id">아이디</label> <input
										type="text" class="form-control" name="id" id="user-id"
										value="<%=loginUserInfo.getId() %>" disabled="disabled" />
								</div>
								<div>
									<label class="form-label" for="user-pwd">비밀번호</label>
									<input type="password" class="form-control" name="pwd" id="user-pwd" value="<%=loginUserInfo.getPwd() %>" disabled="disabled" />
								</div>
								<div>
									<label class="form-label" for="user-address">주소<span>*</span></label>
									<input type="text" class="form-control" name="address"
										id="user-address" placeholder="주소를 입력해주세요." />
								</div>
								<div>
									<label class="form-label" for="user-email">이메일<span>*</span></label>
									<input type="text" class="form-control" name="email"
										id="user-email" placeholder="이메일을 입력해주세요." />
								</div>
								<div>
									<label class="form-label" for="user-tel">휴대폰 번호<span>*</span></label>
									<input type="text" class="form-control" name="tel"
										id="user-tel" placeholder="휴대폰 번호를 입력해주세요." />
								</div>
								<div class="btn-box text-center">
									<button type="submit" class="btn btn-lg btn-dark">확인</button>
								</div>
							</div>
						</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>