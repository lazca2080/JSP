<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String no     = request.getParameter("no");
	String pg     = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
%>
<% String ctx = request.getContextPath(); %>
<script type="text/javascript" src="<%=ctx %>/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	$(function(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "sub",
		sSkinURI: "/Jboard1/smartEditor/SmartEditor2Skin.html",	
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,         
            fOnBeforeUnload : function(){
                 
            }
        }, 
        fOnAppLoad : function(){
            //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
            oEditors.getById["sub"].exec("PASTE_HTML", [ ]);
            let content = document.getElementById("sub").value;

            if(content == '') {
              alert("내용을 입력해주세요.");
              oEditors.getById["sub"].exec("FOCUS");
              return;
            } else {
              console.log(content);
            }
        },
        fCreator: "createSEditor2"
    });
    
    //저장버튼 클릭시 form 전송
    $(".btnSubmit").click(function(){
        oEditors.getById["sub"].exec("UPDATE_CONTENTS_FIELD", []);
        $("#frm").submit();
    });    
});
</script>
<main id="Board">
    <section class="Modify">
        <form action="/Jboard1/proc/modifyProc.jsp" method="post" id="frm">
			<input type="hidden" name="no" value=<%= no %>>
           	<input type="hidden" name="pg" value=<%= pg %>>
            <table>
                <caption>글수정</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" value="<%= article.getTitle() %>"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="text" id="sub" cols="30" rows="10"><%= article.getContent() %></textarea></td>
                </tr>
            </table>
            <div>
                <a href="/Jboard1/view.jsp?no=<%= no %>&pg=<%= pg %>" class="btn">취소</a>
                <button><input type="submit" value="수정완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>