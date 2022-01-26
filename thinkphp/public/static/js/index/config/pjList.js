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
            pjId: $("#pjId").val(),
            environId: $("#environId").val(),
            isView: $("#isView").val(),
            pjLogo: $("#pjLogo").val(),
            pjName: $("#pjName").val(),
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
                    field: 'pj_id',
                    halign: "center",
                    align: "center",
                    title: '项目ID',
                },
                {
                    field: 'environ_id',
                    halign: "center",
                    align: "center",
                    title: '环境ID',
                    templet: function (v) {
                        return environFun(v.environ_id);
                    }
                },
                {
                    field: 'pj_logo',
                    halign: "center",
                    align: "center",
                    title: '项目标志',
                },
                {
                    field: 'pj_name',
                    halign: "center",
                    align: "center",
                    title: '项目名称',
                },
                {
                    field: 'is_view',
                    halign: "center",
                    align: "center",
                    title: '管理界面',
                    templet: function (v) {
                        return isViewFun(v.is_view);
                    }
                },
                {
                    field: 'templet',
                    halign: "center",
                    align: "center",
                    title: '操作',
                    templet: function (v) {
                        return `
                                <a href='javascript:;' onclick='edit(`+v.id+`)' class='layui-btn layui-btn-primary layui-btn-sm'>编辑</a>
                                <a href='javascript:;' onclick='dele(`+v.id+`)' class='layui-btn layui-btn-primary layui-btn-sm'>删除</a>
                                `;
                    }
                }
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

/**
 * 管理界面参数处理方法
 * @param {*} isView 
 */
function isViewFun(isView)
{
    if (isView == 1) {
        return `<span style='color:red'>√</span>`;
    } else {
        return `<span style='color:green'>x</span>`;
    }
}

function environFun(environId)
{
    return environViewJson[environId];
}

function add() {
    let addUrl = '/index/Config/pjEdit?id=0';
    layer.open({
        type: 2, 
        title: msg.addTitle,
        offset: 'auto',
        area: ['800px','390px'],
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
function edit(id) {
    let editUrl = '/index/Config/pjEdit?id='+id;
    layer.open({
        type: 2, 
        title: msg.editTitle,
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

function dele(id) {
    layer.confirm('是否要删除所选项?',{
        btn: ['删除', '点错了~']
    }, function(index, layero){
        $.post('/index/Config/pjDele',{id:id},function(code){
            commonDeleReturn(code,index);
        });
    }, function(index){
        layer.close(index);
    });
}