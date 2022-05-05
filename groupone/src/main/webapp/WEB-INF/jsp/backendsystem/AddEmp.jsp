<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>後臺系統</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap-datepicker.min.js"></script>
<script src="${contextRoot}/js/bootstrap-datepicker.zh-TW.min.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/bootstrap-datepicker.min"
	rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
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

.p1 {
            font-size: 10px;
            color: gray;
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

/* 即時渲染照片大小 */
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
			<h4 style="color: blue">員工資料<span style="color: red">(*必填)</span></h4>
			<form method="post" action="${contextRoot}/addEmpInformation"
				enctype="multipart/form-data">
				<table>
					<tr>
						<td rowspan="6">
							<div id="img-pre"><img alt="" src="${contextRoot}/src/img/EmpImg/Nopic/No-picture.png" width="20px" ></div>
							<div id="add-pic"><input type="file" name="photo" id="up-file" onchange="fChange()"/></div>
						<td><span style="color: red">*</span>姓名<br><span id="idsp1"></span>
						<td><input type="text" id="username" name="username" size="10">
							<p class="p1">(1.不可為空白2.至少兩個字3.必須全為中文)</p>
						<td><span style="color: red">*</span>出生年月日
						<td><input type="date" class="form-control" id="date" name="date">
					<tr>
						<td><span style="color: red">*</span>部門
						<td>
						<select class="form-select" aria-describedby="empDepart" name="fkDepartmentDeptn" id="fkDepartment">
								<c:forEach items="${dNames}" var="dName">
									<c:choose>
										<c:when test="${emp.fkDeptno.dname == dName.dname}">
											<option value="${dName.deptno}" selected="selected">${dName.dname}</option>
										</c:when>
										<c:otherwise>
											<option value="${dName.deptno}">${dName.dname}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						<td><span style="color: red">*</span>職稱
						<td>
							<select class="form-select" aria-describedby="empTitle" name="fkTitleId" id="fkTitleId">
								<c:forEach items="${tNames}" var="tName">
									<c:choose>
										<c:when test="${emp.fkTitleId.titleName == tName.titleName}">
											<option value="${tName.titleId}" selected="selected">${tName.titleName}</option>
										</c:when>
										<c:otherwise>
											<option value="${tName.titleId}">${tName.titleName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						<input type="text" id="superiorName" name="superiorName" size="10" value="待確認" hidden="">
					<tr>
						<td><span style="color: red">*</span>身分證
						<td><input type="text" id="identity" name="id" size="10">
						<td><span style="color: red">*</span>手機
						<td><input type="text" id="phone" name="phone" size="10">
						<td><span style="color: red">*</span>性別
						<td><input type="radio" id="male" name="contact" value="男">
							<label for="contactChoice1">男</label> 
							<input type="radio" id="female" name="contact" value="女">
							<label for="contactChoice1">女</label>
					<tr>
						<td>最高學府
						<td><input type="text" id="highEdu" name="highEdu" size="10">
						<td>學歷
						<td><input type="text" id="highLevel" name="highLevel" size="10">
						<td>科系
						<td><input type="text" id="highMajor" name="highMajor" size="10">
					<tr>
						<td>緊急聯絡人
						<td><input type="text" name="emergencyContact" size="10">
						<td>聯絡人關係
						<td><input type="text" name="contactRelationship" size="10">
						<td>聯絡人手機
						<td><input type="text" name="contactPhone" size="10">
					<tr>
						<td><span style="color: red">*</span>地址
						<td colspan="3">
						<input type="text" id="address" name="address" size="30">
						<td><span style="color: red">*</span>email
						<td colspan="3">
						<input type="text" id="email" name="email" size="30">
				</table>
				<a href="${contextRoot}/frontPage"><button type="button"
					style="font-size: 24px">返回首頁</button></a> 
			<input type="submit" style="font-size: 24px" value="確定" id="submit" />
			</form>
			<button class="btn btn-success btn-lg" id="addstaff_01">新員工資料</button>
		</div>
	</article>
<script type="text/javascript">
$("#submit").click(function(){
	if(confirm('資料輸入正確嗎?')){
		alert('新增成功');
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

	function init() {
		document.getElementById("username").addEventListener("blur", checkName);
		function checkName() {
                let theNameObject = document.getElementById("username");
                let theNameValue = theNameObject.value;
                let theNameLen = theNameValue.length;
                let sp1 = document.getElementById("idsp1");
                let f01 = false;
                if (theNameLen == "") {
                    sp1.innerHTML = "<span style='color:red;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/small_wrong.jpg\">不能空白</span>";
                } else if (theNameLen >= 2 && theNameLen <= 3) {
                    for (let j = 0; j <= theNameLen; j++) {
                        let ch1 = theNameValue.charCodeAt(j);
                        let ch2 = theNameValue.charAt(j).toUpperCase();
                        var re = new RegExp("[\u4E00-\u9FFF]");
                        console.log(ch2.charCodeAt(0));
                        // if (ch1 >= 0x4e00 || ch1 >= 0x9fff)
                        if (re.test(ch2)) {
                            f01 = true;
                        } else if (ch2 >= "0" && ch2 <= "9") {
                            sp1.innerHTML = "<span style='color:red;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/small_wrong.jpg\">不能輸入數字</span>";
                            f01 = false;
                            break;
                        } else if (ch2 >= "A" && ch2 <= "Z") {
                            sp1.innerHTML = "<span style='color:red;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/small_wrong.jpg\">不能輸入字母</span>";
                            f01 = false;
                            break;
                        } else if (ch1 >= "33" && ch1 <= "127") {
                            sp1.innerHTML = "<span style='color:red;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/small_wrong.jpg\">不能輸入特殊符號</span>";
                            f01 = false;
                            break;
                        }
                    }
                    if (f01) {
                        sp1.innerHTML = "<span style='color:green;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/correct.jpg\" >輸入正確</span>";
                    }
                } else {
                    sp1.innerHTML = "<span style='color:red;font-style:italic;font-size:14px;font-family:新細明體;font-weight:900;'><img src=\"${contextRoot}/src/img/other/small_wrong.jpg\">姓名長度錯誤</span>";
                }
            }


	}


	window.onload = init;
</script>
<script src="${contextRoot}/js/AddEmp.js"></script>
<script src="${contextRoot}/js/taiwan_districts.js"></script>

	<footer> </footer>

</body>
</html>