<%@page import="dao.StockDao"%>
<%@page import="dao.CartDao"%>
<%@page import="vo.Member"%>
<%@page import="vo.Cart"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
 
	// 세션이 파기됐을 때 오류창을 방지하기 위해 loginedUser가 null일 때 로그인창으로 이동한다
	/* if (loginUserInfo == null) {
		response.sendRedirect("/semi-project/loginform.jsp?user=undefined");
		return;
	} */
	
	// 회원번호 정보를 가져온다.
	int memberNo = loginUserInfo.getNo();
	// 상품의 no값을 가져온다.
	int no = Integer.parseInt(request.getParameter("no"));
	// 상품의 size 값을 가져온다.
	int size = Integer.parseInt(request.getParameter("size"));
	// 상품을 담은 수량을 가져온다.
	int amount = Integer.parseInt(request.getParameter("amount"));
	
	StockDao stockDao = StockDao.getInstance();
	
	CartDao cartDao = CartDao.getInstance();
	
	List<Cart> cartList = cartDao.selectAllCartListByMemberNo(memberNo);
	
	// productNo와 size로 product_detail_no를 반환한다 StockDao selectStockNoByProductNoAndSize 활용
	int detailNo = stockDao.selectStockNoByProductNoAndSize(no, size);
	
	// 조회한값을 cart 변수를 만들어서 대입
	Cart cart = new Cart();
	
	// 제품상세번호를 확인함. 제품상세번호가 일치하는 경우, 장바구니 수량을 구매수량만큼 증가시킨다.
	int cnt = 0;
	for(int i = 0; i < cartList.size(); i++){
		cart = cartList.get(i);
		if(cart.getStockNo() == detailNo) {
			cnt++;
			int orderAmount = cart.getAmount() + amount;
			// 변경된 장바구니 수량 정보를 반영
			cart.setAmount(orderAmount);
			cart.setStockNo(detailNo);
			// db에 변경된 장바구니 수량을 업데이트한다.
			cartDao.updateCartAmountByDetailNo(cart);
		}
	}
	
	// 제품상세번호가 조회되지 않으면 신규 장바구니 정보를 등록, 구매수량 갯수를 db에 추가한다.
	if (cnt == 0) {
		cart.setMemberNo(memberNo);
		cart.setStockNo(detailNo);
		cart.setAmount(amount);
		cartDao.insertCartInfo(cart);
	}
	


	response.sendRedirect("../detail.jsp?no=" + no);
%>