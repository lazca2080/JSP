package kr.co.jboard2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.UserService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/write.do")
public class WriteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/write.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid     = req.getParameter("uid");
		String title   = req.getParameter("title");
		String content = req.getParameter("content");
		String regip   = req.getRemoteAddr();
		
		ArticleVO vo = new ArticleVO();
		vo.setUid(uid);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setRegip(regip);
		vo.setFile(0);
		
		service.insertArticle(vo);
		
		resp.sendRedirect("/Jboard2/list.do");
		
	}

}
