package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.article.ArticleService;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.PagenumVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pg = req.getParameter("pg");
		
		PagenumVO vo = service.pageNum(pg);

		// 현재 페이지 게시물 가져오기
		List<ArticleVO> articles = service.selectArticles();
		req.setAttribute("articles", articles);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
