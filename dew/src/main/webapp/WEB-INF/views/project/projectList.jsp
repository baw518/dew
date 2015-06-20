<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="${initParam.root}/css/dew.css" type="text/css">
<body>


<div id="dewTable">
<table  class="table">
<caption><h2>Project List</h2></caption>
<thead>
<tr>
<th class="projectNo">NO</th>
<th class="projectAchieve">상태</th>
<th class="projectName">프로젝트명</th>
<th class="writer">작성자</th>
<th class="point">포인트</th>
<th class="deadline">모집기간</th>
<th class="project_date">작성일</th>
<th>hit</th>
</tr>
</thead>
<tbody>
<c:forEach var="plist" items="${requestScope.plvo.list}">
<tr>
<td>${plist.projectNo}</td>
<td>${plist.achieve}</td>
<td><a href="project_View.do?projectNo=${plist.projectNo}">${plist.projectName} [${fn:length(plist.commentVO)}]</a></td>
<td>${plist.id}</td>
<td>${plist.point}<b>p</b></td>
<td class="deadlinelist">${plist.deadline}</td>
<td>${plist.project_date}</td>
<td>${plist.hit}</td>
</tr>
</c:forEach>
</tbody>
</table>
<p class="paging" align="center">
<c:set var="pb" value="${requestScope.plvo.pagingBean}"></c:set>
<c:if test="${pb.previousPageGroup}">
	<a href="project_listView.do?pageNo=${pb.startPageOfPageGroup-1}">
	◀ </a>	
	</c:if>
<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
	end="${pb.endPageOfPageGroup}">
	<c:choose>
	<c:when test="${pb.nowPage!=i}">
	<a href="project_listView.do?pageNo=${i}">${i}</a> 
	</c:when>
	<c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${pb.nextPageGroup}">
	<a href="project_listView.do?pageNo=${pb.endPageOfPageGroup+1}">
	▶</a>
	</c:if>
	</p>
</div>

</body>
</html>