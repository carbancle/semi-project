<%@page import="dao.CartDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 주문정보 삭제 메소드
	
	// 회원 로그인 정보를 조회
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
	// 장바구니 번호 정보를 가져온다.
	int no = Integer.parseInt(request.getParameter("no"));
	
	// 장바구니 db 정보를 조회한다.
	CartDao cartDao = CartDao.getInstance();
	
	cartDao.deletedCartByNo(no);
	
	response.sendRedirect("cart.jsp?memberNo=" + loginUserInfo.getNo());
%>