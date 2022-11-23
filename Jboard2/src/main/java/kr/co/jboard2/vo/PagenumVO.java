package kr.co.jboard2.vo;

public class PagenumVO {
	private int limitStart;
	private int currentPg;
	private int total;
	private int lastPageNum;
	private int pageGroupCurrent ;
	private int pageGroupStart ;
	private int pageGroupEnd ;
	private int pageStartNum ;
	
	public int getLimitStart() {
		return limitStart;
	}
	public void setLimitStart(int limitStart) {
		this.limitStart = limitStart;
	}
	public int getCurrentPg() {
		return currentPg;
	}
	public void setCurrentPg(int currentPg) {
		this.currentPg = currentPg;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getLastPageNum() {
		return lastPageNum;
	}
	public void setLastPageNum(int lastPageNum) {
		this.lastPageNum = lastPageNum;
	}
	public int getPageGroupCurrent() {
		return pageGroupCurrent;
	}
	public void setPageGroupCurrent(int pageGroupCurrent) {
		this.pageGroupCurrent = pageGroupCurrent;
	}
	public int getPageGroupStart() {
		return pageGroupStart;
	}
	public void setPageGroupStart(int pageGroupStart) {
		this.pageGroupStart = pageGroupStart;
	}
	public int getPageGroupEnd() {
		return pageGroupEnd;
	}
	public void setPageGroupEnd(int pageGroupEnd) {
		this.pageGroupEnd = pageGroupEnd;
	}
	public int getPageStartNum() {
		return pageStartNum;
	}
	public void setPageStartNum(int pageStartNum) {
		this.pageStartNum = pageStartNum;
	}
	
	
	
}
