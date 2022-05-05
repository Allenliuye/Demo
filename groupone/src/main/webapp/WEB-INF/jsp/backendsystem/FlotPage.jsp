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
<script src='${contextRoot}/js/flot/jquery.js' type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.js'
	type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.pie.js'
	type="text/javascript"></script>
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
		<div>
<!-- 			<div id="flot-placeholder" -->
<!-- 				style="width: 400px; height: 400px; margin: 0 auto"></div> -->
<!-- 			<div id="flot-memo" -->
<!-- 				style="text-align: center; height: 30px; width: 100px; height: 20px; text-align: center; margin: 0"></div> -->
			<!-- 			<div id="flot-placeholder1" style="width:450px;height:300px;margin:0 auto"></div> -->
<!-- 			<div id="flot-placeholder2" style="width:450px;height:200px;margin:0 auto"></div> -->
		</div>
		<div>
			<table>
				<td>
				<div id="flot-memo"
				style="text-align: center; height: 30px; width: 100px; height: 20px; text-align: center; margin: 0"></div>
				<div id="flot-placeholder2" style="width:250px;height:150px;margin:0 auto"></div>
				<td>員工姓名
				<td><select class="form-select" aria-describedby="empId"
					name="empId" id="empId">
						<c:forEach items="${emps}" var="emp">
							<option value="${emp.empId}">${emp.username}</option>
						</c:forEach>
				</select>
				<td>年
				<td><select class="form-select" aria-describedby="years"
					name="year" id="year">
						<option value="2022" selected="selected">2022</option>
						<option value="2021">2021</option>
						<option value="2020">2020</option>
						<option value="2019">2019</option>
						<option value="2018">2018</option>
				</select>
				<td>日
				<td><select class="form-select" aria-describedby="months"
					name="month" id="month">
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
				</select>
					<button class="btn btn-warning btn-lg" id="punchToFlot">報表圖</button>
					<button class="btn btn-warning btn-lg" id="testButtub1">測試按鈕1</button>
					<button class="btn btn-warning btn-lg" id="testButtub2">測試按鈕2</button>
			</table>

		</div>
	</article>



	<footer> </footer>
	<script type="text/javascript">
	//('http://localhost:8080/GroupOne/api/getEmpPunchToCsv?empId=' + empId + '&years=' + years + '&months=' + months);

	$("#punchToFlot").click(function () {
		console.log("123");
		let empId = $("#empId").val();
		let year = $("#year").val();
		let month = $("#month").val();
		console.log("empId:"+empId);
	    
		$.ajax({
			url:'http://localhost:8080/GroupOne/api/getEmpPunchFlot?empId=' + empId + '&year=' + year + '&month=' + month,
			dataType:'json',
			method:'get',
			success:function(data){
				console.log("456");
				late = data.late;
				onTime = data.onTime;
				console.log("late:"+late);
				var dataSet = [
				    { label: "遲到", data: data.late, color: "#DE000F" },
				    { label: "準時", data: data.onTime, color: "#009100" }    
				];
				
				$.plot($("#flot-placeholder"), dataSet, options);
			    $("#flot-placeholder").showMemo();
			},
			error:function(err){
				}
		})
	})
	
	
	
	
	
	
	
	
	
	$("#testButtub1").click(function () {
		console.log("123");
	    $.plot($("#flot-placeholder"), dataSet1, options);
	    $("#flot-placeholder").showMemo();
	});
	
	var dataSet1 = [
	    { label: "遲到", data: 5, color: "#DE000F" },
	    { label: "準時", data: 15, color: "#009100" }    
	];

	
	$("#testButtub2").click(function () {
	    $.plot($("#flot-placeholder2"), dataSet2, options);
	    $("#flot-placeholder").showMemo();
	});
	
	var dataSet2 = [
	    { label: "遲到", data: 7, color: "#EAC100" },
	    { label: "準時", data: 15, color: "#5CADAD" }    
	];
	
	
	var options = {
	    series: {
	        pie: {
	            show: true,
	            label: {
	                show: true,
	                radius: 80,
	                formatter: function (label, series) {
	                    return '<div style="border:1px solid grey;font-size:12pt;text-align:center;padding:5px;color:white;">' +
	                    label + ' : ' +
	                    Math.round(series.percent) +
	                    '%</div>';
	                },
	                background: {
	                    opacity: 0.5,
	                    color: '#000'
	                }
	            }
	        }
	    },
	    legend: {
	        show: false
	    },
	    grid: {
	        hoverable: true
	    }
	};

	var options1 = {
	    series: {
	        pie: {
	            show: true,
	            tilt: 0.5
	        }
	    }
	};

	var options2 = {
	    series: {
	        pie: {
	            show: true,
	            innerRadius: 0.5,
	            label: {
	                show: true
	            }
	        }
	    }
	};




	//圓餅圖互動功能
	$.fn.showMemo = function () {
	    $(this).bind("plothover", function (event, pos, item) {
	        if (!item) { return; }
	        console.log(item.series.data)
	        var html = [];
	        var percent = parseFloat(item.series.percent).toFixed(2);        

	        html.push("<div style=\"border:1px solid grey;background-color:",
	             item.series.color,
	             "\">",
	             "<span style=\"color:white\">",
	             item.series.label,
	             " : ",
	             $.formatNumber(item.series.data[0][1], { format: "#,###", locale: "us" }),
	             " (", percent, "%)",
	             "</span>", 
	             "</div>");
	        $("#flot-memo").html(html.join(''));
	    });
	}

	</script>

</body>

</html>