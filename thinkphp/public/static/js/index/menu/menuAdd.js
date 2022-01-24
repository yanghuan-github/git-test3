// 添加一行节点
function addNodeLine() {
    var num = $('#node_line').attr('data-num');
    num = parseInt(num);
    var nodeDiv = $('.menuData:eq(0)').clone();
    var lableNum = num + 1;
    $(nodeDiv).find('label:first').text('节点[' + lableNum + ']：');
    $.each($(nodeDiv).find('input,select'), function (i, v) {
        eleName = $(v).attr('data-name');
        $(v).attr('name', 'actionName[' + lableNum + '][' + eleName + ']');
        if (eleName == 'sort') {
            sortNum = $(v).val();
            if (sortNum == '' || sortNum == null) sortNum = 0;
            sortNum = parseInt(sortNum);
            $(v).val(sortNum + num);
        }
        if (i < 2) {
            $(v).val('');
        }
    });
    $('#powerRole').before(nodeDiv);
    $('#node_line').attr('data-num', lableNum);
}

// 删除一行
function delNodeLine(obj) {
    if ($('.menuData').size() > 1) {
        $(obj).parent().remove();
    } else {
        msgFun('不能移除最后一个节点表单！');
    }
}

function submit(){
    let data = $('#form').serialize();
    $.ajax({
        type:   'post',
        data:   data,
        url:    '/index/Menu/menuAddSave',
        dataType: 'json',
        success:function(code){
            commonSaveReturn(code);
        }
    })
}