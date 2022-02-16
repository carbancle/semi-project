        
<%@page import="java.text.DecimalFormat"%>
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
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
   <link rel="stylesheet" href="resources/css/style.css" />
   <title>ABC마트 온라인몰</title>
</head>
<style>
h1{font-family:'Montserrat', Noto Sans KR; font-weight:550; color:black;}
a{text-decoration:none; color:black;}
.swiper-button-next, .swiper-button-prev{top:30%; color:#333;}
.swiper-button-next:after, .swiper-button-prev:after{font-size:30px;}
.swiper-button-prev{left:-20px;}
.swiper-button-next{right:-20px;}
</style>
<body>
<%@ include file="common/navbar.jsp" %> 
<div class="container"> 

<%
	ProductDao productDao = ProductDao.getInstance();
	
	List<Product> saleProductList = productDao.selectProductsOnSale(1, 8);
	List<Product> newProductList = productDao.selectAllProducts(1, 8);
	DecimalFormat price = new DecimalFormat("###,###");


%>
	<!-- 
		세일상품목록
		3개만 출력.
	 -->   
	<div class="row mb-5 mt-5"> 
		<div class="col-3">
			<h1 class="mb-3 hot-deal">HOT DEAL</h1>
			<div>기간한정 특가할인!</div>				
			<div  class="mb-3" >지금 특별한 가격을 만나보세요!</div>
			<a href="sale.jsp" class="mt-5"><ins><strong>more</strong></ins></a>				
		</div>
		
		<div class="col-9 position-relative">
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
<%
	for(Product product : saleProductList){
%>
					<div class="swiper-slide">
						<a href="detail.jsp?no=<%=product.getNo()%>">
							<div class="swiper-img-box">
								<img src="resources/images/products/<%=product.getPhoto() %>" class="img1" alt="">
							</div>
							<div class="row mt-3 mb-3 p-2">
								<div class="col">
									<h5><strong><%=product.getBrand() %></strong></h5>
									<span class="mb-5"><%=product.getName() %></span>
	<%
		if(product.getDisPrice() > 0){
	%>						  
									  <div class="mt-3">
								        <span class="col card-text p-2 p"><%=price.format(product.getPrice()) %> 원</span>
								        <span class="col card-text  p-2 dp"><%=price.format(product.getDisPrice()) %> 원</span>
					    		   	  </div>
	<%
		} else {
	%>
									 <div class= "mt-3 text-end">
									 	<span class="col card-text p-2 dp"><%=price.format(product.getPrice()) %> 원</span>
									 </div>
	<%		
		}
	%>
								 </div>
							</div>
						</a>
					</div>
	<%
		}
	%>
				</div>
			</div>
		<div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
		</div>
	</div>
	<!-- 
		신상품순 상품목록
		
	 -->
	<div class="row p-5 mt-5 mb-5 text-center justify-content-center sub-title">
		<h1>NEW ARRIVALS</h1>
	</div>
     <div class="row mb-5 mt-5" style="margin: 0 20px 0px">
<%
for(Product product : newProductList){
%>	
		<div class="col-3">
			<a href="detail.jsp?no=<%=product.getNo() %>">
			<div class="img-box">
				<img src="resources/images/products/<%=product.getPhoto()%>" class="img1" alt="">
			</div>
			<div class="row mt-3 mb-3 p-2">
				<div class="col">
					<h5>
						<strong><%=product.getBrand()%></strong>
					</h5>
					<span class="mb-5"><%=product.getName()%></span>
<%
	if(product.getDisPrice() > 0){
%>	
					<div class="mt-3">
						<span class="col card-text p-2 p"><%=price.format(product.getPrice()) %> 원</span> 
						<span class="col card-text  p-2 dp"><%=price.format(product.getDisPrice())%> 원</span>
					</div>
<%
	} else {
%>
						 <div class= "mt-3 text-end">
						 	<span class="col card-text p-2 dp"><%=price.format(product.getPrice()) %> 원</span>
						 </div>
<%		
	}
%>					
				</div>
			</div>
			</a>
		</div>

<%
}
%>
	</div>
</div>
<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
      var swiper = new Swiper(".mySwiper", {
        slidesPerView: 3,
        spaceBetween: 10,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        autoplay: {
      	  delay: 3000,
      	  disableOnInteraction:false,
          pauseOnMouseEnter:true,
      	},
        loop:true
      });
</script>
</body>
</html>

    