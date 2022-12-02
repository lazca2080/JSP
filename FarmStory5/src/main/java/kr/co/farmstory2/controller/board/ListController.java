package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.farmstory2.service.article.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.PagenumVO;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String group  = req.getParameter("group");
		String cate   = req.getParameter("cate");
		String pg     = req.getParameter("pg");
		String option = req.getParameter("option");
		String search = req.getParameter("search");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		
		if(option != null && search != null) {
			PagenumVO pnum = service.pageNum2(pg, cate, search, option);
			if(option.equals("title")) {
				List<ArticleVO> title   = service.searchArticleTitle(cate, search, pnum.getLimitStart());
				req.setAttribute("article", title);
				req.setAttribute("pnum", pnum);
				req.setAttribute("option", option);
				req.setAttribute("search", search);
			}else if(option.equals("content")) {
				List<ArticleVO> content = service.searchArticleContent(cate, search, pnum.getLimitStart());
				req.setAttribute("article", content);
				req.setAttribute("pnum", pnum);
				req.setAttribute("option", option);
				req.setAttribute("search", search);
			}else if(option.equals("comment")) {
				List<ArticleVO> comment = service.searchArticleComment(cate, search, pnum.getLimitStart());
				req.setAttribute("article", comment);
				req.setAttribute("pnum", pnum);
				req.setAttribute("option", option);
				req.setAttribute("search", search);
			}else if(option.equals("nick")) {
				List<ArticleVO> nick    = service.searchArticleNick(cate, search, pnum.getLimitStart());
				req.setAttribute("article", nick);
				req.setAttribute("pnum", pnum);
				req.setAttribute("option", option);
				req.setAttribute("search", search);
			}
			
		}else {
			PagenumVO pnum = service.pageNum(pg, cate);
			List<ArticleVO> articles = service.selectArticles(pnum.getLimitStart(), cate);
			
			req.setAttribute("article", articles);
			req.setAttribute("pnum", pnum);
		}
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		String group = req.getParameter("group");
		String cate  = req.getParameter("cate");
		String pg    = req.getParameter("pg");
		String option = req.getParameter("option");
		String search = req.getParameter("search");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		PagenumVO spnum = service.pageNum(pg, cate);
		
		List<ArticleVO> title   = service.searchArticleTitle(cate, search, spnum.getLimitStart());
		List<ArticleVO> comment = service.searchArticleComment(cate, search, spnum.getLimitStart());
		List<ArticleVO> content = service.searchArticleContent(cate, search, spnum.getLimitStart());
		List<ArticleVO> nick    = service.searchArticleNick(cate, search, spnum.getLimitStart());
		*/
	}
}
