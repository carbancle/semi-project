package dto;

import java.util.Date;

import vo.Member;
import vo.Product;

/**
 * Member와 Product 테이블 조인
 * @author Administrator
 *
 */
public class QnADetailDto {

	private int MemberNo;
	private String MemberName;
	private String MemberId;
	private int QnANo;
	private int productNo;
	private String title;
	private String questionContent;
	private String answerContent;
	private String questionAnswered; //답변완료 여부
	private Date questionDate;
	private Date answerDate;
	private String photo;
	private String productName;
	private String productBrand;

	public QnADetailDto() {}

	
	
	public String getProductBrand() {
		return productBrand;
	}



	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}



	public int getMemberNo() {
		return MemberNo;
	}

	public void setMemberNo(int memberNo) {
		MemberNo = memberNo;
	}


	public String getMemberName() {
		return MemberName;
	}

	public void setMemberName(String memberName) {
		MemberName = memberName;
	}

	public String getMemberId() {
		return MemberId;
	}

	public void setMemberId(String memberId) {
		MemberId = memberId;
	}

	public int getQnANo() {
		return QnANo;
	}

	public void setQnANo(int qnANo) {
		QnANo = qnANo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

	public String getQuestionAnswered() {
		return questionAnswered;
	}

	public void setQuestionAnswered(String questionAnswered) {
		this.questionAnswered = questionAnswered;
	}

	public Date getQuestionDate() {
		return questionDate;
	}

	public void setQuestionDate(Date questionDate) {
		this.questionDate = questionDate;
	}

	public Date getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	
	
}
