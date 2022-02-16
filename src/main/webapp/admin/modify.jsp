<%@page import="vo.Stock"%>
<%@page import="utils.MultipartRequest"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.StockDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


//업로드된 파일이 저장되는 경로
	String saveDirectory = "C:\\Users\\Administrator\\git\\semi-project\\src\\main\\webapp\\resources\\images\\products";
	
// 멀티파트요청을 처리하는 MultipartRequest객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, saveDirectory);
	int no = Integer.parseInt(mr.getParameter("no"));

ProductDao productDao = ProductDao.getInstance();
StockDao stockDao = StockDao.getInstance();

Product product = productDao.selectProductbyNo(no);

	// 요청파라미터값 조회하기
	
	String name = mr.getParameter("name");
	String category = mr.getParameter("category");
	String brand = mr.getParameter("brand");
	String gender = mr.getParameter("gender");
	int disPrice = Integer.parseInt(mr.getParameter("disPrice"));
	int price = Integer.parseInt(mr.getParameter("price"));
	
	// 업로드된 파일이름 조회하기
	String photo = product.getPhoto();
	
	if (mr.getFilename("photo") != null) {
	
	photo = mr.getFilename("photo"); } 
	
	int stock230 = Integer.parseInt(mr.getParameter("stock-230"));
	int stock240 = Integer.parseInt(mr.getParameter("stock-240"));
	int stock250 = Integer.parseInt(mr.getParameter("stock-250"));
	int stock260 = Integer.parseInt(mr.getParameter("stock-260"));
	int stock270 = Integer.parseInt(mr.getParameter("stock-270"));
	int stock280 = Integer.parseInt(mr.getParameter("stock-280"));
	int stock290 = Integer.parseInt(mr.getParameter("stock-290"));

	

	product.setName(name);
	product.setBrand(brand);
	product.setCategory(category);
	product.setGender(gender);
	product.setPrice(price);
	product.setDisPrice(disPrice);
	product.setPhoto(photo);
	
	productDao.updateProduct(product);	
	
	int stockNo230 = stockDao.selectStockNoByProductNoAndSize(no, 230);
	int stockNo240 = stockDao.selectStockNoByProductNoAndSize(no, 240);
	int stockNo250 = stockDao.selectStockNoByProductNoAndSize(no, 250);
	int stockNo260 = stockDao.selectStockNoByProductNoAndSize(no, 260);
	int stockNo270 = stockDao.selectStockNoByProductNoAndSize(no, 270);
	int stockNo280 = stockDao.selectStockNoByProductNoAndSize(no, 280);
	int stockNo290 = stockDao.selectStockNoByProductNoAndSize(no, 290);
	
	Stock stockSize230 = stockDao.selectStockByProductDetailNo(stockNo230);
	Stock stockSize240 = stockDao.selectStockByProductDetailNo(stockNo240);
	Stock stockSize250 = stockDao.selectStockByProductDetailNo(stockNo250);
	Stock stockSize260 = stockDao.selectStockByProductDetailNo(stockNo260);
	Stock stockSize270 = stockDao.selectStockByProductDetailNo(stockNo270);
	Stock stockSize280 = stockDao.selectStockByProductDetailNo(stockNo280);
	Stock stockSize290 = stockDao.selectStockByProductDetailNo(stockNo290);
	
	stockSize230.setStock(stock230);
	stockSize240.setStock(stock240);
	stockSize250.setStock(stock250);
	stockSize260.setStock(stock260);
	stockSize270.setStock(stock270);
	stockSize280.setStock(stock280);
	stockSize290.setStock(stock290);
	
	stockDao.updateStock(stockSize230);
	stockDao.updateStock(stockSize240);
	stockDao.updateStock(stockSize250);
	stockDao.updateStock(stockSize260);
	stockDao.updateStock(stockSize270);
	stockDao.updateStock(stockSize280);
	stockDao.updateStock(stockSize290);
	
	
	
	
	
	response.sendRedirect("product-detail.jsp?no="+no);



%>
