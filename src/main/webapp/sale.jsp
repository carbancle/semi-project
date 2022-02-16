<%@page import="vo.Pagination3"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head> 
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
 	 <link rel="stylesheet" href="resources/css/style.css" />
    <title>SALE | ABC마트 온라인몰</title>
</head>
<style>
.title {font-family:'Montserrat', Noto Sans KR; font-weight:500; color:black; font-size:50px; text-align:center; }
a{text-decoration:none; color:black;}

</style>
<body>
<%
   //include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
   // pageContext에 menu라는 이름으로 설정한s 속성값은 navbar.jsp에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
   pageContext.setAttribute("menu", "SALE");
%>
<%@ include file = "common/navbar.jsp" %> 
<div class="container">
<%
	// 가격 포맷
	DecimalFormat price = new DecimalFormat("###,###");
	// 제품 정보 관련 기능을 제공하는 ProductDao객체를 획득한다.
	ProductDao productDao = ProductDao.getInstance();
	
	// 페이지번호를 요청파라미터에서 획득.
	int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
	
	// select할 속성 요청.
	String brand = request.getParameter("brand");
	String gender = request.getParameter("gender");
	String sort = request.getParameter("sort");
	
	// select한 속성 저장.
	Criteria c = new Criteria();
	if( brand != null && !brand.isEmpty()){
		c.setBrand (brand);
	} 
	if(gender != null && !gender.isEmpty()){
		c.setGender(gender);
	} 
	if(sort != null && !sort.isEmpty()) {
		c.setSort(sort);
	}
	
	// 검색조건에 맞는 게시글의 총 갯수를 조회한다.
	int totalRows = productDao.selectTotalRowsBrandSaleProductsByOption(c);
	
	// 페이징처리에 필요한 정보를 제공하는 pagination 객체를 생성.
	Pagination3 pagination = new Pagination3(pageNo,totalRows);
	// select조건에 맞는 게시글 목록을 조회.
	c.setBegin(pagination.getBeginIndex());
	c.setEnd(pagination.getEndIndex());
	// 상품정보 조회하기.
	List<Product> productList = productDao.selectSaleProductsAllByOption(c);


%>
    

    <div class="title mt-5 mb-5 p-5 ">
    	SALE EVENT
    </div>
   	<nav class="navbar navbar-expand-lg navbar-ligth ">
	<div class="container">
		<form id="search-form" action="sale.jsp" method="get" style="width:100%;">
		<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">		
			<div class="collapse navbar-collapse justify-content-between" id="navbar-1">
				<ul class="navbar-nav" >
					<li class="nav-item" >
						<select name="brand" class=" border-0 text-center mx-3 hover" onchange="searchProducts(1)">
							<option value="">브랜드 전체</option>
							<option value="아디다스" <%="아디다스".equals(brand) ? "selected" : "" %>>아디다스</option>
							<option value="아키클래식" <%="아키클래식".equals(brand) ? "selected" : "" %>>아키클래식</option>
							<option value="리복" <%="리복".equals(brand) ? "selected" : "" %>>리복</option>
						</select>
					</li>	
					<li class="nav-item " >
						<select name="gender" class="border-0 text-center hover" onchange="searchProducts(1)">
							<option value="">남녀공용</option>
							<option value="M" <%="M".equals(gender) ? "selected" : "" %>>남자</option>
							<option value="F" <%="F".equals(gender) ? "selected" : "" %>>여자</option>
						</select>
					</li>	
					<li class="nav-item " >
						<select name="sort" class="border-0  text-center" onchange="searchProducts(1)">
							<option value="new" <%="new".equals(sort) ? "selected" : "" %>>신상품순</option>
							<option value="low" <%="low".equals(sort) ? "selected" : "" %>>낮은가격순</option>
							<option value="high" <%="high".equals(sort) ? "selected" : "" %>>높은가격순</option>
						</select>
					</li>
				</ul>
				<div class=" ">
						총 <%=totalRows %> 개의 상품이 있습니다.
				</div>				
			</div>
		</form>
	</div>
</nav>
<hr>
<div class="row row-cols-4 g-3 mb-5 mx-auto">
<%
 for(Product product : productList) {
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
				<li class="page-item <%=pagination.isExistPrev() ? "" : "disabled"%>">
					<a href="" class="page-link" onclick="moveToPage(event,<%=pagination.getPrev()%>)">이전</a>
				</li>
<%
// Pagination객체는 시작페이지번호와 끝 페이지번호를 제공한다.
// 해당 범위의 페이지를 화면에 표시하다.
for (int num = pagination.getBegin(); num <= pagination.getEnd(); num++) {
%>
				<li class="page-item <%=num == pagination.getPage() ? "active" : ""%>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
				</li>
<%
}
%>
				<li class="page-item <%=pagination.isExistNext() ? "" : "disabled"%>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getNext()%>)">다음</a>
				</li>				
			</ul>
		</div>
	</div>
</div>
<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function searchProducts(page){
		document.getElementById("page-field").value = page;		
		var form = document.getElementById("search-form");
		form.submit();
	}
	function moveToPage(event, page){
		event.preventDefault();	// a태그에서 onclick이벤트가 발생하면 href에 정의된 주소로 이동하는 기본동작이 일어나지 않게 함.
		searchProducts(page);
	}
</script>
</body>
</html>