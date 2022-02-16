<%@page import="vo.ReviewLiker"%>
<%@page import="vo.Member"%>
<%@page import="vo.Review"%>
<%@page import="dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	
	Member loginUser = (Member) session.getAttribute("LOGIN_USER_INFO");
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	// 리뷰번호로 모든 리뷰정보 반환. 
	Review review = reviewDao.selectReviewByReviewNo(reviewNo);
	
	if(loginUser.getNo() == review.getMemberNo()){
		response.sendRedirect("detail.jsp?no="+productNo);
		return;
	}
	
	// 리뷰번호와 사용자번호로 좋아요 누른 사람 조회. 
	ReviewLiker savedReviewLiker = reviewDao.selectReviewLiker(reviewNo,loginUser.getNo());
	
	if(savedReviewLiker != null){
		response.sendRedirect("detail.jsp?no="+productNo);
		return;
	}
	 
	// 좋아요한 사람을 좋아요테이블에 저장한다.
	ReviewLiker addReviewLiker = new ReviewLiker();
	addReviewLiker.setMemberNo(loginUser.getNo());
	addReviewLiker.setReviewNo(reviewNo);
	
	reviewDao.insertReviewLiker(addReviewLiker);
	
	// 리뷰번호로 리뷰를 찾아 카운트 넘버를 변경한다.
	Review addLikeCount = new Review();
	addLikeCount.setNo(reviewNo);
	addLikeCount.setLikeCount(review.getLikeCount() + 1);
	
	reviewDao.updateLikeCount(addLikeCount);
	
	// 카운트넘버를 올린 상품페이지로 돌아간다.
	response.sendRedirect("detail.jsp?no="+productNo);
	

%>