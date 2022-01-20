$('#obj tr .event').on('click', function(){
    var id = $($(this).parent('tr')[0]).attr('id');
    // 当前为展开
    if ($($(this).parent('tr')[0]).hasClass('expanded')) {
        $($(this).parent('tr')[0]).removeClass('expanded').addClass('collapsed');
        childHandle(id, 'hide');
    } else {
        // 当前为收缩
        $($(this).parent('tr')[0]).removeClass('collapsed').addClass('expanded');
        childHandle(id, 'show');
    }
});

function childHandle(id, status) {
    var className = 'child-of-'+id;
    $('.'+className).each(function(index, el) {
        if (status == 'hide') {
            $(this).hide();
            if ($(this).hasClass('expanded')) {
                childHandle($(this).attr('id'), 'hide');
            }
        } else {
            $(this).show();
            if ($(this).hasClass('expanded')) {
                childHandle($(this).attr('id'), 'show');
            }
        }
    });
};

$('#search').on('click', function () {
    let pjId = $("#pjId").val();
    let status = $("#status").val();
    window.location.href = '?pjId='+pjId+'&status='+status;
})

function add(nodePid = 0) {
    let addUrl = '/index/Menu/menuAdd?nodePid='+nodePid;
    layer.open({
        type: 2, 
        title: msg.addTitle,
        offset: 'auto',
        area: ['1000px','480px'],
        content: addUrl,
        shadeClose: true,
        btn: [msg.submit, msg.closure]
        ,yes: function(index,layero){
            let iframeDom = window[layero.find('iframe')[0]['name']]; // 获取当前子页面 iframe
            iframeDom.submit();// 执行iframe页面的save方法
        }
        ,btn2: function(index){
            layer.close(index);
        }
    });
}