<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.StockDao"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="dao.OrderDao"%>
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
    <title>주문완료</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
<%		
	OrderDao orderDao = OrderDao.getInstance();
	StockDao stockDao = StockDao.getInstance();
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int size = Integer.parseInt(request.getParameter("size"));
	int stockNo = stockDao.selectStockNoByProductNoAndSize(productNo, size);
	DecimalFormat price = new DecimalFormat("###,###");
	OrderDetailDto orderDetail = orderDao.selectOrderDetailByOrderNoAndStockNo(orderNo, stockNo);
%>
	<div class="row mt-5">
		<div class="col p-0 page-title">
			<h1>주문완료</h1>
		</div>
	</div>
	<div class="text-center">
		<img src="../../resources/images/order.JPG">
		<h2 style="font-weight: bold;">주문이 정상적으로 접수되었습니다.</h2>
		<span style="font-weight: bold;">주문번호 
			<span style="color:red; font-weight: bold;"><%=orderDetail.getOrderNo() %></span>
		</span>
	</div>
	<div class="order-list">
		<p>주문정보</p>
		<div class="order-list-box">
			<div class="row">
				<div class="col-2 mt-2">
					<span style="margin-left:5px;">ABC_MART 상품</span>
				</div>
				<div class="col text-end mt-2">
					<span style="margin-right:5px;">무료배송</span>
				</div>
			</div>      
			<hr>
			<div class="row p-2">
				<div class="col-6">
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
						</div>
					</div>
				</div>
<%
	if (orderDetail.getDisPrice() > 0) {
%>
				<div class="col mt-3">
					<div class="text-end">
						<span  style="text-decoration:line-through;"><%=price.format(orderDetail.getPrice()) %>원</span>
					</div>
					<div class="text-end">
						<span style="color: red; font-weight: bold; font-size: 17px;"><%=price.format(orderDetail.getDisPrice()) %>원</span>
					</div>
				</div>
<%
	} else {
%>
				<div class="col mt-4 text-end">
					<span><%=price.format(orderDetail.getPrice()) %>원</span>
				</div>
<%
	}
%>
			</div>
		</div>
		<div class="order-list">
			<div class="order-list-box p-3">
				<div class="row">
					<div class="col-2">
						<span style="margin-left:5px;">주문금액</span>
					</div>
					<div class="col text-end">
						<span style="margin-right:5px; color:red; font-weight: bold;"><%=price.format(orderDetail.getPrice() * orderDetail.getAmount()) %>원</span>
					</div>
					<div class="col-2">
						<span style="margin-left:5px;">총 할인금액</span>
					</div>
<%
	if (orderDetail.getDisPrice() == 0) {
%>
					<div class="col text-end">
						<span style="margin-right:5px; color:red; font-weight: bold;">0원</span>
					</div>
<%
	} else {
%>
					<div class="col text-end">
						<span style="margin-right:5px; color:red; font-weight: bold;"><%=price.format(orderDetail.getPrice() * orderDetail.getAmount() - (orderDetail.getDisPrice() * orderDetail.getAmount())) %>원</span>
					</div>
<%
	}
%>
					<div class="col-2 text">
						<span style="margin-left:5px;">결제금액</span>
					</div>
					<div class="col text-end">
						<span style="margin-right:5px; color:red; font-weight: bold;"><%=price.format(orderDetail.getTotalPrice()) %>원</span>
					</div>
				</div>
			</div>
		</div>
		<div class="btn-box text-center">
			<button type="submit" class="btn btn-lg btn-dark"><a style="color: white; text-decoration: none;" href="../../main.jsp">메인으로 가기</a></button>
		</div>
		<div class="order-box p-4 mt-5">
				<ul>
					<li>자세한 구매내역은 ‘마이페이지 > 쇼핑내역 > 주문/배송 현황 조회’ 에서 확인할 수 있습니다.</li>
					<li>매장에서 발송되는 경우 온라인 물류센터 상품보다 평균 배송기간이 2~3일 정도 더 소요될 수 있습니다.</li>
					<li>2개 이상의 상품 주문 시 재고 여부에 따라 분리 발송될 수 있습니다.</li>
					<li>결제수단 변경을 원하실 경우 고객센터로 연락 주시기 바랍니다.</li>
				</ul>
			</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>