package controller.book;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import vo.BookVO;

@WebServlet("/book/modify.do")
public class ModifyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = req.getParameter("id");
		
		BookVO vo = BookDAO.getInstance().selectBook(id);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/book/modify.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id    = req.getParameter("id");
		String name  = req.getParameter("name");
		String pub   = req.getParameter("pub");
		String price = req.getParameter("price");
		
		BookVO vo = new BookVO();
		vo.setId(id);
		vo.setName(name);
		vo.setPub(pub);
		vo.setPrice(price);
		
		BookDAO.getInstance().updateBook(vo);
		
		resp.sendRedirect("/Bookstore2/book/list.do");
	}
}
