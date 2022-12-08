package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.jboard2.service.article.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/commentList.do")
public class CommentListController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no = req.getParameter("no");
		
		List<ArticleVO> articles = service.selectCommentList(no);
		
		//resp.setContentType("text/html;charset=UTF-8");
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(articles);
		PrintWriter writer = resp.getWriter();
		writer.print(jsonData);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
