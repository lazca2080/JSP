package utils;

import javax.servlet.jsp.JspWriter;

public class JSFunction {
	
	// 메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alerLocation(String msg, String url, JspWriter out) {
		try {
			String script = "" // 삽입할 자바 스크립트 코드
						+ "<script>"
						+ "		alert('"+ msg +"');"
						+ "		location.href='"+ url +"';"
						+ "</script>";
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						+ "<script>"
						+ "		alert('"+ msg +"');"
						+ "		history.back();"
						+ "</script>";
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
