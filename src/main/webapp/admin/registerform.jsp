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
   <link rel="stylesheet" href="../resources/css/style.css" />
   <title>ABC마트 관리자페이지</title>
</head>
<body>
<%@ include file="admin-common.jsp" %>

<% 



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
		<div class="col-9">
		<h4>신규 상품 등록</h4>
			<!-- 파일을 업로드 하는 폼 - method는 반드시 post로 지정한다.
			- enctype을 multipart/form-data로 지정한다.
			 *enctype는 폼 입력값을 어떤 형식으로 서버로 전달할지 지정하는 속성이다. 
			 *enctype을 지정하지 않으면 application/x-www-form-urlencoded가 기본값이다.
			 		- 폼 입력값이 서버로 전달되는 형식:name=아이폰13&maker=애플
			 		- 첨부파일을 서버로 전달할 수 없다.
			 
			 enctype="multipart/form-data"
			 		- 폼에 첨부파일 입력요소가 있을 때만 사용한다.
			 		- 첨부파일을 서버로 전달할 수 있다.
			 		- 서버로 전달되는 형식이 위의 형식과 다름.
			 -->
			<form method="post" action="register.jsp" enctype="multipart/form-data">
				<div class="register-box">
					<div>
					<label class="form-label" for="product-category">카테고리<span>*</span></label>
					<select name="category" id="product-category">
						 <option selected disabled>==선택==</option>
						 <option value="SNEAKERS">SNEAKERS</option>
						 <option value="SPORTS">SPORTS</option>
						 <option value="SANDALS">SANDALS</option>
						 <option value="SPORTS">LOAFERS</option>
  					</select>
  					</div>
					<div>
					<label class="form-label" for="product-brand">브랜드<span>*</span></label>
					<select name="brand" id="product-brand">
						<option selected disabled>==선택==</option>
						 <option value="아디다스">아디다스</option>
						 <option value="아키클래식">아키클래식</option>
						 <option value="리복">리복</option>
  					</select>
  					</div>
  					<div>
					<label class="form-label" for="product-gender">성별<span>*</span></label>
					<select name="gender" id="product-gender">
						<option selected disabled>==선택==</option>
						 <option value="F">여성용</option>
						 <option value="M">남성용</option>
  					</select>
  					</div>
  					<!-- 파일업로드 -->
  					<div>
						<label class="form-label" for="product-img">상품이미지<span>*</span></label>
						<input type="file" class="form-control" name="photo" id="product-img">
					</div>
  					
  					
					<div>
						<label class="form-label" for="product-name">상품이름<span>*</span></label>
						<input type="text" class="form-control" name="name" id="product-name">
					</div>
					<div class="row">
						<div class="col-6">
							<label class="form-label" for="product-price">가격<span>*</span></label>
							<input type="text" class="form-control" name="price" id="product-price">
						</div>
						<div class="col-6">
							<label class="form-label" for="product-disprice">할인가격<span>*</span></label>
							<input type="text" class="form-control" name="disPrice" id="product-disprice">
						</div>
					</div>
					<div class="row">
						<div class="col-4">
							<label class="form-label" for="stock-230">230 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock230" id="stock-230">
						</div>
						<div class="col-4">
							<label class="form-label" for="stock-240">240 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock240" id="stock-240">
						</div>
						<div class="col-4">
							<label class="form-label" for="stock-250">250 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock250" id="stock-250">
						</div>
					</div>
					<div class="row">
						<div class="col-4">
							<label class="form-label" for="stock-260">260 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock260" id="stock-260">
						</div>
						<div class="col-4">
							<label class="form-label" for="stock-270">270 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock270" id="stock-270">
						</div>
						
						<div class="col-4">
							<label class="form-label" for="stock-280">280 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock280" id="stock-280">
						</div>
					</div>
					<div class="row">
						<div class="col-4">
							<label class="form-label" for="stock-290">290 입고량<span>*</span></label>
							<input style="width:50px;" type="text" class="form-control" name="stock290" id="stock-290">
						</div>
					</div>
				</div>
				<div class="btn-box text-center">
					<button type="submit" class="btn btn-lg btn-dark">등록</button>
				</div>
			</form>
		</div>
		
</div>	
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>