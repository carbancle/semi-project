package service;

import java.sql.SQLException;
import java.util.Date;

import dao.QnaDao;
import vo.QnA;

public class QnAService {

	
	public void answerQuestion(int qnANo, String content) throws SQLException {
		
		QnaDao qnADao = QnaDao.getInstance();
		QnA qnA = qnADao.selectQnAByQnANo(qnANo);
		qnA.setAnswerContent(content);
		qnA.setAnswerDate(new Date());		//답변 시간 등록
		qnA.setQuestionAnswered("Y");		//답변 상태 변경
		qnADao.updateQnA(qnA);
	
	}
	
}
