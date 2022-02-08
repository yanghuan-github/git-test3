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
        funType : $('#funType').val(),
        type : $('#type').val(),
        environId : $('#environId').val(),
        dbType : $('#dbType').val(),
        authId : $('#authId').val(),
        dbHost : $('#dbHost').val(),
        dbPort : $('#dbPort').val(),
        dbName : $('#dbName').val(),
        dbUser : $('#dbUser').val(),
        dbPwd : $('#dbPwd').val(),
    }
    obj.url = '/index/Config/pjDatabaseEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        type : $('#type').val(),
        environId : $('#environId').val(),
        dbType : $('#dbType').val(),
        authId : $('#authId').val(),
        dbHost : $('#dbHost').val(),
        dbPort : $('#dbPort').val(),
        dbName : $('#dbName').val(),
        dbUser : $('#dbUser').val(),
        dbPwd : $('#dbPwd').val(),
    }
    obj.url = '/index/Config/pjDatabaseAddSave';
    return obj;
}