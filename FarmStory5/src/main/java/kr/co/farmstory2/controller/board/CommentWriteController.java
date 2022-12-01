package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmstory2.service.article.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/commentWrite.do")
public class CommentWriteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String parent  = req.getParameter("parent");
		String uid     = req.getParameter("uid");
		String content = req.getParameter("content");
		String cate    = req.getParameter("cate");
		String regip   = req.getRemoteAddr();
		
		ArticleVO vo = new ArticleVO();
		vo.setParent(parent);
		vo.setUid(uid);
		vo.setContent(content);
		vo.setCate(cate);
		vo.setRegip(regip);
		
		resp.setContentType("text/html;charset=UTF-8");
		
		ArticleVO comment = service.insertComment(vo);
		JsonObject json = new JsonObject();
		
		if(comment != null) {
			json.addProperty("no", comment.getNo());
			json.addProperty("parent", comment.getParent());
			json.addProperty("content", comment.getContent());
			json.addProperty("rdate", comment.getRdate());
			json.addProperty("nick", comment.getNick());
			json.addProperty("result", "1");
		}else {
			json.addProperty("result", "0");
		}
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

}
