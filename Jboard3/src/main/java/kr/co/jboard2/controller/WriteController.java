package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;import org.apache.jasper.compiler.NewlineReductionServletWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.service.UserService;
import kr.co.jboard2.service.article.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/write.do")
public class WriteController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static ArticleService service = ArticleService.INSTANCE;
	
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
		
		// 파일 업로드
		HttpSession session = req.getSession();
		String savePath = session.getServletContext().getRealPath("/file");
		MultipartRequest mr = service.fileUpload(req, savePath);
		
		// Multipart 데이터 폼 수신
		String uid     = mr.getParameter("uid");
		String title   = mr.getParameter("title");
		String content = mr.getParameter("content");
		String fname   = mr.getFilesystemName("fname");
		String regip   = req.getRemoteAddr();
		
		ArticleVO vo = new ArticleVO();
		vo.setUid(uid);
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
		resp.sendRedirect("/Jboard2/list.do");
	}
}
