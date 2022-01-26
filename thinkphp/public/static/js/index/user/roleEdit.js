function submit(){
    let roleId  = $('#roleId').val();
    let obj;
    if (roleId == 0) {
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
        roleId : $('#roleId').val(),
        roleName : $('#roleName').val(),
        rolePid : $('#rolePid').val(),
        status : $('#status').val(),
    }
    obj.url = '/index/User/roleEditSave';
    return obj;
}

/**
 * 拼装用户新增数据
 * @returns 
 */
function addData(){
    obj.data = {
        roleName : $('#roleName').val(),
        rolePid : $('#rolePid').val(),
        status : $('#status').val(),
    }
    obj.url = '/index/User/roleAddSave';
    return obj;
}