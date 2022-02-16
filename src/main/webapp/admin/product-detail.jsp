<%@page import="vo.Stock"%>
<%@page import="java.util.List"%>
<%@page import="dao.StockDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../resources/css/style.css" />
    <title>ABC마트 관리자페이지</title>
<style>
	.img-box-admin{margin-bottom:20px;}
	.img-box-admin tr td{vertical-align:middle; text-align:center; max-width:50%;}
	.table-detail{margin-bottom:20px;}
	.table-detail tr th, .table tr td{vertical-align:middle; height:35px; border-right:1px solid #dee2e6; font-size:13px;}
	.table tr td{word-break:keep-all;}
	.table-detail tr th{text-align:center;}
	.table-stock tr th, .table-stock tr td{height:35px; border-right:1px solid #dee2e6; font-size:13px; text-align:center;}
	table tr th:first-child, table tr td:first-child{border-left:none;}
	table tr th:last-child, table tr td:last-child{border-right:none;}
</style>	    
</head>
<body>
<%@ include file="admin-common.jsp" %>


<%
int no = Integer.parseInt(request.getParameter("no"));

ProductDao productDao= ProductDao.getInstance();
Product product = productDao.selectProductbyNo(no);
StockDao stockDao = StockDao.getInstance();
List<Stock> stockList = stockDao.selectStocksbyProductNo(no);

%>
<div class="container">    
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
		
	
		 
<div class="product_admin_detail mt-5 mb-5 col-9">
		<div class="row img-box-admin">
			<div class="col">
				<table>
					<colgroup>
						<col width="40%" />
						<col width="60%" />
					</colgroup>
					<tr>
						<td>
							<h1>상품 이미지</h1>
						</td>
						<td>
							<img src="/semi-project/resources/images/products/<%=product.getPhoto() %>" width=100% />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
 			<div class="col">
				<table class="table table-detail" style="border-top: 2px solid #000">
					<tbody>
						<tr>
							<th>상품 이름</th>
							<th>브랜드</th>
							<th>판매가</th>
							<th>할인가격</th>
							<th>상품번호</th>
							<th>카테고리</th>
						</tr>
						<tr>
							<td class="text-center"><%=product.getName() %></td>
							<td class="text-center"><%=product.getBrand() %></td>
							<td class="price text-center"><%=product.getPrice() %></td>
							<td class="text-center"><%=product.getDisPrice() %></td>
							<td class="text-center"><%=product.getNo() %></td>
							<td class="text-center"><%=product.getCategory() %></td>
						</tr>
					</tbody>
				</table>	
				<table class="table table-stock" style="border-top: 2px solid #000">
				
					<tbody>
					<tr>
		<%
			for (Stock stock : stockList) {
		%>
						<th><%=stock.getSize() %>재고량</th>
		<%
			}
		%>			
					</tr>
					<tr>
		<%
			for (Stock stock : stockList) {
		%>
						<td><%=stock.getStock() %></td>
		<%
			}
		%>
					</tr>
					<tbody>
				</table>
			<div class="btn-box text-center">
					<button type="button" onclick="location.href ='modifyform.jsp?no=<%=no %>'" class="btn btn-lg btn-dark">수정</button>
				</div>
			</div>
		
		</div>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>