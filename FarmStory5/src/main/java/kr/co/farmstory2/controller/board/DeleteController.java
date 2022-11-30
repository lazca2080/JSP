package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.service.article.ArticleService;

@WebServlet("/board/delete.do")
public class DeleteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no    = req.getParameter("no");
		String group = req.getParameter("group");
		String cate  = req.getParameter("cate");
		String pg    = req.getParameter("pg");
		
		service.deleteArticle(no, cate);
		
		resp.sendRedirect("/FarmStory5/board/list.do?group="+group+"&cate="+cate+"&pg="+pg);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
