<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.StockDao"%>
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
	int productNo = Integer.parseInt(request.getParameter("no"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int size = Integer.parseInt(request.getParameter("size"));
	
	DecimalFormat price = new DecimalFormat("###,###");
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.selectProductbyNo(productNo);
%>
	<div class="row mt-5">
		<div class="col p-0 page-title">
			<h1>주문완료</h1>
		</div>
	</div>
	<div class="text-center">
		<img src="../../resources/images/order.JPG">
		<h2 style="font-weight: bold;">주문완료 클릭 시 주문이 완료됩니다.</h2>
	</div>
	<form action="order-act.jsp">
	<input type="hidden" name="productNo" value="<%=productNo%>"/>
	<input type="hidden" name="amount" value="<%=amount %>"/>
	<input type="hidden" name="size" value="<%=size%>"/>
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
						<img class="order-img me-2" src="../../resources/images/products/<%=product.getPhoto()%>">
						<div>
							<div>
								<span><%=product.getBrand() %></span>
							</div>
							<div>
								<span><%=product.getName() %></span>
							</div>
							<div>
								<span><%=size %> / <%=amount %> 개</span>
							</div>
						</div>
					</div>
<%
	if (product.getDisPrice() > 0) {
%>
					<div class="col mt-3">
						<div class="text-end">
							<span  style="text-decoration:line-through;"><%=price.format(product.getPrice()) %>원</span>
						</div>
						<div class="text-end">
							<span style="color: red; font-weight: bold; font-size: 17px;"><%=price.format(product.getDisPrice()*amount)%>원</span>
						</div>
					</div>
<%
	} else {
%>
					<div class="col mt-4 text-end">
						<span><%=price.format(product.getPrice()*amount) %>원</span>
					</div>
<%
	}
%>
				</div>
			</div>
			<div class="btn-box text-center">
				<button type="submit" class="btn btn-lg btn-dark">주문완료</button>
			</div>
		</div>
	</form>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>