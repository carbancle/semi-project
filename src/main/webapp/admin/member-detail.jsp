<%@page import="vo.QnA"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="dto.ReviewDetailDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
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
	 <style>
	 .link {color: black;}
	 </style>
	 
	 <title>ABC마트 관리자페이지</title>
	</head>
	
	<body>
	<%@ include file="admin-common.jsp" %>
	<div class="container">   
	
	<%
	int no = Integer.parseInt(request.getParameter("no"));
	
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(no);
	
	OrderDao orderDao = OrderDao.getInstance();
	List<Order> orderList = orderDao.selectAllOrdersByMemberNo(no);
	
	int totalOrderCount = orderList.size();
	
	 DecimalFormat priceDF = new DecimalFormat("###,###");
	
	%>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
	<div class="row mypage">
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
		<h4>상세 회원 정보</h4>
		<table class="table table-sm table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<colgroup>
					<col width="12%">
					<col width="38%">
					<col width="12%">
					<col width="38%">
					</colgroup>
					<tbody>
						<tr>
							<th>회원번호</th>
							<td><%=member.getNo() %></td>
							<th>이름</th>
							<td><%=member.getName() %></td>
						</tr>
						<tr>
							<th>ID</th>
							<td><%=member.getId() %></td>
							<th>연락처</th>
							<td><%=member.getTel() %></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><%=member.getEmail() %></td>
							<th>주소</th>
							<td><%=member.getAddress() %></td>
						</tr>
						<tr>
							<th>포인트</th>
							<td><%=member.getPct() %></td>
							<th>가입일</th>
							<td><%=member.getRegisteredDate() %></td>
						</tr>
					</tbody>				
		</table>
<%
ReviewDao reviewDao =ReviewDao.getInstance();
List<ReviewDetailDto> reviewList = reviewDao.getReviewListByMemberNo(1, 3, no);
QnaDao qnADao =QnaDao.getInstance();
List<QnADetailDto> qnAList = qnADao.selectQnAListByMemberNo(1, 3, no);

%>

		
		
		<div class="row">
			<div class="col-6">
         <h6>최근 작성한 REVIEW <a style="float:right;" href="review-list.jsp?page=1&option=id&keyword=<%=member.getId() %>" class="link"><strong>더보기</strong></a>	</h6>
         <table class="table table-hover align-middle mb-5" style="table-layout:fixed; border-top: 2px solid #000; border-bottom: 1px solid #000" >
               <tbody>
<%
      if (reviewList.isEmpty()) { 
%>         
                  <tr>
                     <td><h6>상품 후기가 없습니다.</h6></td>
                  </tr>
               </tbody>            
         </table>
<%
} else {

   for (ReviewDetailDto review : reviewList) {
         
%>               
                  <tr>
                     <td style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"">
                        <div style="position:relative; top:4px; display:inline-block; margin-right:8px; line-height:13px; font-size:13px;"">
                           <a href="product-detail.jsp?no=<%=review.getProductNo()%>"><%=review.getProductName() %></a><br>
                           <small class="text-muted" style="font-size:12px;">(<%=review.getReviewDate() %>)</small>       
                        </div>
                        <span><%=review.getContent() %></span>
                      </td>
                  </tr>
<% 
   }
%>                  
                  
               </tbody>            
         </table>
<% 
   }
%>
         </div>
			<div class="col-6">
			<h6>최근 작성한 QnA <a style="float:right;" href="qna-list.jsp?page=1&option=id&keyword=<%=member.getId() %>" class="link"><strong>더보기</strong></a></h6>
			  <table class="table table-hover align-middle mb-5" style="table-layout:fixed; border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (qnAList.isEmpty()) { 
%>			
			<tr>
                     <td><h6>상품 QnA가 없습니다.</h6></td>
                  </tr>
				</tbody>				
		</table>
<%
} else {

	for (QnADetailDto qnA : qnAList) {
			
%>					


 					<tr>
                     <td style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"">
                        <div style="position:relative; top:4px; display:inline-block; margin-right:8px; line-height:13px; font-size:13px;"">
                           <a href="product-detail.jsp?no=<%=qnA.getProductNo()%>"><%=qnA.getProductName() %></a><br>
                           <small class="text-muted" style="font-size:12px;">(<%=qnA.getQuestionDate() %>)</small>       
                        </div>
                        <span><%=qnA.getQuestionContent() %></span>
                      </td>
                  </tr> 	
<% 
	}
%>						
						
					</tbody>				
		</table>
<% 
	}
%>						
			
			
			</div>
		</div>
		
		
		
		<h6>총 구매 내역</h6>
		<table class="table table-hover table-striped table-sm">
		<colgroup>
			<col width="5%">
			<col width="20%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="13%">
	
		</colgroup>
		<thead>
			<tr>
				<th>No.</th>
				<th>상품</th>
				<th>총액</th>
				<th>주문일</th>
				<th>주문상태</th>
				<th>취소사유<small>(취소일)</small></th>
				
				
			</tr>
		</thead>
		<tbody>
<% 
	int sum = 0;
	for (Order order : orderList) {
		if (!"주문취소".equals(order.getStatus())) {
		
		sum += order.getTotalPrice();}
		
		List<OrderDetailDto> orderItemList = orderDao.selectAllOrderDetailsByOrderNo(order.getNo());
		int totalCount = orderItemList.size();
%>	
			<tr>
			
				<td><a href="order-detail.jsp?no=<%=order.getNo()%>"><%=order.getNo()%></td>			
				<td>
<%					
	for(OrderDetailDto orderItem : orderItemList)	{
%>					
				
				<strong><a href="product-detail.jsp?no=<%=orderItem.getProductNo()%>"><%=orderItem.getProductName()%></a></strong>(<%=orderItem.getSize() %>)
				
<% 
	}
%>					
	
				</td>
				
<%
if	("주문취소".equals(order.getStatus())) {
%>				
				<td style="text-decoration:line-through; color: red;"><%=priceDF.format(order.getTotalPrice())%>원</td>
				
<% 
	} else {
%>

				<td><%=priceDF.format(order.getTotalPrice())%>원</td>
<% 
} 
%>				
	
				<td><small class="text-muted"><%=order.getOrderDate() %></small></td>
				
<% if ("주문취소".equals(order.getStatus())) { 
%>		
				<td style="font-size: 14px; color: red;"><%=order.getStatus()%></td>
				
<% 
} else if ("배송완료".equals(order.getStatus())) { 
%>		
				<td style="font-size: 14px; color: blue;"><%=order.getStatus()%></td>
				
<% 
} else {
%>
				<td>
				<select name="status" style="height: 29px; font-size: 14px;" id="status-<%=order.getNo()%>" onchange="change(<%=order.getNo() %>)">
						 <option selected disabled value=<%=order.getStatus()%>><%=order.getStatus()%></option>
						 <option value="주문완료">주문완료</option>
						 <option value="상품준비중">상품준비중</option>
						 <option value="배송중">배송중</option>
						 <option value="배송완료">배송완료</option>
  				</select>
				</td>
<% 
} 
%>				
				
			<td><small><%=StringUtils.defaultString(order.getCancelReason(), "") %></small>
				<small class="text-muted"><%=order.getCanceledDate() != null ? "("+order.getCanceledDate()+")" : ""%></small></td>		
				
			</tr>
<% 
	}
%>	
		<tr>
			<td colspan="3">총 주문 횟수 :<strong style="color:#ee1c25;"> <%=totalOrderCount %> </strong>회</td>
			<td colspan="3">총 구매액 :<strong style="color:#ee1c25;"> <%=priceDF.format(sum) %> </strong>원</td>
		</tr>

		
		</tbody>
	</table>
	</div>	
	</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	
	function change(orderNo) {
		var status = document.getElementById("status-" + orderNo).value;
		location.href="member-order-status-change.jsp?no=" + orderNo + "&status=" + status+"&memberNo=<%=no%>";
	}
	
	</script>
	</body>
	</html>