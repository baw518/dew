<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#list").click(function(){
		location.href="QnA_listView.do";
	});
	$("#change").click(function(){
		location.href="QnA_UpdateForm.do?qnaNo=${requestScope.qvo.qnaNo}";
	});
	$("#delete").click(function(){
		if("${requestScope.qvo.answerStatus}"==1){
			alert("채택완료된 답변글에대한 질문글은 삭제할수 없습니다.");
			return false;
		}
		if("${requestScope.qvo.answerStatus}"==2){
			alert("채택된 답변글은 삭제할수 없습니다.");
			return false;
		}
		if(!confirm("삭제를 하셔도 포인트를 돌려받지 못합니다. 삭제하시겠습니까??")){
			return false;
		}
		location.href="QnA_delete.do?qnaNo=${requestScope.qvo.qnaNo}";
	});
	
	$("#reply").click(function(){
		location.href="QnA_replyForm.do?qnaNo=${requestScope.qvo.qnaNo}";
	});
	
	$("#commentWriteBtn").click(function(){
		var content = $("#content").val();
		var id = $("#id").val();
		var boardNo =  $("#boardNo").val();
		if(content==""){
			alert("댓글 내용을 입력하세요");
			return false;
		}
		$.ajax({
		      type:"post",
		      url:"ajaxWriteComment.do",
		      data:"content="+content+"&id="+id+"&boardNo="+boardNo,
		      dataType:"json",
		      success:function(result){
		    	    $("#commentView").html("");
		    		var c = "";
		    		$.each(result,function(index,data){
						 c+="<tr><td>"+data.id+"</td>";
						 c+="<td>"+data.commentDate+"</td>";
						 c+="<td>"+data.content+"</td>";
						 if(id==data.id){
							 c+="<td><input type='hidden' id='commentNo' name='commentNo' value='"+data.commentNo+"'>"
							 +"<input type='button' id='commentUpdate' name='commentUpdate' value='수정'>"
							 +"<input type='button' id='commentDelete' name='commentDelete' value='삭제'></td>";
						 }
						 c+="</tr>";
					});
					$("#commentView").html(c);
					$("#content").val("");
		      } 
		});
		
	});
	
	$(document).on("click", "#commentDelete",function(e){
		var commentNo = $(this).parent().children().val();
		var id = $("#id").val();
		var boardNo = $("#boardNo").val();
		
		if($(this).val()=="삭제"){
			$.ajax({
			      type:"post",
			      url:"ajaxDeleteComment.do",
			      data:"commentNo="+commentNo+"&boardNo="+boardNo,
			      dataType:"json",
			      success:function(result){
			    	  $("#commentView").html("");
			    		var c = "";
			    		$.each(result,function(index,data){
							 c+="<tr><td>"+data.id+"</td>";
							 c+="<td>"+data.commentDate+"</td>";
							 c+="<td>"+data.content+"</td>";
							 if(id==data.id){
								 c+="<td><input type='hidden' id='commentNo' name='commentNo' value='"+data.commentNo+"'>"
								 +"<input type='button' id='commentUpdate' name='commentUpdate' value='수정'>"
								 +"<input type='button' id='commentDelete' name='commentDelete' value='삭제'></td>";
							 }
							 c+="</tr>";
						});
						$("#commentView").html(c);   
			      }
			});
		}
	});
	$(document).on("click", "#commentUpdate",function(e){
		var commentNo = $(this).parent().children().val();
		var commentContent =  $(this).parent().parent().children("td:eq(2)").text();
		var id = $("#id").val();
		var boardNo = $("#boardNo").val();
		alert("수정준비중");
	});
	
});
</script>



<table class="table" align="center" >
	<tr>
		<td>NO : ${requestScope.qvo.qnaNo } </td>
		<td colspan="3">${requestScope.qvo.title} </td>
	</tr>
	<tr>
		<td>작성자 :  ${requestScope.qvo.id }</td>
		<td>질문작성일 : ${requestScope.qvo.date }</td>
		<td>포인트 : ${requestScope.qvo.point }</td>
		<td>조회수 : ${requestScope.qvo.hit }</td>
	</tr>
	<tr>
		<td colspan="4">
		<pre>${requestScope.qvo.content}</pre>
		</td>
	</tr>
	<tr>
		<td colspan="4">
				<table class="table" align="center" id="commentView">
					<c:forEach items="${requestScope.cmvo}" var="i" varStatus="index">
						<tr>
							<td>${i.id}&nbsp;&nbsp;&nbsp;</td>
							<td>${i.commentDate}&nbsp;&nbsp;&nbsp;</td>
							<td colspan="3">${i.content}</td>
							<td>
								<c:if test="${sessionScope.mvo.id == i.id}">
									<input type="hidden" id="commentNo" name="commentNo" value="${i.commentNo}">
									<input type="button" id="commentUpdate" name="commentUpdate" value="수정">
									<input type="button" id="commentDelete"name="commentDelete" value="삭제">
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
			<table class="table">
				<tr>
					<td colspan="3"></td>
				<tr>
				<c:if test="${sessionScope.mvo ne null}">
					<tr>
						<td colspan="2"><input type="text" name="content" id="content" size="150"></td>
						<td align="left">
							<input type="button" name="commentWriteBtn" id="commentWriteBtn" value="댓글등록">
							<input type="hidden" name="id" id="id" value="${sessionScope.mvo.id }">
							<input type="hidden" name="boardNo" id="boardNo" value="${requestScope.qvo.qnaNo}">
						</td> 
					</tr>
				</c:if>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<c:if test="${sessionScope.mvo.id == requestScope.qvo.id}">
				<input type="button" id="reply" name="reply" value="답글달기">
			</c:if>
		</td>
		<td valign="middle" align="center" colspan="2">
			<input type="button" id="list" name="list" value="목록" id="list">
			<c:if test="${sessionScope.mvo.id == requestScope.qvo.id}">
				<input type="button" value="글수정" name="change" id="change">
				<input type="button" value="글삭제" name="delete" id="delete">
			</c:if>
		 </td>
		 <td></td>
	</tr>
</table>