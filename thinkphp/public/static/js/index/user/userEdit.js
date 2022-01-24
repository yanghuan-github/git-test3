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
        adminId : $('#id').val(),
        realName : $('#realName').val(),
        status : $('#status').val(),
    }
    obj.url = '/index/User/userEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        realName : $('#realName').val(),
        loginName : $('#loginName').val(),
        password : hex_md5($('#password').val()),
        confirmPwd : hex_md5($('#confirmPwd').val()),
        status : $('#status').val(),
    }
    obj.url = '/index/User/userAddSave';
    return obj;
}