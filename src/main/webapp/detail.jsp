        
<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.ReviewDetailDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
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
<title>ABC-마트 온라인몰</title>
</head>
<body>
	<%@ include file="common/navbar.jsp"%>
	<div class="container" id="detail-container">
		<%
		DecimalFormat price = new DecimalFormat("###,###");
		int productNo = Integer.parseInt(request.getParameter("no"));

		ProductDao productDao = ProductDao.getInstance(); 
		StockDao stockDao = StockDao.getInstance();

		Product product = productDao.selectProductbyNo(productNo);
		List<Stock> stockList = stockDao.selectStocksbyProductNo(productNo);
		%>

		<div class="product_view mt-5 mb-5">
			<h2><%=product.getName()%></h2>

			<form id="product-form" method="get" action="">
				<table style="border-top: 2px solid #000">
					<colgroup>
						<col width="30%">
						<col width="50%">
						<col width="20%">
					</colgroup>
					<tbody>
						<tr>
							<th>판매가</th>
	<%
		if(product.getDisPrice() > 0){
	%>
							<td class="price" colspan="2" id="price"><%=price.format(product.getDisPrice())%> 원</td>
	<%		
		} else {
	%>						
							<td class="price" colspan="2" id="price"><%=price.format(product.getPrice())%> 원</td>
	<%
			}
	%>

						</tr>
						<tr>
							<th>상품코드</th>
							<td colspan="2">
							<input type="hidden" name="no" value="<%=product.getNo()%>"> 
							<%=product.getNo()%>
							</td>
						</tr>
						<tr>
							<th>브랜드</th>
							<td colspan="2"><%=product.getBrand()%></td>
						</tr>
						<tr>
							<th>구매수량</th>
							<td colspan="2">
								<div class="length">
									<input name="amount" id="count" type="number" min="1" max="20" value="1" onchange="change();" readonly>
										<a href="#" onclick="plus(event)"> </a> 
										<a href="#" onclick="minus(event)"> </a>
								</div>
							</td>
						</tr>
						<tr>
							<th style="border-bottom: 1px solid #000">사이즈</th>
							<td colspan="2" style="border-bottom: 1px solid #000"><select
								name="size">
									<%
									for (Stock stock : stockList) {
									%>
									<option value=<%=stock.getSize()%>><%=stock.getSize()%></option>
									<%
									}
									%>
							</select></td>
						</tr>
						<tr>
							<th>결제금액</th>
	<%
		if(product.getDisPrice() > 0){
	%>
							<td colspan="2" class="total text-end"><b id="total-price"><%=price.format(product.getDisPrice())%></b>원</td>
	<%		
		} else {
	%>						
							<td colspan="2" class="total text-end"><b id="total-price"><%=price.format(product.getPrice())%></b>원</td>
	<%
			}
	%>
						</tr>
					</tbody>
				</table>
				<div class="">
					<button class="cart ms-1" type="button" onclick="goCart()">장바구니</button>
					<button class="buy ms-1" type="button" onclick="goOrder()">구매하기</button>
				</div>
			</form>
			<div class="img">
				<img src="resources/images/products/<%=product.getPhoto()%>" alt="">
			</div>
		</div>
		
		<style>
			.nav-link {color: black;}
			.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {font-weight: bold;}
		</style>
		<ul class="nav nav-tabs mb-3" role="tablist">
			<li class="nav-item"><a class="nav-link active"	aria-current="page" href="#review" data-bs-toggle="tab">리뷰</a></li>
			<li class="nav-item"><a class="nav-link" href="#qna" data-bs-toggle="tab">상품 Q&A</a></li>
		</ul>
		
		<div class="tab-content">
			<div id="review" class="container tab-pane active">
				<p class="mb-2" style="font-weight: bold;">상품 REVIEW</p>
				<div class="inquiry-box">
<%
	ReviewDao reviewDao = ReviewDao.getInstance();
	List<ReviewDetailDto> reviewDetails = reviewDao.selectReviewDetailByProductNo(productNo);
	int totalRecords = reviewDao.selectTotalReviewCountByProductNo(productNo);
	
	if (reviewDetails.isEmpty() || totalRecords == 0) {
%>
					<div class="row">
						<div class="p-5">
							<p class="text-center order-font container">작성된 상품 후기가 없습니다.</p>
						</div>
					</div>
<%
	} else {
%>
					<div class="row">
						<div class="col mt-2">
							<span style="margin-left: 5px;">총 <%=totalRecords%>건의 
								상품 후기가 있습니다.
							</span>
						</div>
						<div class="mt-3">
							<div class="accordion accordion-flush pt-3 pb-3" style="border-top:1px solid #333; border-bottom:1px solid #333;" id="reviewlist">
	<%
		for (ReviewDetailDto detail : reviewDetails) {
			if("N".equals(detail.getDeleted())){
	%>
								<div class="accordion-item">
									<div class="row p-2">
										<div class="col-1">
											<img class="order-img me-2"
												src="resources/images/products/<%=detail.getPhoto()%>">
										</div>
										<div class="col-2">
											<div>
												<div><strong><%=detail.getProductName()%></strong></div>
												<div><%=detail.getSize()%></div>
											</div>
										</div>
		<%
			if( loginUserInfo == null){ 
		%>									
										<div class="col-2">
											<button type="button" class="btn btn-outline-danger btn-sm rounded-pill" onclick="needLogin()" value="alert">
										  		likes <span class="badge rounded-pill bg-danger"><%=detail.getLikeCount() %></span>
											</button>
										</div>
		<%
			} else {
		%>
										<div class="col-2 mt-3 ">
											<button type="button" class="btn btn-outline-danger btn-sm rounded-pill" onclick="likeCount(<%=detail.getReviewNo()%>,<%=productNo%>)">
										  		likes <span class="badge rounded-pill bg-danger"><%=detail.getLikeCount() %></span>
											</button>
										</div>
		<%
			}
		%>
										<div class="col-3 mt-4 text-end">
											<span><strong><%=detail.getId()%></strong> 님</span>
										</div>
										<div class="col-2 mt-4 text-end">
											<span style="font-weight: bold;"><%=detail.getReviewDate()%></span>
										</div>
		<%
			if( loginUserInfo != null && loginUserInfo.getNo() == detail.getMemberNo()){ 
		%>
										<div class="col-1 mt-4 text-center">
											<button type=button class="btn-close" onclick="deleteReview(<%=detail.getReviewNo()%>,<%=productNo%>)"></button>
										</div>
		<%
			} else {
		%>
										<div class="col-1 mt-4 text-center">
										
										</div>
		<%
			}
		%>
										<div class="col-1 mt-3  text-end">
											<h2 class="accordion-header"
												id="review-heading-<%=detail.getReviewNo()%>">
												<button class="accordion-button collapsed" type="button"
													data-bs-toggle="collapse"
													data-bs-target="#review-content-<%=detail.getReviewNo()%>">
												</button>
											</h2>
										</div>
									</div>
									<div id="review-content-<%=detail.getReviewNo()%>"
										class="accordion-collapse collapse" data-bs-parent="#reviewlist">
		 								<div class="accordion-body mt-2">
											<strong>review : </strong><%=detail.getContent()%>
										</div>
									</div>
								</div>
	<%
			} // detail.getDeleted() if문 끝
		} // for문 끝
	%>
							</div>
						</div>
					</div>
<%
	} // else문 끝
%>
				</div>
			</div> <!-- review 끝 -->
			
			<div id="qna" class="container tab-pane fade">
				<p class="mb-2" style="font-weight:bold;">상품 Q&A</p>
				<div class="inquiry-box">
<%
	QnaDao qnaDao = QnaDao.getInstance();

	List<QnADetailDto> qnaDetails = qnaDao.selectQnAListByProductNo(1, 10,productNo);
	if (qnaDetails.isEmpty()) {
%>
					<div class="row">
						<div class="p-5">
							<p class="text-center order-font">작성된 상품 Q&A가 없습니다.</p>
						</div>
					</div>
<%
	} else {
%>
					<div class="row">
						<div class="col mt-2">
							<span style="margin-left: 5px;">총 <%=qnaDetails.size()%>건의
								상담내역이 있습니다.
							</span>
						</div>
						<div class="mt-3">
							<div class="accordion accordion-flush pt-3 pb-3" style="border-top:1px solid #333; border-bottom:1px solid #333;" id="qnalist">
	<%
		for (QnADetailDto detail : qnaDetails) {
	%>
								<div class="accordion-item">
									<div class="row p-2">
										<div class="col-3">
											<img class="order-img me-2"
												src="resources/images/products/<%=detail.getPhoto()%>">
												<div class="mt-1 p-3">
													<span><strong><%=detail.getProductName()%></strong></span>
												</div>
										</div>
										<div class="col-5 mt-4 text-end">
											<span><%=detail.getTitle()%></span>
										</div>
										<div class="col-2 mt-4 text-end">
											<span style="font-weight: bold;"><%=detail.getQuestionDate()%></span>
										</div>
		<%
			if ("N".equals(detail.getQuestionAnswered())) {
		%>
										<div class="col-1 mt-4 text-end">
											<span style="font-weight: bold;">미답변</span>
										</div>
		<%
			} else {
		%>
										<div class="col-1 mt-4 text-end">
											<span style="font-weight: bold;">답변완료</span>
										</div>
		<%
			}
		%>
										<div class="col-1 mt-3 text-end">
											<h2 class="accordion-header"
												id="qna-heading-<%=detail.getQnANo()%>">
												<button class="accordion-button collapsed" type="button"
													data-bs-toggle="collapse"
													data-bs-target="#qna-content-<%=detail.getQnANo()%>">
												</button>
											</h2>
										</div>
									</div>
									<div id="qna-content-<%=detail.getQnANo()%>"
										class="accordion-collapse collapse" data-bs-parent="#qnalist">
										<div class="accordion-body">
											<strong>Q. </strong><%=detail.getQuestionContent()%>
										</div>
										<div class="accordion-body">
		<%
			if (detail.getAnswerContent() == null) {
		%>
											<strong>A. 답변 대기 중입니다.</strong>
		<%
			} else {
		%>
											<strong>A. </strong><%=detail.getAnswerContent()%>
		<%
			}
		%>
										</div>
									</div>
								</div>
	<%
		} // for문 끝
	%>		
							</div>
						</div>
					</div>
<%
	} // else 끝
%>
				</div>
		<%
			// Q&A 등록폼
			if(loginUserInfo != null) {
		%>		
				<div class="mt-3 mb-3">
					<form class="border p-4 bg-light" method="post" action="insertQna.jsp">
						<input type="hidden" name="productNo" value="<%=productNo%>">
						<div class="mb-3">
							<label class="form-label mb-3" for="title"><strong>상품 Q&A 제목</strong></label>
							<input type="text" class="form-control" name="title" id="title" maxlength="30">
						</div>
						<div class="mb-2">
							<label class="form-label mb-3" for="content"><strong>상품 Q&A 내용</strong></label>
		    				<textarea class="form-control" name="content" id="content" rows="3" maxlength=""></textarea>
						</div>
						<div class="mt-3 text-end">
							<button type="submit" class="btn btn-dark">등록</button>
						</div>
					</form>
				</div>
		<%
			} 
		%>				
	
			</div>
		</div>	<!-- tab content 끝 -->
	</div>

	<%@ include file="common/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function getPrice() {
			var price = document.querySelector('#price').textContent.replace(/,/g, '');
			return parseInt(price);
		}
		
		function changeTotalPrice() {
			var price = getPrice();
			var count = document.getElementById('count').value;
			var totalPrice = price*count;
			var formattedTotalPrice = new Number(totalPrice).toLocaleString()
			document.querySelector("#total-price").textContent = formattedTotalPrice;
		}
	
		function plus(event) {
			event.preventDefault();
			var count = document.getElementById('count').value;
			if (count < 20) {
				count++;
			}
			document.getElementById('count').value = count;
			
			changeTotalPrice()
			
		}

		function minus(event) {
			event.preventDefault();
			var count = document.getElementById('count').value;
			if (count > 1) {
				count--;
			} else {
				count;
			}
			document.getElementById('count').value = count;
			
			changeTotalPrice()
		}
		
		function change() {
			changeTotalPrice() 
		}

		function goCart() {
			var form = document.getElementById("product-form");
			form.setAttribute("action", "/semi-project/mypage/add.jsp");
			if(<%=loginUserInfo == null %>) {
				alert('장바구니 담기는 로그인 후 사용가능합니다.');
				return;
			}
			form.submit();
			alert('상품이 장바구니에 담겼습니다.');
		}

		function goOrder() {
			var form = document.getElementById("product-form");
			form.setAttribute("action", "/semi-project/mypage/shopping-note/order-confirm.jsp");
			form.submit();
		}
		function goReview(no){
			location.href="/semi-project/mypage/shopping-note/my-review-form.jsp?productNo="+no;
			
		}
		function deleteReview(reviewNo,productNo){
			location.href="/semi-project/deleteReview.jsp?productNo="+productNo+"&reviewNo="+reviewNo;
		}
		function needLogin(productNo){
			alert('로그인이 필요한 기능입니다.'); 
		}
		function likeCount(reviewNo,productNo){
			location.href="/semi-project/likeCount.jsp?productNo="+productNo+"&reviewNo="+reviewNo;
		}
	</script>
</body>
</html>


    