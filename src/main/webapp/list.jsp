<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
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
<%
//카테고리 요청
String category = request.getParameter("category");
%>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
 	 <link rel="stylesheet" href="resources/css/style.css" />

    <title><%=category %> | ABC마트 온라인몰</title>

</head>
<style>
.title {font-family:'Montserrat', Noto Sans KR; font-weight:500; color:black; font-size:50px; text-align:center; }
a{text-decoration:none; color:black;}


</style>
<body>
<%
//include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
   // pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
   if ("SNEAKERS".equals(request.getParameter("category"))) {
      pageContext.setAttribute("menu", "SNEAKERS");
   }
   if ("SPORTS".equals(request.getParameter("category"))) {
      pageContext.setAttribute("menu", "SPORTS");
   }
   if ("SANDALS".equals(request.getParameter("category"))) {
      pageContext.setAttribute("menu", "SANDALS");
   }
   if ("LOAFERS".equals(request.getParameter("category"))) {
      pageContext.setAttribute("menu", "LOAFERS");
   }
   
%>
<%@ include file = "common/navbar.jsp" %>
<div class="container">
<% 
	// 가격표 천단위로 콤마 표시하기
	DecimalFormat price = new DecimalFormat("###,###");
	

	// 제품 정보 관련 기능을 제공하는 ProductDao객체를 획득한다.
	ProductDao productDao = ProductDao.getInstance();

	// select할 속성 요청.
	String brand = request.getParameter("brand");
	String gender = request.getParameter("gender");
	String sort = request.getParameter("sort");
	
	Criteria c = new Criteria();
	c.setCategory(category);
	if( brand != null && !brand.isEmpty()){
		c.setBrand (brand);
	} 
	if(gender != null && !gender.isEmpty()){
		c.setGender(gender); 
	} 
	if(sort != null && !sort.isEmpty()) {
		c.setSort(sort);
	}
	
	// 총 상품 수량
	int totalRows = productDao.countTotalCategoryProductsByOption(c);
	// 옵션별 상품조회
	List<Product> products = productDao.selectProductsByOption(c);
	


	
	
	
	// 페이징 처리 필요한 값을 계산하는 Paginatition객체를 생성한다.
//	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
//	List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
%>
    
	<div class="mt-2 mb-5 p-2 " >
			<a href="main.jsp"><strong>HOME</strong></a>
			<img alt="" src="resources/images/home.png" style="margin:5px; width:20px;">
			<select class= "border-0 text-center" onchange= "if(this.value) location.href=(this.value);" >
				<option value="" style="background:lightgray;border:0;padding:15px" ><%=category %></option>
				<option value="list.jsp?category=SNEAKERS">SNEAKERS</option>
				<option value="list.jsp?category=SPORTS">SPORTS</option>
				<option value="list.jsp?category=SANDALS">SANDALS</option>
				<option value="list.jsp?category=LOAFERS">LOAFERS</option>
			</select>
	</div>
  
    <div class="title mb-5 p-3 ">
    	<%=category%>
    </div>
  
   	<nav class="navbar navbar-expand-lg navbar-ligth ">
	<div class="container">
		<form id="search-form" action="list.jsp" method="get" style="width:100%;">
			<input type="hidden" name="category" value="<%=category %>">
			<div class="collapse navbar-collapse justify-content-between " id="navbar-1">
				<ul class="navbar-nav" >
					<li class="nav-item" >
						<select name="brand" class=" border-0 text-center mx-3 hover" onchange="searchProducts()">
							<option value="">브랜드 전체</option>
							<option value="아디다스" <%="아디다스".equals(brand) ? "selected" : "" %>>아디다스</option>
							<option value="아키클래식" <%="아키클래식".equals(brand) ? "selected" : "" %>>아키클래식</option>
							<option value="리복" <%="리복".equals(brand) ? "selected" : "" %>>리복</option>
						</select>
					</li>	
					<li class="nav-item " >
						<select name="gender" class="border-0 text-center hover" onchange="searchProducts()">
							<option value="">남녀공용</option>
							<option value="M" <%="M".equals(gender) ? "selected" : "" %>>남자</option>
							<option value="F" <%="F".equals(gender) ? "selected" : "" %>>여자</option>
						</select>
					</li>	
					<li class="nav-item " >
						<select name="sort" class="border-0  text-center" onchange="searchProducts()">
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
 for(Product product : products) {
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
</div>
<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function searchProducts(){
		var form = document.getElementById("search-form");
		form.submit();
	}
</script>

</body>
</html>