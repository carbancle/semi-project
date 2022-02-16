<%@page import="dao.MemberDao"%>
<%@page import="vo.Stock"%>
<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Product"%>
<%@page import="vo.Member"%>
<%@page import="vo.Order"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="dao.StockDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%
	Member loginedUser = (Member) session.getAttribute("LOGIN_USER_INFO");
	// 세션이 파기됐을 때 오류창을 방지하기 위해 loginedUser가 null일 때 로그인창으로 이동한다
	if (loginedUser == null) {
		response.sendRedirect("../../loginform.jsp?user=undefined");
		return;
	}
	StockDao stockDao = StockDao.getInstance();
	OrderDao orderDao = OrderDao.getInstance();
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();
	MemberDao memberDao = MemberDao.getInstance();

	
	Member member = memberDao.selectMemberByNo(loginedUser.getNo());
	
	// order-confirm.jsp에서 상품번호, amount, size를 조회한다
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int size = Integer.parseInt(request.getParameter("size"));
	
	// productNo와 size로 상품재고번호를 조회한다
	int stockNo = stockDao.selectStockNoByProductNoAndSize(productNo, size);
	
	// 요청파라미터에서 가져온 productNo로 상품을 조회한다
	Product product = productDao.selectProductbyNo(productNo);
	
	// 새 주문번호를 생성한다
	int orderNo = orderDao.getOrderNo();
	
	// OrderItem 객체를 생성해 주문번호, 수량, 상품재고번호를 저장한다
	OrderItem orderItem = new OrderItem();
	orderItem.setOrderNo(orderNo);
	orderItem.setAmount(amount);
	orderItem.setStockNo(stockNo);
	
	// 가져온 product의 정보로 disprice가 존재하면 할인가격으로 totalPrice를 계산하고,
	// 아니면 기존 가격으로 totalPrice를 계산한다
	int totalPrice = 0;
	if (product.getDisPrice() > 0) {
		totalPrice = product.getDisPrice() * orderItem.getAmount() ;
	} else {
		totalPrice = product.getPrice() * orderItem.getAmount();
	}
	
	// Order 객체를 생성해 주문번호, 멤버번호, totalPrice를 저장한다
	Order order = new Order();
	order.setNo(orderNo);
	order.setMemberNo(member.getNo());
	order.setTotalPrice(totalPrice);
	
	// 선택한 상품의 재고를 조정한다
	// stock번호로 해당 아이템의 재고정보를 조회하고, 주문한 수량만큼 차감시킨다
	Stock stock = stockDao.selectStockByProductDetailNo(stockNo);
	stock.setStock(stock.getStock() - orderItem.getAmount());

	member.setPct(member.getPct() + (int)(totalPrice * 0.01));
	
	// 변경한 객체를 업데이트 및 추가시킨다
	orderDao.insertOrder(order);
	orderItemDao.insertOrderItem(orderItem);
	stockDao.updateStock(stock);
	memberDao.updateMember(member);
	
	// 주문이 완료되면 주문완료창으로 이동
	response.sendRedirect("completeorder.jsp?orderNo="+orderNo+"&productNo="+productNo+"&amount="+amount+"&size="+size);
%>