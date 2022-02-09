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
            type: $("#type").val(),
            environId: $("#environId").val(),
            authId: $("#authId").val(),
            dbType: $("#dbType").val(),
            dbHost: $("#dbHost").val(),
            dbName: $("#dbName").val(),
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
                    field: 'type',
                    halign: "center",
                    align: "center",
                    title: 'DB类型ID',
                },
                {
                    field: 'typeName',
                    halign: "center",
                    align: "center",
                    title: '项目名称',
                    templet: function (v) {
                        return typeNameFun(v.type);
                    }
                },
                {
                    field: 'environ_id',
                    halign: "center",
                    align: "center",
                    title: '环境',
                    templet: function (v) {
                        return environFun(v.environ_id);
                    }
                },
                {
                    field: 'db_type',
                    halign: "center",
                    align: "center",
                    title: '数据库类型',
                    templet: function (v) {
                        return dbTypeFun(v.db_type);
                    }
                },
                {
                    field: 'auth_id',
                    halign: "center",
                    align: "center",
                    title: '权限',
                    templet: function (v) {
                        return authFun(v.auth_id);
                    }
                },
                {
                    field: 'db_host',
                    halign: "center",
                    align: "center",
                    title: '主机',
                },
                {
                    field: 'db_port',
                    halign: "center",
                    align: "center",
                    title: '端口',
                },
                {
                    field: 'db_name',
                    halign: "center",
                    align: "center",
                    title: '数据库名',
                },
                {
                    field: 'db_user',
                    halign: "center",
                    align: "center",
                    title: '用户名',
                },
                {
                    field: 'templet',
                    halign: "center",
                    align: "center",
                    title: '操作',
                    templet: function (v) {
                        return `
                                <a href='javascript:;' onclick='edit(`+v.id+`,2)' class='layui-btn layui-btn-primary layui-btn-sm'>复用</a>
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

function typeNameFun(type) {
    return typeJson[type];
}

function environFun(environId) {
    return environTypeJson[environId];
}

function dbTypeFun(dbTypeId) {
    return dbTypeJson[dbTypeId];
}

function authFun(authId) {
    return dbAuthTypeJson[authId];
}


function add() {
    let addUrl = '/index/Config/pjDatabaseEdit?id=0';
    layer.open({
        type: 2, 
        title: msg.add_title,
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
function edit(id,funType = 1) {
    let editUrl = '/index/Config/pjDatabaseEdit?id='+id+'&funType='+funType;
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

function dele(id) {
    layer.confirm('是否要删除所选项?',{
        btn: ['删除', '点错了~']
    }, function(index, layero){
        $.post('/index/Config/pjDatabaseDele',{id:id},function(code){
            commonDeleReturn(code,index);
        });
    }, function(index){
        layer.close(index);
    });
}