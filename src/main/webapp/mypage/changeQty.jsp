<%@page import="vo.Member"%>
<%@page import="dao.CartDao"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");

	//이전페이지에서 얻어야할 요청값 상품번호, 장바구니수량
	int no = Integer.parseInt(request.getParameter("no"));
	int qty = Integer.parseInt(request.getParameter("amount"));

	// 장바구니 번호로 제품수량을 조회하여 업데이트함.
	CartDao cartDao = CartDao.getInstance();
	
	Cart cart = new Cart();
	cart.setAmount(qty);
	cart.setNo(no);
	cartDao.updateCartAmountByNo(cart);
	
	response.sendRedirect("cart.jsp?memberNo=" + loginUserInfo.getNo());
%>