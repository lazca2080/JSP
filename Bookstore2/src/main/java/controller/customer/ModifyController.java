package controller.customer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import dao.CustomerDAO;
import vo.BookVO;
import vo.CustomerVO;

@WebServlet("/customer/modify.do")
public class ModifyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		
		CustomerVO vo = CustomerDAO.getInstance().selectCustomer(id);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/customer/modify.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id   = req.getParameter("id");
		String name = req.getParameter("name");
		String addr = req.getParameter("addr");
		String hp   = req.getParameter("hp");
		
		CustomerVO vo = new CustomerVO();
		vo.setId(id);
		vo.setName(name);
		vo.setAddr(addr);
		vo.setHp(hp);
		
		CustomerDAO.getInstance().updateCustomer(vo);
		
		resp.sendRedirect("/Bookstore2/customer/list.do");
	}

}
