<%@page import="vo.Pagination3"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.Pagination2"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="resources/css/style.css" />
<link rel="stylesheet" href="resources/css/style2.css" />
<link rel="stylesheet" href="resources/css/default.css" />
<title></title>
</head>
<body data-spy='scroll' data-target='.navbar' data-offset='50'>
<style>
	.nav-link {color: black;}
	.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {font-weight: bold;}
</style>
<%@ include file="common/navbar.jsp"%>
<div class="container">
<% 
	ProductDao productDao = ProductDao.getInstance();
	
	int pageNo = NumberUtils.toInt(request.getParameter("pno"), 1);
	String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");
	
	// name, brand명으로 검색된 개수 조회
int nameCount = 0;
if (keyword != "") {	
	nameCount = productDao.selectNameCount(keyword);
}	

	int brandCount = 0;
if (keyword != "") {	
	brandCount = productDao.selectBrandCount(keyword);
}	
	
	// pagination 생성
	Pagination3 pagination1 = new Pagination3(pageNo, nameCount);
	Pagination3 pagination2 = new Pagination3(pageNo, brandCount);
	
	// name, brand명으로 검색된 리스트 조회
	List<Product> productListByName = productDao.selectProductByName(pagination1.getBeginIndex(), pagination1.getEndIndex(), keyword);
	List<Product> productListByBrand = productDao.selectProductByBrand(pagination2.getBeginIndex(), pagination2.getEndIndex(), keyword);
	
	DecimalFormat price = new DecimalFormat("###,###");
%>
	<div class= mt-5>
		<ul class="nav nav-tabs mb-3" role="tablist">
			<li class="nav-item"><a class="nav-link active"	aria-current="page" href="#brand" data-bs-toggle="tab">BRAND(<%=brandCount%>)</a></li>
			<li class="nav-item"><a class="nav-link" href="#name" data-bs-toggle="tab">PRODUCTS(<%=nameCount%>)</a></li>
		</ul>
	</div>
	<div class="tab-content mt-4">
		<div id="brand" class="container tab-pane active">
			<p class=" mb-2" style="font-weight: bold; font-color:gray;"><%=keyword %> 브랜드상품</p>
			<div class="inquiry-box">
<%	
	if (keyword == "" || brandCount == 0) {
%>
<div>
	<p>"<%=keyword %>"로 검색된 결과가 존재하지 않습니다.</p>
</div>
<%	
	} else {
%>
				<div class="row row-cols-4 g-3 mt-5  mb-5 mx-auto">
	<%
		for(Product product : productListByBrand) {
	%>
					<div class="col-3">
				    	<div class="card h-100 border-white rounded-0">
					 		<a href="detail.jsp?no=<%=product.getNo() %>">
				      				<div class="detail-img-box">
				      					<img src="resources/images/products/<%=product.getPhoto() %>" class="card-img-top" alt="...">
				      				</div>
							      	<div class="card-body">
							        	<h6 class="card-title"><strong><%=product.getBrand() %></strong></h6>
							        	<p class="card-text"><%=product.getName() %></p>
		<%
			if (product.getDisPrice() > 0) {
		%>
							      	  <div class="d-flex justify-content-between">
								        <span class="col card-text p-1 p"><%=price.format(product.getPrice()) %> 원</span>
								        <span class="col card-text  p-1 dp"><%=price.format(product.getDisPrice())%> 원</span>
							      	  </div>
		<%
			} else {
		%>
									  <div class="text-end">
								        	<span class="col card-text  p-1 dp"><%=price.format(product.getPrice())%> 원</span>
							      	  </div>
		<%
			}
		%>
							      </div>
							</a>
				   		 </div>
					  </div>
	<%
		 }
	%>
				</div>
				<div class="row mb-3">
					<div class="col">
						<ul class="pagination justify-content-center">
							<li class="page-item <%=pagination2.isExistPrev() ? "" : "disabled"%>">
								<a href="" class="page-link" onclick="moveToPage(event, <%=pagination2.getPrev()%>)" >이전</a>
							</li>
		<%
			// Pagination객체는 시작페이지번호와 끝 페이지번호를 제공한다.
			// 해당 범위의 페이지를 화면에 표시하다.
			for (int num = pagination2.getBegin(); num <= pagination2.getEnd(); num++) {
		%>
							<li class="page-item <%=num == pagination2.getPage() ? "active" : ""%>">
								<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
							</li>
		<%
			}
		%>
							<li class="page-item <%=pagination2.isExistNext() ? "" : "disabled"%>">
								<a href="" class="page-link" onclick="moveToPage(event, <%=pagination2.getNext()%>)">다음</a>
							</li>
						</ul>
					</div>
				</div>
<%
	}
%>
			</div>
		</div> <!--BRAND 끝 -->
		<div id="name" class="container tab-pane fade">
			<p class=" mb-2" style="font-weight: bold; font-color:gray;"><%=keyword %> 상품</p>
			<div class="inquiry-box">
<%	
	if (keyword == "" || nameCount == 0) {
%>
<div>
	<p>"<%=keyword %>"로 검색된 결과가 존재하지 않습니다.</p>
</div>
<%	
	} else {
%>
					<div class="row row-cols-4 g-3 mt-5  mb-5 mx-auto">
						<%
						 	for(Product product : productListByName) {
						%>
						<div class="col-3">
					    	<div class="card h-100 border-white rounded-0">
						 		<a href="detail.jsp?no=<%=product.getNo() %>">
					      				<div class="detail-img-box">	
					      					<img src="resources/images/products/<%=product.getPhoto() %>" class="card-img-top" alt="...">
					      				</div>
								      	<div class="card-body">
								        	<h6 class="card-title"><strong><%=product.getBrand() %></strong></h6>
								        	<p class="card-text"><%=product.getName() %></p>
								<%
									if (product.getDisPrice() > 0) {
								%>
								      	  <div class="d-flex justify-content-between">
									        <span class="col card-text p-1 p"><%=price.format(product.getPrice()) %> 원</span>
									        <span class="col card-text  p-1 dp"><%=price.format(product.getDisPrice())%> 원</span>
								      	  </div>
								<%
									} else {
								%>
										  <div class="text-end">
									        	<span class="col card-text  p-1 dp"><%=price.format(product.getPrice())%> 원</span>
								      	  </div>
								<%
									}
								%>
								      </div>
								</a>
					   		 </div>
						  </div>
						<%
							 }
						%>
					</div>
					<div class="row mb-3">
						<div class="col">
							<ul class="pagination justify-content-center">
								<li class="page-item <%=pagination1.isExistPrev() ? "" : "disabled"%>">
									<a href="" class="page-link" onclick="moveToPage(event, <%=pagination1.getPrev()%>)" >이전</a>
								</li>
			<%
				// Pagination객체는 시작페이지번호와 끝 페이지번호를 제공한다.
				// 해당 범위의 페이지를 화면에 표시하다.
				for (int num = pagination1.getBegin(); num <= pagination1.getEnd(); num++) {
			%>
								<li class="page-item <%=num == pagination1.getPage() ? "active" : ""%>">
									<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
								</li>
			<%
				}
			%>
								<li class="page-item <%=pagination1.isExistNext() ? "" : "disabled"%>">
									<a href="" class="page-link" onclick="moveToPage(event, <%=pagination1.getNext()%>)">다음</a>
								</li>
							</ul>
						</div>
					</div>
		<%
			} // PRODUCT 끝
		%>
			</div>
		</div>
	</div>
</div>	
<%@ include file="common/footer.jsp"%>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	//페이지번호를 클릭했을 때 실행되는 함수
	function moveToPage(event, page) {
		event.preventDefault();	// a태그에서 onclick이벤트가 발생하면 href에 정의된 주소로 이동하는 기본동작이 일어나지 않게 함.
		searchProducts(page);
	}
</script>	
</body>
</html>


    