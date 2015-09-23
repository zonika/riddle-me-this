$(function(){
  $("#phone").on("change keyup paste", function () {
    var output;
    var input = $("#phone").val();
    input = input.replace(/[^0-9]/g, '');
    var area = input.substr(0, 3);
    var pre = input.substr(3, 3);
    var tel = input.substr(6, 4);
    if (area.length < 3) {
        output = "(" + area;
    } else if (area.length == 3 && pre.length < 3) {
        output = "(" + area + ")" + " " + pre;
    } else if (area.length == 3 && pre.length == 3) {
        output = "(" + area + ")" + " " + pre + "-" + tel;
    }
    $("#phone").val(output);
  });
})
