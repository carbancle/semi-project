<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
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
    <title>주문/배송현황 조회</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">    
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int size  = Integer.parseInt(request.getParameter("size"));
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(loginUserInfo.getNo());
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.selectProductbyNo(productNo); 
			
	
%> 
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="/semi-project/main.jsp" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">쇼핑내역</li>
				<li class="crumb">주문/배송현황 조회</li>
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
				<li class=""><a href="" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="../mypage/claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="../info/leaveform.jsp" class="nav-link p-0">회원 탈퇴</a></li>
			</ul>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
			</ul>
		</div>
		<!-- //aside 끝 -->
		<div class="offset-md-1 col-9 p-0">
			<div class="order-list">
				<p>구매상품</p>
				<div class="order-list-box">
					<div class="row">
						<div class="col-2 mt-2">
							<span style="margin-left:5px;">ABC_MART 상품</span>
						</div>
					</div>
					<hr>
						<div class="row p-2">
							<div class="col-4">
								<img class="order-img me-3 " src="../../resources/images/products/<%=product.getPhoto()%>">
								<div>
									<div class="mt-2">
										<span><strong><%=product.getBrand() %></strong></span>
									</div>
									<div>
										<span><%=product.getName() %></span>
									</div>
								</div>
							</div>
						
							<div class="col-5 mt-4 text-center mt-1">
								<span><%=product.getCategory() %></span>
							</div>
<%
	if (product.getDisPrice() > 0) {
	%>						<div class="col-3 mt-2 ">
								<div class="text-end">
									<span  style="text-decoration:line-through;"><%=product.getPrice() %>원</span>
								</div>
								<div class="text-end">
									<span style="color: red; font-weight: bold; font-size: 17px;"><%=product.getDisPrice() %>원</span>
								</div>
							</div>
<%
	} else {
%>
							<div class="col mt-4 text-end">
								<span><%=product.getPrice() %>원</span>
							</div>
<%		
	}
%>
						</div>
					</div>
					<div class="order-list">
					<p>리뷰작성</p>
						<div class="order-list-box p-3">
						 <form method="get" action="insert-review.jsp">
						 	<input type="hidden" name="orderNo" value="<%=orderNo%>">
						 	<input type="hidden" name="productNo" value="<%=productNo%>">
						 	<input type="hidden" name="size" value="<%=size%>">
							<div class="row mb-3 mt-2 order-font">
								<div class="col">
									<span style="font-weight: bold;">내용</span>
								</div>
								<div class="row mt-3">
				    				<textarea class=" form-control" name="content" id="content" rows="3" maxlength="150"></textarea>
									<div class="col mt-3 text-end">
										<button type="submit"class="btn btn-dark btn-sm">리뷰등록</button>
									</div>
								</div>
							 </div>
						  </form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

    