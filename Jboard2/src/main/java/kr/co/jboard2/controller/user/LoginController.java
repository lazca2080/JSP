package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String success = req.getParameter("success");
		req.setAttribute("success", success);
		
		HttpSession session = req.getSession();
		session.removeAttribute("sessUserForId");
		session.removeAttribute("sessUserForPw");
		
		RequestDispatcher dispatcher =	req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid  = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		UserVO vo = service.selectUser(uid, pass);
		
		if(vo != null) {
			// 회원이 맞을경우
			HttpSession session = req.getSession();
			session.setAttribute("sessuser", vo);
			resp.sendRedirect("/Jboard2/list.do");
		}else {
			//회원이 아닐경우
			resp.sendRedirect("/Jboard2/user/login.do?success=100");
		}
		
	}

}
