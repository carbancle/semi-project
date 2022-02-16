package vo;

import java.util.Date;

public class QnA {

	private int no;
	private int productNo;
	private int memberNo;
	private String title;
	private String questionContent;
	private String answerContent;
	private String questionAnswered; //답변완료 여부
	private Date questionDate;
	private Date answerDate;
	
	public QnA() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}



	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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
	
	
	
}
