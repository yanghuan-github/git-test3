const $ = layui.jquery;
const form = layui.form;
const table = layui.table;

$(function(){
    let environId = $('select[name="environId"]').val();
    pjData(environId);
})

form.on('select(environId)', function(data){
    //data.value 得到被选中的值
    pjData(data.value);
});

function pjData(environId) {
    $('#pjId').html("");
    $.ajax({
        url:"/index/PublicTool/pubPjIdName",
        type:'post',
        data: {"environId":environId},
        dataType: "json",
        success:function(result){
            $("#pjId").append($("<option>").val('-1').text('全部'));
            $.each(result, function(key, val) {
                if (key == pjSelect) {
                    option = `<option value=`+key+` selected>`+val+`</option>`;
                } else {
                    option = $("<option>").val(key).text(val);
                }
                $("#pjId").append(option);
            })
            form.render('select');
        }
    })
}


function submit(){
    let id  = $('#id').val();
    let obj;
    if (id == 0) {
        obj = addData();
    } else {
        obj = editData();
    }
    if (typeof(obj)=="undefined" || !obj) {
        return;
    }
    $.ajax({
        type:   'post',
        data:   obj.data,
        url:    obj.url,
        dataType: 'json',
        success:function(code){
            commonSaveReturn(code);
        }
    })
}

/**
 * 拼装用户编辑数据
 * @returns 
 */
function editData(){
    obj.data = {
        id : $('#id').val(),
        environId : $('#environId').val(),
        pjId : $('#pjId').val(),
        pjUrl : $('#pjUrl').val(),
        pjIp : $('#pjIp').val(),
        pjWhileIp : $('#pjWhileIp').val(),
    }
    obj.url = '/index/Config/pjServerEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        environId : $('#environId').val(),
        pjId : $('#pjId').val(),
        pjUrl : $('#pjUrl').val(),
        pjIp : $('#pjIp').val(),
        pjWhileIp : $('#pjWhileIp').val(),
    }
    obj.url = '/index/Config/pjServerAddSave';
    return obj;
}