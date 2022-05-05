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
            padding: 8px 15px;
            margin: 10px auto;
            /*auto 自動置中*/
            box-shadow: 5px 5px 15px gray;
            border-collapse: collapse;
            background-color: white;
        }
        td {
            width: 120px;
            text-align: center;
            font-size: 16px;
            border: 4px solid #00CACA;
            font-family: 'Courier New', Courier, monospace;
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
            <div align="center">
		<h2 style="color:blue">您的個人資料</h2>
		<table>
			<tr>
				<td colspan="3" rowspan="6"><img alt="${emp.empId}" src="${contextRoot}/src/img/EmpImg/${emp.photo}" width="200">
				<td>員工編號
				<td><h6 name="empId">${emp.empId}</h6>
				<td>姓名
				<td><h6>${emp.username}</h6>
				<td>出生年月日
				<td><h6>${emp.birthday}</h6>
			<tr>
				<td>部門
				<td><h6>${emp.fkDeptno.dname}</h6>
				<td>職稱
				<td><h6>${emp.fkTitleId.titleName}</h6>
				<td>主管
				<td><h6>${emp.superiorName}</h6>
			<tr>
				<td>身分證
				<td><h6>${emp.id}</h6>
				<td>手機
				<td><h6>${emp.phone}</h6>
				<td>性別
				<td><h6>${emp.sex}</h6>
			<tr>
				<td>最高學府
				<td><h6>${emp.highEdu}</h6>
				<td>學歷
				<td><h6>${emp.highLevel}</h6>
				<td>科系
				<td><h6>${emp.highMajor}</h6>
			<tr>
				<td>緊急聯絡人
				<td><h6>${emp.emergencyContact}</h6>
				<td>聯絡人關係
				<td><h6>${emp.contactRelationship}</h6>
				<td>聯絡人手機
				<td><h6>${emp.contactPhone}</h6>
			<tr>
				<td>地址
				<td colspan="3"><h6>${emp.address}</h6>
				<td>email
				<td colspan="4"><h6>${emp.email}</h6>
		</table>
		<table>
			
		</table>
		<a href="${contextRoot}/frontPage" ><button type="button">返回首頁</button></a>
		<a href="${contextRoot}/getUpdatePersonalInformation?empId=${emp.empId}" name="empId" ><button type="button">修改</button></a>
		<button type="button" class="btn btn-warning"
							onclick="location.href='${contextRoot}/changePassword?empId=${emp.empId}'">更改密碼</button>
	</div>
	<div align="center">
	<div>
	<img alt="${emp.empId}" src="${contextRoot}/src/img/EmpImg/${emp.qrcode}" width="200">
	</div>
		<a href="http://localhost:8080/GroupOne/api/dowQRcode"><button class="btn btn-success" id="dowQR">下載QR code</button></a>
	</div>
        </article>



        <footer>

        </footer>

</body>
</html>