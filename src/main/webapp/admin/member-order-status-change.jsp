<%@page import="vo.Member"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%



String status = request.getParameter("status");
int orderNo = Integer.parseInt(request.getParameter("no"));
int memberNo = Integer.parseInt(request.getParameter("memberNo"));

OrderDao orderDao = OrderDao.getInstance();
Order order = orderDao.selectOrderByOrderNo(orderNo);
order.setStatus(status);

orderDao.updateOrderStatus(order);


response.sendRedirect("member-detail.jsp?no="+memberNo);

%>