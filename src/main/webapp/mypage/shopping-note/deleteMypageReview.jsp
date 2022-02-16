<%@page import="dao.ReviewDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Member loginUser = (Member) session.getAttribute("LOGIN_USER_INFO");
int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));

ReviewDao reviewDao = ReviewDao.getInstance();
reviewDao.deleteReview(reviewNo);

response.sendRedirect("/semi-project/mypage/shopping-note/my-review.jsp?memberNo="+loginUser.getNo());


%>  