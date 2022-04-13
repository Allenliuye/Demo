<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>後臺系統</title>
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

/* 選染照片大小 */
#img-pre img{ 
	float: left; 
	width: 200px; 
	height: 200px; 
	margin-right: 10px; 
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
			<h2 style="color: blue">您的個人資料</h2>
			<form method="post" action="${contextRoot}/updatePersonalInformation" enctype="multipart/form-data">
				<table>
					<tr>
						<td rowspan="6">
							<div id="img-pre"><img alt="${emp.empId}" src="${contextRoot}/src/img/EmpImg/${emp.photo}" ></div>
							<div id="add-pic"><input type="file" name="photo" id="up-file" onchange="fChange()"/></div>
							<input type="text" value="${emp.photo}" name="orphoto" hidden="">
						<td>員工編號
						<td><input type="text" name="empId" size="10"
							value="${emp.empId}" readonly="readonly">
						<td>姓名
						<td><input type="text" name="username" size="10"
							value="${emp.username}">
						<td>出生年月日
						<td><input type="date" class="form-control" name="birthday" size="10"
							value="${emp.birthday}">
					<tr>
						<td>部門
						<td><input type="text" size="10"
							value="${emp.fkDeptno.dname}" readonly="readonly">
							<input type="text" name="fkDepartmentDeptn" value="${emp.fkDeptno.deptno}" hidden="" >
						<td>職稱
						<td><input type="text" size="10"
							value="${emp.fkTitleId.titleName}" readonly="readonly">
							<input type="text" name="fkTitleId" value="${emp.fkTitleId.titleId}" hidden="" >
						<td>主管
						<td><input type="text" name="superiorName" size="10"
							value="${emp.superiorName}" readonly="readonly">
					<tr>
						<td>身分證
						<td><input type="text" name="id" size="10"
						value="${emp.id}">
						<td>手機
						<td><input type="text" name="phone" size="10"
							value="${emp.phone}">
						<td>性別
						<td><input type="radio" id="male" name="contact" value="男">
							<label for="contactChoice1">男</label> 
							<input type="radio" id="female" name="contact" value="女">
							<label for="contactChoice1">女</label>
					<tr>
						<td>最高學府
						<td><input type="text" name="highEdu" size="10"
							value="${emp.highEdu}">
						<td>學歷
						<td><input type="text" name="highLevel" size="10"
							value="${emp.highLevel}">
						<td>科系
						<td><input type="text" name="highMajor" size="10"
							value="${emp.highMajor}">
					<tr>
						<td>緊急聯絡人
						<td><input type="text" name="emergencyContact" size="10"
							value="${emp.emergencyContact}">
						<td>聯絡人關係
						<td><input type="text" name="contactRelationship" size="10"
							value="${emp.contactRelationship}">
						<td>聯絡人手機
						<td><input type="text" name="contactPhone" size="10"
							value="${emp.contactPhone}">
					<tr>
						<td>地址
						<td colspan="3"><input type="text" name="address" size="30"
							value="${emp.address}">
						<td>email
						<td>
						<input type="text" name="email" size="30"
							value="${emp.email}">
					</table>
				<input type="submit" value="確定" id="submit"/> 
				<a href="${contextRoot}/frontPage"><button type="button">返回首頁</button></a>
			</form>
		</div>
	</article>



	<footer> </footer>
	 <script type="text/javascript">

         $("#submit").click(function(){
        		if(confirm('確定要修改嗎?')){
        			alert('修改成功');
        		}else{
        			return false;
        		}
        	})
		
        //即時選染圖片
		function fChange() { 
			let file = document.getElementById('up-file'); 
			let imgPre = document.getElementById('img-pre'); // file 轉 blob對象 
			let bold = window.URL.createObjectURL(file.files[0]); // 創建img元素，並添加到img-pre元素里
			$('#img-pre img').remove()
			var img = document.createElement("img"); 
			img.setAttribute("src", bold); 
			imgPre.appendChild(img); 
		}
    </script>

</body>
</html>