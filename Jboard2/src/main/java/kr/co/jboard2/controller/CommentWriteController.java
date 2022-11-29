package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.article.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/commentWrite.do")
public class CommentWriteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no      = req.getParameter("no");
		String parent  = req.getParameter("parent");
		String content = req.getParameter("content");
		String uid     = req.getParameter("uid");
		String regip   = req.getRemoteAddr();
		
		ArticleVO comment = new ArticleVO();
		comment.setParent(no);
		comment.setContent(content);
		comment.setUid(uid);
		comment.setRegip(regip);
		
		ArticleVO vo = service.insertComment(comment);
		
		//resp.setContentType("text/html;charset=UTF-8");
		
		JsonObject json = new JsonObject();
		json.addProperty("result", 1);
		json.addProperty("no", vo.getNo());
		json.addProperty("nick", vo.getNick());
		json.addProperty("date", vo.getRdate());
		json.addProperty("content", vo.getContent());
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
