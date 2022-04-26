
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>

</head>
<body>
	<a href="/GroupOne/st"><button type="button"
			class="btn btn-primary">查詢資料</button></a>
	<a href="/GroupOne/ad"><button type="button"
			class="btn btn-primary">新增資料</button></a>

	<table style="border: 3px #cccccc solid;" border='1'>
		<thead class="table-dark">
			<tr>
				<th>Idx</th>
				<th>Key</th>
				<th>Value</th>
			</tr>
		</thead>
		<c:forEach items="${DemoBean}" var="db" varStatus="s">
			<tr>
				<td>${db.idx}</td>
				<td>${db.c_base64}</td>
				<td>${db.c_aes256}</td>
				

			</tr>
		</c:forEach>
	</table>
</body>
</html>