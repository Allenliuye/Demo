function createCity() {
    let docFrag = document.createDocumentFragment(); //docfragment
    let cityValue = 0;
    $.each(data, function (index, value1) {
        let opt = document.createElement("option"); //City選項
        opt.value = cityValue;
        opt.innerHTML = value1.name;
        docFrag.appendChild(opt);
        cityValue += 1;
    });
    $("#idSelectCity").append(docFrag);

}

function createDistrict() {
    $("#idSelectDistrict").html('<option value="" style="display: none;"></option>'); //清空
    let docFrag = document.createDocumentFragment(); //docfragment
    let city = $("#idSelectCity").val();
    $.each(data[city].districts, function (index, value0) {
        let zip = value0.zip;
        let name = value0.name;
        let opt = document.createElement("option"); //District選項
        opt.value = zip + name;
        opt.innerHTML = zip + name;
        docFrag.appendChild(opt);
    })
    $("#idSelectDistrict").append(docFrag);

}

$("#address").click(function(){
    alert("哈囉");
    $("#address").write($("#idSelectCity").val());
})

function init() {
    createCity();
    $("#idSelectCity").change(createDistrict);
}

$(document).ready(init);