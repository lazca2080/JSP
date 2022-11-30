package kr.co.farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory2.service.user.UserService;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String success = req.getParameter("success");
		req.setAttribute("success", success);
		
		HttpSession session = req.getSession();
		session.removeAttribute("sessFindId");
		session.removeAttribute("sessFindPass");
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid  = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("saveUid");
		
		UserVO vo = service.selectUser(uid, pass);
		
		if(vo != null) {
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			
			if(auto != null) {
				String sessId = session.getId();
				
				//쿠키 생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				// sessId 데이터베이스 저장
				service.updateUserForSession(uid, sessId);
			}
			resp.sendRedirect("/FarmStory5/");
			
		}else {
			resp.sendRedirect("/FarmStory5/user/login.do?success=100");
		}
	}
}

