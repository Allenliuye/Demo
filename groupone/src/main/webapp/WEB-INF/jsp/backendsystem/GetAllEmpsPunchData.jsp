<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%!@SuppressWarnings("unchecked")%>
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
<script
	src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
<script src='${contextRoot}/js/flot/jquery.js' type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.js'
	type="text/javascript"></script>
<script src='${contextRoot}/js/flot/jquery.flot.pie.js'
	type="text/javascript"></script>
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

.center2 {
	width: 1100px;
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
		<div align="center">
			<table>
				<td>
				<div id="flot-memo"
				style="text-align: center; height: 30px; width: 100px; height: 20px; text-align: center; margin: 0"></div>
				<div id="flot-placeholder" style="width:250px;height:150px;margin:0 auto"></div>
				<td>員工資訊
				<td><select class="form-select" aria-describedby="empId"
					name="empId" id="empId">
						<c:forEach items="${emps}" var="emp">
							<option value="${emp.empId}">${emp.fkDeptno.dname}/${emp.fkTitleId.titleName}/${emp.empId}/${emp.username}</option>
						</c:forEach>
				</select>
				<td>年
				<td><select class="form-select" aria-describedby="years"
					name="year" id="year">
						<option value="2022" selected="selected">2022</option>
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
					<button class="btn btn-success btn-lg" id="punchToFlot">出勤記錄</button>
					<button class="btn btn-warning btn-lg" id="punchToCSV">報表輸出</button>
			</table>

		</div>
		<div class="demo-html">
			<table class="table table-striped table-bordered" id="querytable"
				style="width: 100%">
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
			<a href="${contextRoot}/frontPage"><button type="button"
					style="font-size: 24px">返回首頁</button></a>
		</div>
	</article>
<script type="text/javascript">
$("#punchToCSV").click(function(){
	let empId = $("#empId").val();
	let year = $("#year").val();
	let month = $("#month").val();
	console.log('http://localhost:8080/GroupOne/api/getEmpPunchToCsv?empId=' + empId + '&year=' + year + '&month=' + month);
	window.open('http://localhost:8080/GroupOne/api/getEmpPunchToCsv?empId=' + empId + '&year=' + year + '&month=' + month);
})

function createCsvFile(){
  var fileName = "ooooo.csv";//匯出的檔名
  var data = getRandomData();
  var blob = new Blob([data], {
    type : "application/octet-stream"
  });
  var href = URL.createObjectURL(blob);
  var link = document.createElement("a");
  document.body.appendChild(link);
  link.href = href;
  link.download = fileName;
  link.click();
}

//產生圓餅圖及資料
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

//圓餅圖標籤參數
var options = {
	    series: {
	        pie: {
	            show: true,
	            label: {
	                show: true,
	                radius: 50,
	                formatter: function (label, series) {
	                    return '<div style="border:1px solid grey;font-size:10pt;text-align:center;padding:5px;color:white;">' +
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
	<footer> </footer>
</body>
</html>