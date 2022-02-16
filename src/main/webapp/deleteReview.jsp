<%@page import="vo.Review"%>
<%@page import="dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int productNo = Integer.parseInt(request.getParameter("productNo"));
int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));

ReviewDao reviewDao = ReviewDao.getInstance();
reviewDao.deleteReview(reviewNo);

response.sendRedirect("detail.jsp?no="+productNo);


%> 