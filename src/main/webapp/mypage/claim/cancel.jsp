<%@page import="dto.OrderDetailDto"%>
<%@page import="java.util.Date"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Stock"%>
<%@page import="vo.Order"%>
<%@page import="vo.Member"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%

	Member loginedUser = (Member) session.getAttribute("LOGIN_USER_INFO");

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String values[] = request.getParameterValues("stockNo");
	String reason = request.getParameter("cancelReason");
	
	OrderDao orderDao = OrderDao.getInstance();
	StockDao stockDao = StockDao.getInstance();
	MemberDao memberDao = MemberDao.getInstance();
	
	Member member = memberDao.selectMemberByNo(loginedUser.getNo());
	
	// stockNo로 가져온 번호를 하나씩 조회한다
	int stockNo = 0;
	for (int i = 0; i < values.length; i++) {
		stockNo = Integer.parseInt(values[i]);
		
		// stockNo로 재고 정보를 가져온다
		Stock stock = stockDao.selectStockByProductDetailNo(stockNo);
		
		// 주문번호와 재고번호에 해당하는 취소주문정보를 가져온다
		OrderDetailDto orderItem = orderDao.selectOrderDetailByOrderNoAndStockNo(orderNo, stockNo);
		stock.setStock(stock.getStock() + orderItem.getAmount());
		
		stockDao.updateStock(stock);
	}
	
	Order order = orderDao.selectOrderByOrderNo(orderNo);
	order.setStatus("주문취소");
	order.setCancelReason(reason);
	order.setCancelStatus("Y");
	order.setCanceledDate(new Date());
	
	// 멤버의 현재 포인트보다 적립금액이 높으면 0으로 업데이트
	int memberPct = (int)(order.getTotalPrice()*0.01);
	if (member.getPct() < memberPct) {
		member.setPct(0);
	} else {
		member.setPct(member.getPct() - memberPct);
	}
	
	orderDao.updateOrder(order);
	memberDao.updateMember(member);
	
	response.sendRedirect("../claim/cancel-main.jsp?claimCancel=canceled");
%>