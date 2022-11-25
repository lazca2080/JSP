package kr.co.jboard2.service.article;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.articleDAO;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.FileVO;
import kr.co.jboard2.vo.PagenumVO;

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
	
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	
	public FileVO selectFile(String no) {
		return dao.selectFile(no);
	}
	
	public List<ArticleVO> selectCommentList(String no) {
		return dao.selectCommentList(no);
	}
	
	public List<ArticleVO> selectArticles(int limitStart) {
		return dao.selectArticles(limitStart);
	}
	
	public void updateArticle(String no, String title, String content) {
		dao.updateArticle(no, title, content);
	}
	
	public MultipartRequest fileUpload(HttpServletRequest req, String savePath) throws IOException {
		
		int maxSize = 1024 * 1024 * 10;
		return new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public ArticleVO insertComment(ArticleVO comment) {
		return dao.insertComment(comment);
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
	public PagenumVO pageNum(String pg) {
		
		int limitStart = 0;       // SQL Limit ?, 10의 ?값 시작값
		int currentPg = 1;        // 현재 페이지 값 로그인페이지에서 넘어올시 첫화면으로 표시하기 위해 1값
		int total = 0;            // 전체 게시글 수
		int lastPageNum = 0;      // 마지막 페이지 값
		int pageGroupCurrent = 1; // 현재 페이지 그룹
		int pageGroupStart = 1;   // 시작 페이지 그룹값
		int pageGroupEnd = 0;     // 마지막 페이지 그룹값
		int pageStartNum = 0;     // 이전 or 다음 버튼 클릭시 시작되는 페이지 그룹 번호
		
		total = dao.listTotalNum(pg);
		
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
}
