<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%List<String> list=(List<String>)request.getAttribute("list"); %>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	 $(document).ready(function() {
		setTimeout("refreshChat()",3000); 
		$("#content").keydown(function(evt){
			if((evt.keyCode)&&(evt.keyCode==13)){
				sendMess();
				$("#content").val("");
			}
		});
	});
	function refreshChat(){
		$.ajax({
			type : "POST",
			url : "refreshChatAjax.do",
			data : "projectNo=" + <%=list.get(list.size()-1)%>,
			success : function(list) {
				var mess=list[0];
				for(var i=1;i<list.length;i++){
				mess+="<br>"+list[i];
				}
				$("#chatSpan").html(mess);
				setTimeout("refreshChat()",500); 
			}
		});
	} 
	function sendMess() {
		$.ajax({
			type : "POST",
			url : "sendChatAjax.do",
			data : "projectNo=" + <%=list.get(list.size()-1)%>+"&content="+$("#content").val(),
		});
	}
</script>
</head>
<body>
	<table border="1" cellpadding="5">
		<tr>
			<td width="320px" height="320px" valign="top">
			<span id="chatSpan">
			<c:forEach items="${requestScope.list }" var="list"  end="${fn:length(requestScope.list)-2}">
			${list }<br>
			</c:forEach></span></td>
		</tr>
		<tr>
			<td><input type="text" style="width: 290px" id="content" ></td>
		</tr>
	</table>
	<img src="${initParam.root}images/back.jpg" onclick="location.href='project_popupProGetJoiner.do?projectNo='+<%=list.get(list.size()-1)%>">
</body>
</html>