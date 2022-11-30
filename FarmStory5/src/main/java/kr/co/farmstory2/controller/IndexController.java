package kr.co.farmstory2.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.co.farmstory2.service.article.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/index.do")
public class IndexController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<ArticleVO> articles = service.selectLatest("grow", "school", "story");
		
		//Map<List<ArticleVO>, ArticleVO> map = service.divideArticles(articles);
		List<ArticleVO> vo1 = new ArrayList<>();
		List<ArticleVO> vo2 = new ArrayList<>();
		List<ArticleVO> vo3 = new ArrayList<>();
		
		for(int i=0; i<5; i++) {
			ArticleVO vo = articles.get(i);
			vo1.add(vo);
		}
		
		for(int i=5; i<10; i++) {
			ArticleVO vo = articles.get(i);
			vo2.add(vo);
		}
		
		for(int i=10; i<15; i++) {
			ArticleVO vo = articles.get(i);
			vo3.add(vo);
		}
		
		req.setAttribute("vo1", vo1);
		req.setAttribute("vo2", vo2);
		req.setAttribute("vo3", vo3);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String cate = req.getParameter("cate");
		
		List<ArticleVO> vo = service.getLatests(cate);
		
		resp.setContentType("text/html;charset=UTF-8");
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(vo);
		
		PrintWriter writer = resp.getWriter();
		writer.print(jsonData);
	}
}
