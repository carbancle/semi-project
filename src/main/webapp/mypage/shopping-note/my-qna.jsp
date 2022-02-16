
<%@page import="vo.Pagination"%>
<%@page import="dao.QnaDao"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="java.util.List"%>
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
    <title>Q&A</title>
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
					<li class="crumb">쇼핑수첩</li>
					<li class="crumb">나의 상담내역</li>
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
					<li class=""><a href="../info/pwd-confirm2.jsp" class="nav-link p-0">개인정보 수정</a></li>
					<li class=""><a href="../info/pwd-confirm.jsp" class="nav-link p-0">비밀번호 변경</a></li>
					<li class=""><a href="../info/leaveform.jsp" class="nav-link p-0">회원 탈퇴</a></li>
				</ul>
				<span class="aside-title d-block mt-4">쇼핑수첩</span>
				<ul class="nav flex-column p-0">
					<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
					<li class=""><a href="../claim/cancel-main.jsp" class="nav-link p-0">주문 취소</a></li>
					<li class=""><a href="my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
					<li class=""><a href="my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
				</ul>
			</div>
			<!-- //aside 끝 -->
			<div class="offset-md-1 col-9 p-0">
				<div class="card member-box p-0">
					<div class="row g-0">
						<div class="col-2 p-0">
							<span class="icon-grade"></span>
						</div>
						<div class="col-6 p-0 middle-box">
							<p><%=member.getName()%>
								님은 <strong>통합멤버십 회원</strong>입니다.
							</p>
							<span class="member-info">MEMBERSHIP <span
								class="member-number"><%=member.getNo()%></span></span> <span
								class="member-info">멤버십 회원 가입일 <span
								class="member-number"><%=member.getRegisteredDate()%></span></span>
						</div>
						<div class="col-4 p-0 right-box">
							<span class="text-center"><i class="icon-point"></i>포인트</span>
							<span class="point"><%=member.getPct()%><span class="unit">p</span></span>
						</div>
					</div>
				</div>
				<div class="order-list">
					<p>상품 Q&A</p>
					<div class="inquiry-box">
						<div class="row">
<%

	String pageNo = request.getParameter("pageNo");	
	QnaDao qnaDao = QnaDao.getInstance();
	int totalRecords = qnaDao.selectQnACountByMemberNo(member.getNo());
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	List<QnADetailDto> qnaDetails = qnaDao.selectQnAListByMemberNo(pagination.getBegin(), pagination.getEnd(), member.getNo());
	if (qnaDetails.isEmpty()) {
%>
							<div class="p-5">
								<p class="text-center order-font">작성된 상품 Q&A가 없습니다.</p>
							</div>
<%
	} else {
%>
							<div class="col mt-2">
								<span style="margin-left: 5px;">총 <%=totalRecords%>건의
									상담내역이 있습니다.
								</span>
							</div>
						</div>
						<div class="row mt-3">
							<div>
								<div class="accordion accordion-flush" id="faqlist" style="border-top:1px solid #d5d5d5; border-bottom:1px solid #d5d5d5;">
	<%
		for (QnADetailDto detail : qnaDetails) {
	%>
									<div class="accordion-item">
										<div class="row ps-2 pe-2 pt-3 pb-3">
											<div class="col-1">
												<img class="order-img me-2" src="../../resources/images/products/<%=detail.getPhoto()%>">
											</div>
											<div class="col-3" style="position:relative;">
												<div style="position:absolute; top:50%; transform:translateY(-50%); left:40px;">
													<span><strong>상품명</strong></span><br>
													<span><%=detail.getProductName()%></span>
												</div>
											</div>
											<div class="col-3 mt-4 text-center">
												<span><%=detail.getTitle()%></span>
											</div>
											<div class="col mt-4 text-center">
												<span style="font-weight: bold;"><%=detail.getQuestionDate()%></span>
											</div>
			<%
				if ("N".equals(detail.getQuestionAnswered())) {
			%>
											<div class="col mt-4 text-end">
												<span style="font-weight: bold;">미답변</span>
											</div>
			<%
				} else {
			%>
											<div class="col mt-4 text-end">
												<span style="font-weight: bold;">답변완료</span>
											</div>
			<%
				}
			%>
											<div class="col mt-3 text-end">
												<h2 class="accordion-header"
													id="faq-heading-<%=detail.getQnANo()%>">
													<button class="accordion-button collapsed" type="button"
														data-bs-toggle="collapse"
														data-bs-target="#faq-content-<%=detail.getQnANo()%>">
													</button>
												</h2>
											</div>
										</div>
										<div id="faq-content-<%=detail.getQnANo()%>"
											class="accordion-collapse collapse" data-bs-parent="#faqlist">
											<div class="accordion-body">
												<strong>Q. </strong><%=detail.getQuestionContent()%>
											</div>
											<div class="accordion-body">
		<%
			if (detail.getAnswerContent() == null) {
		%>
													<strong>답변 대기 중입니다.</strong>
		<%
			} else {
		%>
													<strong>A. </strong><%=detail.getAnswerContent()%>
		<%
			}
		%>
											</div>
										</div>
									</div>
<%
		} // for문 끝
%>
								</div>
							</div>
						</div>
<%
	}
%>
					</div> <!-- inquiry-box -->
			</div> <!-- orderList -->
			<div class="row mb-3">
				<div class="col-6 offset-3">
					<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="my-qna.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	if (totalRecords == 0) {
%>
							<li class="page-item <%=pagination.getPageNo() == 1 ? "active" : "" %>"><a class="page-link" href="my-qna.jsp?pageNo=1">1</a></li>
<% 
	} else {
		for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
							<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="my-qna.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
		}
	}
%>					

							<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="my-qna.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div> <!-- offset-md-1 col-9 p-0 -->
	</div> <!-- //mypage -->
</div>	<!-- //container -->
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>