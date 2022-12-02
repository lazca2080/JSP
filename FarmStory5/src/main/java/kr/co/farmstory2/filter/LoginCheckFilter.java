package kr.co.farmstory2.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.vo.UserVO;

public class LoginCheckFilter implements Filter{

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private List<String> boardUriList;
	private List<String> userUriList;
	private List<String> loginList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		boardUriList = new ArrayList<>();
		boardUriList.add("/FarmStory5/board/write.do");
		boardUriList.add("/FarmStory5/board/view.do");
		boardUriList.add("/FarmStory5/board/modify.do");
		boardUriList.add("/FarmStory5/board/view.do");
		
		userUriList = new ArrayList<>();
		userUriList.add("/FarmStory5/user/findIdResult.do");
		userUriList.add("/FarmStory5/user/findPwChange.do");
		
		loginList = new ArrayList<>();
		loginList.add("/FarmStory5/user/login.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		logger.debug("LoginCheckFilter...");
		
		HttpServletRequest req   = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		
		HttpSession session = req.getSession();
		UserVO sessUser =  (UserVO)session.getAttribute("sessUser");
		
		if(boardUriList.contains(uri)) {
			if(sessUser == null) {
				resp.sendRedirect("/FarmStory5/user/login.do?success=102");
				return;
			}
		}else if(userUriList.contains(uri)) {
			resp.sendRedirect("/FarmStory5/");
			return;
		}else if(loginList.contains(uri)) {
			if(sessUser != null) {
				resp.sendRedirect("/FarmStory5/");
				return;
			}
		}
		chain.doFilter(req, resp);
	}
}
