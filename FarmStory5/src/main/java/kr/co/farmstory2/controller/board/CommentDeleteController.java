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

@WebServlet("/board/commentDelete.do")
public class CommentDeleteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String parent = req.getParameter("parent");
		String no     = req.getParameter("no");
		
		int[] result = service.deleteComment(no, parent);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result[0]);
		json.addProperty("total", result[1]);
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
