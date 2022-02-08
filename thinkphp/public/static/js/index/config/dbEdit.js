function submit(){
    let dbStatus  = $('#dbStatus').val();
    let obj;
    if (dbStatus == 1) {
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
        dbId : $('#dbId').val(),
        type : $('#type').val(),
        dbName : $('#dbName').val(),
        msg : $('#msg').val(),
    }
    obj.url = '/index/Config/dbEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        dbId : $('#dbId').val(),
        type : $('#type').val(),
        dbName : $('#dbName').val(),
        msg : $('#msg').val(),
    }
    obj.url = '/index/Config/dbAddSave';
    return obj;
}