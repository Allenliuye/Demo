<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src='${contextRoot}/js/jquery-3.6.0.min.js'
	type='text/javascript'></script>
<script src='${contextRoot}/js/moment.js' type="text/javascript"></script>

<meta charset="utf-8">
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
</style>
</head>

<body>
	<header class="head">
		<div class="center">
			<table>
				<tr>
					<td><img src="${contextRoot}/src/img/EmpImg/${admin.photo}"
						width="100px" style="border-radius: 50%;"></td>
					<td><h3 style="width: 300px">歡迎 ${admin.username} 使用本系統</h3>
					<td>
				</tr>
			</table>
		</div>

	</header>
	<article>
		<header class="headerlist">
			<ul class="list1">
				<li><a href="${contextRoot}/frontPage">首頁</a>
				<li><a href="${contextRoot}/getPersonalInformation">個人資料</a></li>
				<li><a href="${contextRoot}/getPersonalPunchData">個人打卡紀錄</a></li>
				<c:if test="${admin.fkDeptno.deptno == 300 || admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/getEmpPunchData">員工打卡紀錄</a></li>
				</c:if>
				<c:if test="${admin.fkDeptno.deptno == 300 || admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/employeeDataProcessing">員工資料處理</a></li>
				</c:if>
				<li><a href="${contextRoot}/singOut">登出</a></li>
			</ul>
		</header>
	</article>
	<article class="block2">
	<div>
		<img alt="" id="picH1" width="50"/><img alt="" id="picH2" width="50"/>
		<img alt="" id="picM1" width="50"/><img alt="" id="picM2" width="50"/>
		<img alt="" id="picS1" width="50"/><img alt="" id="picS2" width="50"/>
		<div id="punchData">
		</div>
	</div>
	<button class="btn btn-success btn-lg" id="onPunch">上班打卡</button>
	<button class="btn btn-danger btn-lg" id="offPunch">下班打卡</button>
	<a href="http://localhost:8080/GroupOne/api/punchToCSV"><button class="btn btn-warning btn-lg" id="punchToCSV">打卡報表輸出</button></a>

	</article>



	<footer> </footer>
<script type="text/javascript">

$("#onPunch").click(function(){
	$.ajax({
		url:'http://localhost:8080/GroupOne/api/punch',
		dataType:'json',
		method:'post',
		success:function(data){
			$('#punchData').html("");
			var punckTime='';
			if(data.empId != null){
				punckTime += '<span style="color: red;">'+'員工編號:'+ data.empId +'</span><br>'
				punckTime += '<span style="color: red;">'+'日期:'+ data.punchYear + data.punchMonth + data.punchDate +'</span><br>'
				punckTime += '<span style="color: red;">'+'上班時間:'+ data.onWorkTime +'</span><br>'
			}
			$('#punchData').append(punckTime);
		console.log("上班");
		}
	})
})

$("#offPunch").click(function(){
	$.ajax({
		url:'http://localhost:8080/GroupOne/api/punch',
		dataType:'json',
		method:'post',
		success:function(data){
			$('#punchData').html("");
			var punckTime='';
			if(data.empId != null){
				punckTime += '<span style="color: red;">'+'員工編號:'+ data.empId +'</span><br>'
				punckTime += '<span style="color: red;">'+'日期:'+ data.punchYear + data.punchMonth + data.punchDate +'</span><br>'
				punckTime += '<span style="color: red;">'+'下班時間:'+ data.offWorkTime +'</span><br>'
			}
			$('#punchData').append(punckTime);
		console.log("下班");
		}
	})
})


function setClock(){
     // document.getElementById("picS1").src="WinImages/1.gif";//秒的十位數
	 // document.getElementById("picS2").src="WinImages/2.gif";//秒的個位數       
	 //建立日期
	 let d=new Date();
	 //取得秒數，分割為兩位數
	 let h=d.getHours();//取得Date的"取秒數"方法
	 let h1=parseInt(h/10);//分的十位數
	 let h2=h%10;//分的個位數
	
	 let m=d.getMinutes();//取得Date的"取秒數"方法
	 let m1=parseInt(m/10);//分的十位數
	 let m2=m%10;//分的個位數
	
	 let s=d.getSeconds();//取得Date的"取秒數"方法
	 let s1=parseInt(s/10);//秒的十位數
	 let s2=s%10;//秒的個位數
	
	 //顯示圖片，對應秒數
	 "${contextRoot}/src/img/EmpImg/${admin.photo}"
	 document.getElementById("picH1").src="${contextRoot}/src/img/Clock/"+h1+".png";//before css5
	 document.getElementById("picH2").src="${contextRoot}/src/img/Clock/"+h2+".png";//css6 
	 document.getElementById("picM1").src="${contextRoot}/src/img/Clock/"+m1+".png";//before css5
	 document.getElementById("picM2").src="${contextRoot}/src/img/Clock/"+m2+".png";//css6 
	 document.getElementById("picS1").src="${contextRoot}/src/img/Clock/"+s1+".png";//before css5
	 document.getElementById("picS2").src="${contextRoot}/src/img/Clock/"+s2+".png";//css6 
	 }
	 
	 
	 
setClock();
window.setInterval(setClock,1000);

</script>

</body>

</html>