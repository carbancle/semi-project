package vo;

/**
 * 페이징처리를 지원하는 클래스다.<p>
 * <ul>
 * 	<li>현재 페이지번호</li>
 * 	<li>현재 블록번호</li>
 * 	<li>총 데이터 갯수</li>
 * 	<li>총 페이지 갯수</li>
 * 	<li>총 블록 갯수</li>
 * 	<li>현재 블록의 시작 페이지번호</li>
 * 	<li>현재 블록의 끝 페이지번호</li>
 * 	<li>이전 블록의 페이지번호</li>
 * 	<li>다음 블록의 페이지번호</li>
 * 	<li>데이터조회 시작 순번</li>
 * 	<li>데이터조회 끝 순번</li>
 * <ul>
 * @author lee_e
 *
 */
public class Pagination3 {

		private int rowsPerPage = 8;
		private int pagesPerBlock = 5; 
		private int page = 1;
		private int totalPages;
		private int totalBlocks;

		public Pagination3(int page, int totalRows) {
			this.totalPages = (int)(Math.ceil((double)totalRows/rowsPerPage));
			if (totalPages == 0) {
				this.totalPages = 1;
			}
			this.totalBlocks = (int)(Math.ceil((double)totalPages/pagesPerBlock));
			this.page = page;
			if (page <= 0 || page > totalPages) {
				this.page = 1;
			}
		}

		public int getPage() {
			return page;
		} 
		public int getCurrentBlock() {
			return (int)(Math.ceil((double)this.page/pagesPerBlock));
		}
		public int getTotalPages() {
			return totalPages;
		}
		public int getTotalBlocks() {
			return totalBlocks;
		}
		public int getBegin() {
			return (this.getCurrentBlock() - 1)*pagesPerBlock + 1;
		}
		public int getEnd() {
			return getCurrentBlock() < totalBlocks ? this.getCurrentBlock()*pagesPerBlock : totalPages;
		}
		public int getBeginIndex() {
			return (page - 1)*rowsPerPage + 1;
		}
		public int getEndIndex() {
			return page*rowsPerPage;
		}
		public boolean isExistPrev() { 
			return getCurrentBlock() > 1; 
		}
		public boolean isExistNext() { 
			return getCurrentBlock() < getTotalBlocks(); 
		}
		public int getPrev() {
			if (isExistPrev()) {
				return (getCurrentBlock() - 1)*pagesPerBlock;
			}
			return page;
		}
		public int getNext() {
			if (isExistNext()) {
				return getCurrentBlock()*pagesPerBlock + 1;
			}
			return page;
		}
	}

	
	

