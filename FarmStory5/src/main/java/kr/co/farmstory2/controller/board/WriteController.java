package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.co.farmstory2.service.article.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/write.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		String savePath = session.getServletContext().getRealPath("/file");
		MultipartRequest mr = service.fileUpload(req, savePath);
		
		String uid     = mr.getParameter("uid");
		String cate    = mr.getParameter("cate");
		String group   = mr.getParameter("group");
		String title   = mr.getParameter("title");
		String content = mr.getParameter("content");
		String fname   = mr.getFilesystemName("fname");
		String regip   = req.getRemoteAddr();
		
		ArticleVO vo = new ArticleVO();
		vo.setUid(uid);
		vo.setCate(cate);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setRegip(regip);
		vo.setFname(fname);
		
		int parent = service.insertArticle(vo);
		
		if(fname != null) {
			// 파일명 수정
			String newName = service.renameFile(fname, uid, savePath);
			
			// 파일 테이블 Insert
			service.insertFile(parent, newName, fname);
		}
		
		resp.sendRedirect("/FarmStory5/board/list.do?group="+group+"&cate="+cate);
	}
}