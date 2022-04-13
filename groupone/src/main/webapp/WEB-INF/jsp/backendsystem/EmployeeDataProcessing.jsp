<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>後臺系統</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<style>
.gray1 {
	filter: grayscale(1);
}

.gray0 {
	filter: grayscale(0);
}

.center {
	width: 300px;
	margin: 0px auto;
}

p {
	display: flex;
	justify-content: center;
	font-size: 40px;
}
</style>
</head>
<body>
	<header class="head">
		<div class="center">
			<h2>歡迎 ${admin.username} 使用本系統</h2>
		</div>

	</header>
	<article>
		<header class="headerlist">
			<ul class="list1">
				<li><a href="${contextRoot}/frontPage">首頁</a>
				<li><a href="${contextRoot}/getPersonalInformation">個人資料</a></li>
				<li><a href="${contextRoot}/getPersonalPunchData">個人打卡紀錄</a></li>
				<c:if test="${admin.fkTitleId.titleId >= 10 || admin.fkDeptno.deptno == 300 && admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/getEmpPunchData">員工打卡紀錄</a></li>
				</c:if>
				<c:if test="${admin.fkTitleId.titleId >= 30 || admin.fkDeptno.deptno == 300 && admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/employeeDataProcessing">員工資料處理</a></li>
				</c:if>
				<li><a href="${contextRoot}/singOut">登出</a></li>
			</ul>
		</header>
	</article>
	<article class="block2">
		<div class="center">
			<h2>員工資料處理</h2>
			<table>
				<tr>
					<td>
						<form method="get" action="${contextRoot}/getAllEmpsInforation">
							<input type="submit" value="查詢所有員工" style="font-size: 24px" />
						</form>
				<tr>
					<td><a href="${contextRoot}/addEmp"><button type="button" style="font-size: 24px">新增員工</button></a>
			</table>
		</div>
	</article>



	<footer> </footer>
</body>
</html>