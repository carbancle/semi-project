<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.CartDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="/semi-project/resources/css/style.css" />
    <title>주문완료</title>
    <style>
    	.order-list-box{padding:0; border:none;}
    	.order-table>:not(:first-child){border:none;}
    	.order-table tr th, .order-table tr td{vertical-align:middle; border:none; padding:12px 18px;}
    	.order-table tr th{border-top:2px solid #000; border-bottom:1px solid #ddd;}
    	.order-table tr td{border-bottom:1px solid #d5d5d5;}
    	.order-list .btn-box{margin-top:20px;}
    </style>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
<%
	//필요한 정보 조회
	// 1. 장바구니 내에서 넘어온 장바구니 번호
	// 3. 장바구니 번호로 조회되는 정보만 출력
	
	// 폼에서 전달된 장바구니 번호를 배열을 통해서 가져온다.
	String values[] = request.getParameterValues("no");
	
	CartDao cartDao = CartDao.getInstance();
	
	DecimalFormat price = new DecimalFormat("###,###");
%>
	<div class="row mt-5">
		<div class="col p-0 page-title">
			<h1>주문완료</h1>
		</div>
	</div>
	<div class="text-center">
		<img src="../resources/images/order.JPG">
		<h2 style="font-weight: bold;">주문완료 클릭 시 주문이 완료됩니다.</h2>
	</div>
	<div class="order-list">
		<p>주문정보</p>
<%
	int no = 0;
	for (int i = 0; i < values.length; i ++){
		no = Integer.parseInt(values[i]);
		
		CartDetailDto cart = cartDao.selectCartByNo(no);
%>
	<form action="order-cart-act.jsp">
	<input type="hidden" name="no" value="<%=cart.getNo() %>"/>
			<div class="row order-list-box">
				<div class="col p-0">
					<table class="table order-table">
						<colgroup>
							<col width="100px" />
							<col />
							<col width="200px" />
							<col width="200px" />
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">
									<span>ABC_MART 상품</span> / <span>무료배송</span>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<img class="order-img" src="../resources/images/products/<%=cart.getProductImg() %>">
								</td>
								<td>
									<div>
										<span><%=cart.getProductBrand() %></span>
									</div>
									<div>
										<span><%=cart.getProductName() %></span>
									</div>
									<div>
										<span><%=cart.getProductSize() %> / <%=cart.getAmount() %> 개</span>
									</div>
								</td>
								<td class="text-center">
									<div class="text-center">적립포인트</div>
									<div class="text-center">
										<%
											if (cart.getProductDisprice() > 0) {
										%>
											<%=price.format(cart.getProductDisprice()*cart.getAmount()*0.01) %><i>P</i>
										<%
											} else {
										%>
											<%=price.format(cart.getProductPrice()*cart.getAmount()*0.01) %><i>P</i>
										<%
											}
										%>
									</div>
								</td>
								<td class="text-end">
	<%
		if (cart.getProductDisprice() > 0) {
	%>
											<span style="text-decoration:line-through; font-size:14px; color:#666;"><%=price.format(cart.getProductPrice()*cart.getAmount()) %> 원</span><br>
											<span style="color: red; font-weight: bold; font-size: 16px;"><%=price.format(cart.getProductDisprice()*cart.getAmount()) %>원</span>
	<%
		} else {
	%>
										
										<span><%=price.format(cart.getProductPrice()*cart.getAmount()) %> 원</span>	
	<%
		}
	%>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>		
<%
	}
%>
			<div class="btn-box text-center">
				<button type="submit" class="btn btn-lg btn-dark">주문완료</button>
			</div>
		</form>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>