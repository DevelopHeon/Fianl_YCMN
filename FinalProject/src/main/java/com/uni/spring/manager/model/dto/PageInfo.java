package com.uni.spring.manager.model.dto;

public class PageInfo {
	// 현재 페이지
	private int currentPage;
	// 게시글 총 갯수
	private int listCount;
	// 시작 페이지
	private int startPage;
	// 끝 페이지
	private int endPage;
	// 마지막 페이지
	private int maxPage;
	// 페이지당 글 갯수
	private int pageLimit;
	private int empLimit;
	// 쿼리에 쓸 start, end
	
	public PageInfo() {
		
	}
	
	public PageInfo(int currentPage, int listCount,int startPage, int endPage,  int maxPage, int pageLimit, int empLimit) {
		super();
		this.currentPage = currentPage;
		this.listCount = listCount;
		this.pageLimit = pageLimit;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.empLimit = empLimit;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getPageLimit() {
		return pageLimit;
	}

	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getEmpLimit() {
		return empLimit;
	}

	public void setEmpLimit(int empLimit) {
		this.empLimit = empLimit;
	}

	@Override
	public String toString() {
		return "PageInfo [currentPage=" + currentPage + ", listCount=" + listCount + ", pageLimit=" + pageLimit
				+ ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage=" + endPage + ", boardLimit="
				+ empLimit + "]";
	}
	
	

	
	
}
