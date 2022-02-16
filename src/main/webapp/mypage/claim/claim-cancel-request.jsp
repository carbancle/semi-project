<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.OrderDao"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="vo.Order"%>
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
    <title>주문취소 신청</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">    
<%
	if (loginUserInfo == null) {
		response.sendRedirect("../../loginform.jsp?user=undefined");	
	}

   	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	int memberNo = loginUserInfo.getNo();
	MemberDao memberDao = MemberDao.getInstance();
 	Member member = memberDao.selectMemberByNo(memberNo);
 		
 	DecimalFormat price = new DecimalFormat("###,###");
 	OrderDao orderDao = OrderDao.getInstance();
 	Order order = orderDao.selectOrderByOrderNo(orderNo);
%>
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="/semi-project/main.jsp" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">쇼핑내역</li>
				<li class="crumb">취소 신청</li>
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
				<li class=""><a href="claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="cancel-main.jsp" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
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
						<p><%=member.getName() %> 님은 <strong>통합멤버십 회원</strong>입니다.</p>
						<span class="member-info">MEMBERSHIP <span class="member-number"><%=member.getNo() %></span></span> 
						<span class="member-info">멤버십 회원 가입일 <span class="member-number"><%=member.getRegisteredDate() %></span></span> 
					</div>
					<div class="col-4 p-0 right-box">
						<span class="text-center"><i class="icon-point"></i>포인트</span>
						<span class="point"><%=member.getPct() %><span class="unit">p</span></span>
					</div>
				</div>
			</div>
			<div class="order-list">
				<p>취소 신청</p>
				<div class="row border p-3">
					<div class="col mt-1 cancel-font">
						<span>주문번호</span>
						<span><%=order.getNo() %></span>
						<input type="hidden" name="orderNo"/>
					</div>
					<div class="col mt-1 text-end cancel-font">
						<span>주문일시</span>
						<span><%=order.getOrderDate() %></span>
					</div>
				</div>
			</div>
			<div class="cancel-list">
				<p>주문취소</p>
				<div class="cancel-list-box">
					<div class="row">
						<div class="col-2 mt-2">
							<span style="margin-left:5px;">ABC_MART 상품</span>
						</div>
					</div>
					<form id="list-form" action="cancel.jsp">
						<input type="hidden" name="orderNo" value="<%=order.getNo()%>"/>
						<table class="table mt-3" id="product-list">
							<colgroup>
								<col>
								<col width="20%">
							</colgroup>
							<tbody>
<%
	List<OrderDetailDto> orderDetails = orderDao.selectAllOrderDetailsByOrderNo(orderNo);
	for (OrderDetailDto orderDetail : orderDetails) {
%>
								<tr>
									<td>
										<div class="row">
											<div class="col">
												<img class="order-img me-2" src="../../resources/images/products/<%=orderDetail.getPhoto()%>">
												<div>
													<div>
														<span><%=orderDetail.getBrand() %></span>
													</div>
													<div>
														<span><%=orderDetail.getProductName() %></span>
													</div>
													<div>
														<span><%=orderDetail.getSize() %> / <%=orderDetail.getAmount() %>개</span>
														<input type="hidden" name="stockNo" value="<%=orderDetail.getProductDetailNo() %>"/>
													</div>
												</div>
											</div>
										</div>
									</td>
<%
	if (orderDetail.getDisPrice() > 0) {
%>									<td>
									<div class="col">
										<div class="text-end me-2">
											<span  style="text-decoration:line-through;"><%=price.format(orderDetail.getPrice()) %>원</span>
										</div>
										<div class="text-end me-2">
											<span style="color: red; font-weight: bold; font-size: 17px;"><%=orderDetail.getDisPrice() %>원</span>
										</div>
									</div>
									</td>
<%
	} else {
%>
									<td>
										<div class="col text-end me-2">
											<span><%=price.format(orderDetail.getPrice()) %>원</span>
											<input type="hidden" name="price" value="<%=orderDetail.getPrice()%>"/>
										</div>
									</td>
								</tr>
<%
		}
	}

%>
							</tbody>
						</table>
						<div class="order-list">
						<p>취소 사유</p>
							<div class="order-list-box p-3 ">
								<table>
									<tbody>
										<tr>
											<th>취소 사유</th>
											<td>
												<select id="select-box" class="m-4 cancel-box" name="cancelReason">
													<option disabled selected value="">사유를 선택해 주세요</option>
													<option value="변심">변심</option>
													<option value="중복주문">중복주문</option>
													<option value="배송지연">배송지연</option>
													<option value="가격변동">가격변동</option>
													<option value="쿠폰미사용">쿠폰미사용</option>
													<option value="재주문">재주문</option>
													<option value="기타">기타</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</form>
				</div>

				<div class="order-list">
					<div class="order-list-box p-3">
						<div class="row">
							<div class="col-2">
								<span style="margin-left:5px;">상품금액</span>
							</div>
							<div class="col text-end">
								<span style="margin-right:5px; color:red; font-weight: bold;"><%=price.format(order.getTotalPrice()) %>원</span>
							</div>
							<div class="col-2">
								<span style="margin-left:5px;">배송비</span>
							</div>
							<div class="col text-end">
								<span style="margin-right:5px; color:red; font-weight: bold;">0원</span>
							</div>
							<div class="col-2">
								<span style="margin-left:5px;">환불 예상 금액</span>
							</div>
							<div class="col text-end">
								<span style="margin-right:5px; color:red; font-weight: bold;"><%=price.format(order.getTotalPrice()) %>원</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="order-list">
				<p>주문자 정보</p>
					<div class="order-list-box p-3">
						<div class="row mb-3 mt-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">이름</span>
							</div>
							<div class="col">
								<span><%=member.getName() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">휴대폰 번호</span>
							</div>
							<div class="col">
								<span><%=member.getTel() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">이메일 주소</span>
							</div>
							<div class="col">
								<span><%=member.getEmail() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">배송 주소</span>
							</div>
							<div class="col">
								<span><%=member.getAddress() %></span>
							</div>
						</div>
					</div>
				</div>
				<div class="btn-box text-center">
					<button type="button" class="btn btn-lg btn-dark" onclick="cancelOrder();" >주문취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function cancelOrder() {
		var form = document.getElementById("list-form");
				
		var selected = document.getElementById("select-box").value;
		if (selected == "") {
			alert('취소 사유를 선택해 주세요.');
			return;
		}
		
		form.submit();
	}
</script>
</body>
</html>