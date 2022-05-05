<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>後臺系統</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
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
        table {
            background-color: white;
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
		<div class="demo-html">
<!-- 		<h2 style="color:blue">您的打卡紀錄</h2> -->

		<table class="table table-striped table-bordered" id="querytable" >
			<thead class="table-dark">
				<tr>
					<th>員工編號</th>
					<th>打卡日期</th>
					<th>上班時間</th>
					<th>下班時間</th>
				</tr>
			</thead>
			<c:forEach items="${puns}" var="pun" varStatus="s">
			<tr>
			<td>${pun.empId}</td>
			<td>${pun.punchYear}-${pun.punchMonth}-${pun.punchDate}</td>
			<td>${pun.onWorkTime}</td>
			<td>${pun.offWorkTime}</td>
			<c:set var="count" value="${s.count}" />
			</tr>
			</c:forEach>
		</table>
		<h3>共${count}筆資料</h3>
		<a href="${contextRoot}/frontPage" ><button type="button" style="font-size: 24px">返回首頁</button></a>
		</div>
		</article>

<script>
		$(document).ready(function() {
			$('#querytable').DataTable({
				columnDefs : [ {
					targets : -1,
					className : 'display'
				} ]
			});

		});
	</script>

        <footer>

        </footer>

</body>
</html>