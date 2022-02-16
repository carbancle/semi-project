<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
String option = StringUtils.defaultString(request.getParameter("option"), "");
String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");
String status = request.getParameter("status");
int orderNo = Integer.parseInt(request.getParameter("no"));

OrderDao orderDao = OrderDao.getInstance();
Order order = orderDao.selectOrderByOrderNo(orderNo);
order.setStatus(status);

orderDao.updateOrderStatus(order);


//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("order-list.jsp?page=" + pageNo + "&option=" + option + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"));

%>