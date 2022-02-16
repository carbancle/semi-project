
<%@page import="dao.MemberDao"%>
<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dto.CartDetailDto"%>
<%@page import="dao.CartDao"%>
<%@page import="vo.Member"%>
<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
	String values[] = request.getParameterValues("no");
	
	MemberDao memberDao = MemberDao.getInstance();
	CartDao cartDao = CartDao.getInstance();
	OrderDao orderDao = OrderDao.getInstance();
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	StockDao stockDao = StockDao.getInstance();
	
	int memberNo = loginUserInfo.getNo();
	
	Member member = memberDao.selectMemberByNo(memberNo);
	Order order = new Order();
	
	int orderNumber = orderDao.getOrderNo();
	order.setNo(orderNumber);
	order.setMemberNo(memberNo);
	
	int no = 0;
	int sum = 0;
	for (int i = 0; i < values.length; i ++){
		no = Integer.parseInt(values[i]);
		
		CartDetailDto cart = cartDao.selectCartByNo(no);
	
		if(cart.getProductDisprice() > 0){
			sum += cart.getProductDisprice() * cart.getAmount();
			
		} else {
			sum += cart.getProductPrice() * cart.getAmount();
		}
	}
	
	order.setTotalPrice(sum);
	orderDao.insertOrder(order);
	
	int pct = (int)(sum * 0.01);
	
	member.setPct(member.getPct() + pct);
	memberDao.updateMember(member);
	
	OrderItem orderItem = new OrderItem();
	
	orderItem.setOrderNo(orderNumber);
	for (int i = 0; i < values.length; i ++){
		no = Integer.parseInt(values[i]);
		
		CartDetailDto cart = cartDao.selectCartByNo(no);
		
		orderItem.setStockNo(cart.getStockNo());
		orderItem.setAmount(cart.getAmount());
		
		orderItemDao.insertOrderItem(orderItem);
		
		// 재고량 변경
			// 상품 상세번호를 통해 상세번호와 일치하는 db에 연결한다.
		Stock stock = stockDao.selectStockByProductDetailNo(cart.getStockNo());
			// 재고량 수량을 변경한다. (현재 재고량 - 구매수량)
		int remainStock = stock.getStock() - cart.getAmount();
			// 변경된 수량을 재고량에 반영한다.
		stock.setStock(remainStock);
			// 반영된 재고량을 db에 업데이트한다.
		stockDao.updateStock(stock);
			
		// 카트 삭제
		cartDao.deletedCartByNo(no);
	}
	
	response.sendRedirect("completeorder.jsp?no=" + orderNumber);

%>