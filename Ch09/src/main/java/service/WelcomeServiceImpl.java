package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WelcomeServiceImpl implements CommonService {
	
	private static WelcomeServiceImpl instance = new WelcomeServiceImpl();
	public static WelcomeServiceImpl getinstance() {
		return instance;
	}
	private WelcomeServiceImpl() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		return "/welcome.jsp";
	}
}