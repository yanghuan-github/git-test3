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
        name : $('#name').val(),
        value : $('#value').val(),
        msg : $('#msg').val(),
        status : $('#status').val(),
    }
    obj.url = '/index/Config/paramEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        name : $('#name').val(),
        value : $('#value').val(),
        msg : $('#msg').val(),
        status : $('#status').val(),
    }
    obj.url = '/index/Config/paramAddSave';
    return obj;
}