package kr.co.jboard2.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.vo.UserVO;

@WebFilter("/*")
public class LoginCheckFilter implements Filter{
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private List<String> uriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		// 필터를 출력할 요청주소 리스트 구성
		uriList = new ArrayList<>();
		uriList.add("/Jboard2/list.do");
		uriList.add("/Jboard2/write.do");
		uriList.add("/Jboard2/modify.do");
		uriList.add("/Jboard2/view.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		logger.debug("LoginCheckFilter...");
		
		HttpServletRequest req   = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		
		/*
		HttpSession session = req.getSession();
		UserVO sessUser = (UserVO)session.getAttribute("sessUser");
		
		
		if(sessUser == null) {
			resp.sendRedirect("/Jboard2/user/login.do?success=102");
			return;
		}else {
			RequestDispatcher dispatcher = req.getRequestDispatcher(uri+".jsp");
			dispatcher.forward(req, resp);
		}
		*/
		
		if(uriList.contains(uri)) {
			HttpSession session = req.getSession();
			UserVO sessUser = (UserVO)session.getAttribute("sessUser");
			
			if(sessUser == null) {
				resp.sendRedirect("/Jboard2/user/login.do?success=102");
				return;
			}
		}
		chain.doFilter(request, response);
	}
}
