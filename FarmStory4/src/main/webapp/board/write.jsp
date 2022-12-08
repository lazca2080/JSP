<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
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
		elPlaceHolder: "content",
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
            oEditors.getById["content"].exec("PASTE_HTML", [""]);
        },
        fCreator: "createSEditor2"
    });
    
    //저장버튼 클릭시 form 전송
    $(".btnSubmit").click(function(){
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        $("#frm").submit();
    });    
});
</script>
<main id="Board">
    <section class="Write">
        <form action="/Jboard1/proc/writeProc.jsp" id="frm" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="uid" value="<%= ub.getUid() %>">
            <table>
                <caption>글쓰기</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                    	<textarea name="content" id="content"></textarea>
                   	</td>
                </tr>
                <tr>
                    <th>첨부</th>
                    <td><input type="file" name="fname"></td>
                </tr>
            </table>
            <div>
                <a href="/Jboard1/list.jsp" class="btn">취소</a>
                <button><input type="submit" value="작성완료" class="btn btnSubmit"></button>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>