package kr.co.jboard2.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.jasper.servlet.JspServlet;

import kr.co.jboard2.service.article.ArticleService;
import kr.co.jboard2.vo.FileVO;

@WebServlet("/download.do")
public class DownloadController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 해당 글의 parent값 가져오기
		String parent = req.getParameter("parent");
		
		// 파일 선택
		FileVO vo = service.selectFile(parent);
		
		// 파일 다운로드를 위한 response 헤더 수정
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(vo.getOriName(), "utf-8"));
		resp.setHeader("Content-Transfer-Encoding", "binary");
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "private");
		
		// response 객체로 파일 스트림 작업
		HttpSession session = req.getSession();
		String savePath = session.getServletContext().getRealPath("/file");
		File file = new File(savePath+"/"+vo.getNewName());
		
		// 출력 스트림 초기화
		
		// 파일 IO
		BufferedInputStream bis  = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
		
		while(true){
			
			int data = bis.read();
			
			if(data == -1){
				break;
			}
			bos.write(data);
		}
		bos.close();
		bis.close();
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

	
}
