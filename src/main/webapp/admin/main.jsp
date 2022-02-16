<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
	 <title>ABC마트 관리자페이지</title>
	 <style>
	 
	.today-list-box {
    padding: 12px 0;
    border-top: 2px solid #000;
    border-bottom: 2px solid #000;
}

	.count {font-size: 22px; color: red;}

	 </style>
	</head>
	
	<body>
	<%@ include file="admin-common.jsp" %>
	<div class="container">   
	
	<%

	MemberDao memberDao = MemberDao.getInstance();
	List<Member> memberList = memberDao.selectTodayJoinMember();
	List<Member> leftMemberList = memberDao.selectTodayLeftMember();
	
	OrderDao orderDao = OrderDao.getInstance();
	List<Order> orderList = orderDao.selectAllOrdersToday();
	List<Order> canceledOrderList = orderDao.selectAllCanceledOrdersToday();
	ReviewDao reviewDao =ReviewDao.getInstance();
	
	List<ReviewDetailDto> reviewList = reviewDao.selectReviewDetailToday();
	QnaDao qnADao = QnaDao.getInstance();
	
	
	List<QnADetailDto> QnaList= qnADao.selectQnADetailNotAnswered();
	
	DecimalFormat priceDF = new DecimalFormat("###,###");
	
	SimpleDateFormat boardDF = new SimpleDateFormat("yyyy년 MM월 dd일 a HH시");
	
	
	// 상단 바에 넣을 count 
	int todayOrderCount = orderDao.selectTodayOrderCount();
	int todayCanceledOrderCount = orderDao.selectTodayCanceledOrderCount();
	int todayLeftCount = memberDao.selectTodayLeftCount();
	int todayJoinCount = memberDao.selectTodayJoinCount();
	int todayQnACount = qnADao.selectTodayQnACount();
	int todayReviewCount = reviewDao.selectTodayReviewCount();
	
	
	// progress에 넣을 퍼센티지
	int deliverRate = (int)(orderDao.selectdeliveredOrderCount()*100/orderDao.selectAllOrderCount());
	int answerRate = (int)(qnADao.selectAnsweredQnACount()*100/qnADao.selectAllQnACount());
	
	int cancelSum = 0;
	int sum = 0;
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
			<div class="today">
				<h5><%=boardDF.format(new Date()) %> 기준</h5>
				<div class="today-list-box">
					<div class="row">
						<div class="col">
							신규 회원
		                    <span class="count" id="todayJoinMember"><%=todayJoinCount %></span>
							명
						</div>
						<div class="col">
							탈퇴한 회원
							<span class="count" id="todayLeftMember"><%=todayLeftCount %></span>
							명
						</div>
						<div class="col">
							신규 주문
							<span class="count" id="todayOrder"><%=todayOrderCount %></span>
							건
						</div>
						<div class="col">
							취소된 주문
		                    <span class="count" id="todayCanceledOrder"><%=todayCanceledOrderCount %></span>
							건
						</div>
						<div class="col">
							신규 후기
							<span class="count" id="newReview"><%=todayReviewCount %></span>
							개
						</div>
						<div class="col">
							신규 QnA
							<span class="count" id="newQnA"><%=todayQnACount %></span>
							개
						</div>
					</div>
				</div>
			</div>
			
			<div class="row mt-3 mb-4">
				<div class="col-6 progress-box">
					<p>전체주문 중 <span style="margin-right:5px; color:red; font-weight: 
							bold;"><%=deliverRate %>%</span>배송완료</p>
					<div class="progress" style="height: 13px; width: 400px;" >
		 				<div class="progress-bar bg-danger progress-bar-striped progress-bar-animated" role="progressbar" style="width: <%=deliverRate %>%"></div>
					</div>
				</div>
				<div class="col-6 progress-box">
					<p>전체질문 중 <span style="margin-right:5px; color:red; font-weight: 
							bold;"><%=answerRate %>%</span>답변완료</p>
					<div class="progress" style="height: 13px; width: 400px;" >
		 				<div class="progress-bar bg-danger progress-bar-striped progress-bar-animated" role="progressbar" style="width: <%=answerRate %>%"></div>
					</div>
				</div>
			</div>
			<hr>
  <div class="row mt-3">
    <div class="col">
      <p>오늘 가입한 회원</p>
			<table class="table table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (memberList.isEmpty()) { 
%>			
			<td>오늘 가입한 회원이 없습니다</td>
				</tbody>				
		</table>
<%
} else {

	for (Member member : memberList) {
			
%>					
						<tr>
							<td><a href="member-detail.jsp?no=<%=member.getNo()%>"><%=member.getName()%></a>
						    (<%=member.getId() %>)
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
    <div class="col">
     <p>오늘 탈퇴한 회원</p>
			<table class="table table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (leftMemberList.isEmpty()) { 
%>			
			<td>오늘 탈퇴한 회원이 없습니다<td>
				</tbody>				
		</table>
<%
} else {

	for (Member member : leftMemberList) {
			
%>					
						<tr>
							<td><a href="member-detail.jsp?no=<%=member.getNo()%>"><%=member.getId() %></a>
						    <%=member.getName()%>	
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
    <div class="col">
     <p>신규 주문 내역</p>
			<table class="table table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (orderList.isEmpty()) { 
%>			
			<td>신규 주문이 없습니다<td>
				</tbody>				
		</table>
<%
} else {
	for (Order order : orderList) {
		sum += order.getTotalPrice();
%>					
						<tr>
							<td><a href="order-detail.jsp?no=<%=order.getNo()%>"><%=order.getNo()%></a>
						    <%=priceDF.format(order.getTotalPrice())%>원 (<%=order.getStatus()%>)	
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
    <div class="col">
       <p>취소된 주문 내역</p>
			<table class="table table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (canceledOrderList.isEmpty()) { 
%>			
			<td><h6>오늘 취소된 주문이 없습니다</h6><td>
				</tbody>				
		</table>
<%
} else {
	
	for (Order order : canceledOrderList) {
		cancelSum += order.getTotalPrice();	
%>					
						<tr>
							<td><a href="order-detail.jsp?no=<%=order.getNo()%>"><%=order.getNo()%></a>
						    <%=priceDF.format(order.getTotalPrice())%>원 (<%=order.getCancelReason()%>)	
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
  
	
<% 


%>						
	  
  <div class="row">
  	<div class="col">
  	 	<p class="text-end">총 매출액 : <span style="margin-right:8px; font-size:25px; color:red; font-weight: 
							bold;"><%=priceDF.format(sum-cancelSum) %></span>원</p>
  	</div>
  </div>
  <hr>
  <div class="row">
    <div class="col">
          <p>오늘 작성된 REVIEW</p>
			<table class="table table-hover mb-5" style="table-layout:fixed;  border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (reviewList.isEmpty()) { 
%>			
			<td><h6>오늘 작성된 리뷰가 없습니다</h6></td>
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
    <div class="col">
          <p>답변 미완료된 QnA</p>
			<table class="table table-hover mb-5" style="table-layout:fixed; border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (QnaList.isEmpty()) { 
%>			
			<td><h6>미완료된 질문이 없습니다</h6></td>
				</tbody>				
		</table>
<%
} else {

	for (QnADetailDto qnA : QnaList) {
			
%>					
					<tr>
                     <td style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
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

			
			
			
	</div>	
	</div>	
	</div>
	<%@ include file="../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	
	
	</script>
	</body>
	</html>