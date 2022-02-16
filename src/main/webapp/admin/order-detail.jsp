<%@page import="vo.QnA"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="dto.ReviewDetailDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
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
	 <link rel="stylesheet" href="../resources/css/style.css" />
	 <title>관리자페이지</title>
</head>

<body>
<%@ include file="admin-common.jsp" %>
<div class="container">   
	
<%

	int orderNo = Integer.parseInt(request.getParameter("no"));

	OrderDao orderDao = OrderDao.getInstance();
	Order order = orderDao.selectOrderByOrderNo(orderNo);
	
	int memberNo = order.getMemberNo();
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(memberNo);
	
	DecimalFormat price = new DecimalFormat("###,###");
	

	DecimalFormat priceDF = new DecimalFormat("###,###");
	
	List<OrderDetailDto> orderDetails = orderDao.selectAllOrderDetailsByOrderNo(orderNo);
%>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
	
	<div class="row mypage">
		<!-- aside 시작 -->
			<div class="col-2 p-0 aside">
			<span class="aside-title">관리자 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="main.jsp" class="nav-link p-0">관리자페이지 메인</a></li>
			</ul>
			<span class="aside-title d-block mt-4">회원 관리</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="member-list.jsp" class="nav-link p-0">회원목록 조회</a></li>
				<li class=""><a href="member-left-list.jsp" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
			</ul>
			<span class="aside-title d-block mt-4">상품 관리</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="product-list.jsp" class="nav-link p-0">전체 상품 조회</a></li>
				<li class=""><a href="registerform.jsp" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
			</ul>
			<span class="aside-title d-block mt-4">CS</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
			</ul>
		</div>	
		
		<div class="col-9">
			<h4>주문 상세 정보</h4>
			<span style="margin-top :10px; font-weight:bold;">주문자 정보</span>
			<table class="table table mb-5 table-sm" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
				<colgroup>
				<col width="12%">
				<col width="38%">
				<col width="12%">
				<col width="38%">
				</colgroup>
					<tbody>
						<tr>
							<th>회원번호</th>
							<td><%=member.getNo() %></td>
							<th>이름</th>
							<td><%=member.getName() %></td>
						</tr>
						<tr>
							<th>ID</th>
							<td><%=member.getId() %></td>
							<th>연락처</th>
							<td><%=member.getTel() %></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><%=member.getEmail() %></td>
							<th>주소</th>
							<td><%=member.getAddress() %></td>
						</tr>
						<tr>
							<th>포인트</th>
							<td><%=member.getPct() %></td>
							<th>가입일</th>
							<td><%=member.getRegisteredDate() %></td>
						</tr>
					</tbody>				
				</table>
				
			<div>
			<span style="margin-top :10px; font-weight:bold;">주문 정보</span>
			<table class="table table mb-5 table-sm" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
				<colgroup>
				<col width="12%">
				<col width="38%">
				<col width="12%">
				<col width="38%">
				</colgroup>
					<tbody>
						<tr>
							<th>주문일</th>
							<td><%=order.getOrderDate() %></td>
							<th>주문 상태</th>
							<td><%=order.getStatus() %></td>
						</tr>
					</tbody>				
				</table>	
			</div>	
				
				
			<div>
			<span style="margin-top :10px; font-weight:bold;">상품 상세 정보</span>
			<table class="table align-middle table-bordered" style="border-top: 2px solid #000; text-align:center;">
				<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				</colgroup>
					<tbody>
						<tr>
							<th>상품번호</th>
							<th>상품 이미지</th>
							<th>상품 이름</th>
							<th>브랜드</th>
							<th>판매가</th>
							<th>할인가격</th>
							<th>상품수량</th>
						</tr>
<%
	for (OrderDetailDto orderDetail : orderDetails) {
%>						
						<tr>
							<td><%=orderDetail.getProductNo() %></td>
							<td><img class="order-img me-2" src="/semi-project/resources/images/products/<%=orderDetail.getPhoto()%>" width=60px; /></td>
							<td><%=orderDetail.getProductName() %></td>
							<td><%=orderDetail.getBrand() %></td>
							<td><%=price.format(orderDetail.getPrice()) %>원</td>
							<%
if (orderDetail.getDisPrice() == 0) {
%> 				
				
				<td>  </td>
<% 
	} else {
%>	
				<td><%=priceDF.format(orderDetail.getDisPrice()) %>원</td>
<% 
	}
%>	
							
							<td><%=orderDetail.getAmount() %></td>
						</tr>
<%
	}
%>
						<tr>
							<td colspan=7>총액 : <span style="margin-right:5px; color:red; font-weight: 
							bold;"><%=price.format(order.getTotalPrice()) %>원</span>
							</td>
						</tr>

					</tbody>
				</table>	

			</div>
		</div>
	</div>	
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"></script>
</body>
</html>