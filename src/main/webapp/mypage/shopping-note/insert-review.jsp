<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Review"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int size  = Integer.parseInt(request.getParameter("size"));	
	String content = request.getParameter("content");
	
	// 내용을 쓰지않으면 넘어가지 않는다.
	if(content == null) {
		response.sendRedirect("my-review-form.jsp?error=contentEmpty");
		return;
	}
	StockDao stockDao = StockDao.getInstance(); 
	int stockNo = stockDao.selectStockNoByProductNoAndSize(productNo, size);
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	Review review = new Review();
	review.setMemberNo(member.getNo());
	review.setStockNo(stockNo);
	review.setContent(content);
	
	reviewDao.insertReview(review);
	
	OrderItem orderItem = new OrderItem();
	orderItem.setOrderNo(orderNo);
	orderItem.setStockNo(stockNo);
	
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	orderItemDao.updateReviewStatusByOrderNoStockNo(orderItem);
	
	response.sendRedirect("/semi-project/mypage/shopping-note/my-review.jsp?memberNo="+ member.getNo());
	

%>

s