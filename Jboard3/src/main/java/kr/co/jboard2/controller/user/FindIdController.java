package kr.co.jboard2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/findId.do")
public class FindIdController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private static UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*
		String eamil = req.getParameter("email");
		req.setAttribute("email", eamil);
		*/
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/findId.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name  = req.getParameter("name");
		String email = req.getParameter("email");
		
		UserVO vo = service.selectUserForFindId(name, email);
		
		JsonObject json = new JsonObject();
		
		if(vo != null) {
			json.addProperty("result", 1);
			HttpSession session = req.getSession();
			session.setAttribute("sessUserForId", vo);
		}else {
			json.addProperty("result", 0);
		}
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
		
		
		
		
		
		
		
		
		
		
		
		
		
		/*
		String name  = req.getParameter("name");
		String email = req.getParameter("email");
		
		int result1 = service.findId(name, email);
		
		int[] result = null;

		if(result1 == 1) {
			result = service.sendEmailCode(email);
			
			JsonObject json = new JsonObject();
			json.addProperty("status", result[0]);
			json.addProperty("code", result[1]);
			
			PrintWriter writer = resp.getWriter();
			writer.print(json.toString());
		}else {
			JsonObject json = new JsonObject();
			json.addProperty("status", '0');
			json.addProperty("code", '0');
			
			PrintWriter writer = resp.getWriter();
			writer.print(json.toString());
		}
		*/
	}

}
