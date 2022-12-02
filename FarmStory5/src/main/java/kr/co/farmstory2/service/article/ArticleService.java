package kr.co.farmstory2.service.article;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.farmstory2.dao.articleDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;
import kr.co.farmstory2.vo.PagenumVO;

public enum ArticleService {
	
	INSTANCE;
	private articleDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private ArticleService() { dao = new articleDAO(); }
	
	public int insertArticle(ArticleVO vo) {
		return dao.insertArticle(vo);
	}
	
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	
	public ArticleVO selectArticle(String no, String cate) {
		return dao.selectArticle(no, cate);
	}
	
	public FileVO selectFile(String no) {
		return dao.selectFile(no);
	}
	
	public List<ArticleVO> selectCommentList(String no) {
		return dao.selectCommentList(no);
	}
	
	public List<ArticleVO> selectArticles(int limitStart, String cate) {
		return dao.selectArticles(limitStart, cate);
	}
	
	public List<ArticleVO> searchArticleTitle(String cate, String search, int limitStart) {
		return dao.searchArticleTitle(cate, search, limitStart);
	}
	
	public List<ArticleVO> searchArticleContent(String cate, String search, int limitStart) {
		return dao.searchArticleContent(cate, search, limitStart);
	}
	
	public List<ArticleVO> searchArticleComment(String cate, String search, int limitStart) {
		return dao.searchArticleComment(cate, search, limitStart);
	}
	
	public List<ArticleVO> searchArticleNick(String cate, String search, int limitStart) {
		return dao.searchArticleNick(cate, search, limitStart);
	}
	
	public List<ArticleVO> selectLatest(String cate1, String cate2, String cate3) {
		return dao.selectLatest(cate1, cate2, cate3);
	}
	
	public List<ArticleVO> selectLatest2(String cate) {
		return dao.selectLatest2(cate);
	}
	
	public void updateArticle(String no, String title, String content, String cate) {
		dao.updateArticle(no, title, content, cate);
	}
	
	public void deleteArticle(String no, String cate) {
		dao.deleteArticle(no, cate);
	}
	
	public List<ArticleVO> getLatests(String cate) {
		return dao.getLatests(cate);
	}
	
	public MultipartRequest fileUpload(HttpServletRequest req, String savePath) throws IOException {
		
		int maxSize = 1024 * 1024 * 10;
		return new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public ArticleVO insertComment(ArticleVO comment) {
		return dao.insertComment(comment);
	}
	
	public int[] deleteComment(String no, String parent) {
		return dao.deleteComment(no, parent);
	}
	
	public int updateComment(String content, String no) {
		return dao.updateComment(content, no);
	}
	// 추가적인 서비스 로직
	public String renameFile(String fname, String uid, String savePath) {
		
		// 확장자까지 길이
		int i = fname.lastIndexOf(".");
		// 파일 이름까지 자르기
		String ext = fname.substring(i);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String now = sdf.format(new Date());
		String newName = now+uid+ext;
		
		File f1 = new File(savePath+"/"+fname);
		File f2 = new File(savePath+"/"+newName);
		
		f1.renameTo(f2);
		
		return newName;
	}
	
	// 서비스 로직
	public PagenumVO pageNum(String pg, String cate) {
		
		int limitStart = 0;       // SQL Limit ?, 10의 ?값 시작값
		int currentPg = 1;        // 현재 페이지 값 로그인페이지에서 넘어올시 첫화면으로 표시하기 위해 1값
		int total = 0;            // 전체 게시글 수
		int lastPageNum = 0;      // 마지막 페이지 값
		int pageGroupCurrent = 1; // 현재 페이지 그룹
		int pageGroupStart = 1;   // 시작 페이지 그룹값
		int pageGroupEnd = 0;     // 마지막 페이지 그룹값
		int pageStartNum = 0;     // 이전 or 다음 버튼 클릭시 시작되는 페이지 그룹 번호
		
		
		total = dao.listTotalNum(cate);
		
		// 페이지 마지막 번호 계산
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = (total / 10) + 1;
		}
		
		// 현재 페이지 게시물 limit 시작값 계산
		if(pg != null){
			currentPg = Integer.parseInt(pg);
			// pg를 받아올때 로그인페이지에서 바로 넘어오는 경우 null이기 때문에 null 체크를 해준다
		}
		
		limitStart = (currentPg - 1) * 10;
		
		// 페이지 그룹 계산
		pageGroupCurrent =  (int)Math.ceil(currentPg / 10.0);
		pageGroupStart = (pageGroupCurrent-1) * 10 + 1;
		pageGroupEnd = pageGroupCurrent * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		// 페이지 시작 번호 계산
		pageStartNum = (total - limitStart)+1;
		
		PagenumVO vo = new PagenumVO();
		vo.setLimitStart(limitStart);
		vo.setCurrentPg(currentPg);
		vo.setTotal(total);
		vo.setLastPageNum(lastPageNum);
		vo.setPageGroupCurrent(pageGroupCurrent);
		vo.setPageGroupStart(pageGroupStart);
		vo.setPageGroupEnd(pageGroupEnd);
		vo.setPageStartNum(pageStartNum);
		
		return vo;
	}
	
public PagenumVO pageNum2(String pg, String cate, String search, String option) {
		
		int limitStart = 0;       // SQL Limit ?, 10의 ?값 시작값
		int currentPg = 1;        // 현재 페이지 값 로그인페이지에서 넘어올시 첫화면으로 표시하기 위해 1값
		int total = 0;            // 전체 게시글 수
		int lastPageNum = 0;      // 마지막 페이지 값
		int pageGroupCurrent = 1; // 현재 페이지 그룹
		int pageGroupStart = 1;   // 시작 페이지 그룹값
		int pageGroupEnd = 0;     // 마지막 페이지 그룹값
		int pageStartNum = 0;     // 이전 or 다음 버튼 클릭시 시작되는 페이지 그룹 번호
		
		
		if(option.equals("title")) {
			total = dao.titleTotalNum(cate, "%"+search+"%");
		}else if(option.equals("comment")) {
			total = dao.commentTotalNum(cate, "%"+search+"%");
		}else if(option.equals("nick")) {
			total = dao.nickTotalNum(cate, "%"+search+"%");
		}else if(option.equals("content")) {
			total = dao.contentTotalNum(cate, "%"+search+"%");
		}
		
		// 페이지 마지막 번호 계산
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = (total / 10) + 1;
		}
		
		// 현재 페이지 게시물 limit 시작값 계산
		if(pg != null){
			currentPg = Integer.parseInt(pg);
			// pg를 받아올때 로그인페이지에서 바로 넘어오는 경우 null이기 때문에 null 체크를 해준다
		}
		
		limitStart = (currentPg - 1) * 10;
		
		// 페이지 그룹 계산
		pageGroupCurrent =  (int)Math.ceil(currentPg / 10.0);
		pageGroupStart = (pageGroupCurrent-1) * 10 + 1;
		pageGroupEnd = pageGroupCurrent * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		// 페이지 시작 번호 계산
		pageStartNum = (total - limitStart)+1;
		
		PagenumVO vo = new PagenumVO();
		vo.setLimitStart(limitStart);
		vo.setCurrentPg(currentPg);
		vo.setTotal(total);
		vo.setLastPageNum(lastPageNum);
		vo.setPageGroupCurrent(pageGroupCurrent);
		vo.setPageGroupStart(pageGroupStart);
		vo.setPageGroupEnd(pageGroupEnd);
		vo.setPageStartNum(pageStartNum);
		
		return vo;
	}
	
	public Map<List<ArticleVO>, ArticleVO> divideArticles(List<ArticleVO> articles) {
		
		Map<List<ArticleVO>, ArticleVO> map = new HashMap<List<ArticleVO>, ArticleVO>();
		
		List<ArticleVO> vo1 = new ArrayList<>();
		List<ArticleVO> vo2 = new ArrayList<>();
		List<ArticleVO> vo3 = new ArrayList<>();
		
		for(int i=0; i<5; i++) {
			ArticleVO vo = articles.get(i);
			map.put(vo1, vo);
		}
		
		for(int i=5; i<10; i++) {
			ArticleVO vo = articles.get(i);
			vo2.add(vo);
			map.put(vo2, vo);
		}
		
		for(int i=10; i<15; i++) {
			ArticleVO vo = articles.get(i);
			vo3.add(vo);
			map.put(vo3, vo);
		}
		
		return map;
		
	}
}
