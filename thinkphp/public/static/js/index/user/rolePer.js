
let tree = layui.tree;
//开启复选框
tree.render({
    elem : '#perTree'
    ,data : menuList
    ,showCheckbox : true
    ,id : 'id' //定义索引
});
tree.setChecked('id',roleMenu); 

function submit(){
    //获得选中的节点
    let checkData = tree.getChecked('id');
    let data = {
        data : checkData[0],
        roleId : $('#roleId').val()
    }
    $.ajax({
        type:   'post',
        data:   data,
        url:    '/index/User/rolePerSave',
        dataType: 'json',
        success:function(code){
            commonSaveReturn(code);
        }
    })
}