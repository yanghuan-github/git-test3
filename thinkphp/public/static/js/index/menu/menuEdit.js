function submit(){
    let data = $('#form').serialize();
    let nodeId = $('#nodeId').val();
    data += '&nodeId='+nodeId;
    $.ajax({
        type:   'post',
        data:   data,
        url:    '/index/Menu/menuEditSave',
        dataType: 'json',
        success:function(code){
            commonSaveReturn(code);
        }
    })
}