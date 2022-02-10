const $ = layui.jquery;
const form = layui.form;
const table = layui.table;
layui.use(['form', 'table'], function () {
    $(function () {
        layuiForm();
    })

    $('#search').on('click', function () {
        layuiForm();
    })
    // 构建查询条件
    function queryParams(params) {
        var queryParams = {
            adminName: $("#adminName").val(),
            start: $("#start").val(),
            end: $("#end").val(),
        };
        return queryParams;
    }

    function layuiForm() {
        layui.use('table', function () {
            var table = layui.table;
            var columns = [[
                {
                    field: 'id',
                    halign: "center",
                    align: "center",
                    title: 'ID',
                },
                {
                    field: 'method',
                    halign: "center",
                    align: "center",
                    title: '操作路径',
                },
                {
                    field: 'data',
                    halign: "center",
                    align: "center",
                    title: '数据详情',
                    templet: function (v) {
                        return  `
                                <a href='javascript:;' onclick='check(`+v.id+`)' class='layui-btn layui-btn-primary layui-btn-sm'>点击查看</a>
                                `;
                    }
                },
                {
                    field: 'create_time',
                    halign: "center",
                    align: "center",
                    title: '操作时间',
                    templet: function (v) {
                        return timeFun(v.create_time);
                    }
                },
            ]]
            table.render({
                elem: '#table',
                page: true,//开启分页
                limit: 20,
                toolbar: false, //开启工具栏
                defaultToolbar: ['filter',], //自定义工具栏，列筛选
                even: false, //开启隔行背景
                cols: columns,
                size: 'lg',
                cellMinWidth: 100,
                url: requestUrl,
                method: 'post',
                where: queryParams(),
                parseData: function (res) { //res 即为原始返回的数据
                    return res;
                },
                done: function (res, curr, count) {
                    //改变工具栏背景
                    $('.layui-table-tool').css({ 'background-color': '#fff' });
                    //表头字体加粗
                    $('thead tr th').css({ 'font-weight': 'bold' });
                }
            })
        })
    }
})

function check(id) {
    let editUrl = '/index/DevTool/checkUserOperation?id='+id;
    layer.open({
        type: 2, 
        title: msg.edit_title,
        offset: 'auto',
        area: ['800px','390px'],
        content: editUrl,
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
