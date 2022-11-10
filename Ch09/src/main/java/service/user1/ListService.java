package service.user1;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListService implements CommonUser1Service {
	
	private static ListService instance = new ListService();
	public static ListService getinstance() {
		return instance;
	}
	
	private ListService() {}
	
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		return "/user1/list.jsp";
	}
}
