package service.user1;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModifyService implements CommonUser1Service{

	private static ModifyService instance = new ModifyService();
	
	public static ModifyService getinstance() {
		return instance;
	}
	
	private ModifyService() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		return "/user1/modify.jsp";
	}

}
