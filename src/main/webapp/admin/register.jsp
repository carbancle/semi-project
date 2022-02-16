<%@page import="service.ProductRegisterService"%>
<%@page import="form.NewProductForm"%>
<%@page import="utils.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 업로드된 파일이 저장되는 경로
	String saveDirectory = "C:\\Users\\Administrator\\git\\semi-project\\src\\main\\webapp\\resources\\images\\products";
	
	// 멀티파트요청을 처리하는 MultipartRequest객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, saveDirectory);
	
	// 요청파라미터값 조회하기
	String name = mr.getParameter("name");
	String category = mr.getParameter("category");
	String brand = mr.getParameter("brand");
	String gender = mr.getParameter("gender");
	

	int disPrice = Integer.parseInt(mr.getParameter("disPrice"));
	int price = Integer.parseInt(mr.getParameter("price"));
	int stock230 = Integer.parseInt(mr.getParameter("stock230"));
	int stock240 = Integer.parseInt(mr.getParameter("stock240"));
	int stock250 = Integer.parseInt(mr.getParameter("stock250"));
	int stock260 = Integer.parseInt(mr.getParameter("stock260"));
	int stock270 = Integer.parseInt(mr.getParameter("stock270"));
	int stock280 = Integer.parseInt(mr.getParameter("stock280"));
	int stock290 = Integer.parseInt(mr.getParameter("stock290"));
	
	
	
	// 업로드된 파일이름 조회하기
	String photo = mr.getFilename("photo");
	
	
	// 상품객체 생성해서 상품정보와 업로드된 파일의 파일명을 저장한다.
	NewProductForm newProductForm = new NewProductForm();
	newProductForm.setName(name);
	newProductForm.setCategory(category);
	newProductForm.setBrand(brand);
	newProductForm.setGender(gender);
	
	newProductForm.setPhoto(photo);
	
	newProductForm.setDisPrice(disPrice);
	newProductForm.setPrice(price);
	newProductForm.setStock230(stock230);
	newProductForm.setStock240(stock240);
	newProductForm.setStock250(stock250);
	newProductForm.setStock260(stock260);
	newProductForm.setStock270(stock270);
	newProductForm.setStock280(stock280);
	newProductForm.setStock290(stock290);
	
	ProductRegisterService prs = new ProductRegisterService();
	prs.registerNewProduct(newProductForm);
	
	response.sendRedirect("product-list.jsp?pgno=1");
	
%>