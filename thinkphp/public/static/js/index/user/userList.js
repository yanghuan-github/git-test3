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
            roleId: $("#roleId").val(),
            realName: $("#realName").val(),
            status: $("#status").val(),
        };
        return queryParams;
    }

    function layuiForm() {
        layui.use('table', function () {
            var table = layui.table;
            var columns = [[
                {
                    field: 'admin_id',
                    halign: "center",
                    align: "center",
                    title: 'ID',
                },
                {
                    field: 'login_name',
                    halign: "center",
                    align: "center",
                    title: '用户名',
                },
                {
                    field: 'role_name',
                    halign: "center",
                    align: "center",
                    title: '角色组名',
                    templet: function (v) {
                        return roleFun(v.role_name);
                    }
                },
                {
                    field: 'real_name',
                    halign: "center",
                    align: "center",
                    title: '真实姓名',
                },
                {
                    field: 'status',
                    halign: "center",
                    align: "center",
                    title: '状态',
                    templet: function (v) {
                        return statusFun(v.status);
                    }
                },
                {
                    field: 'create_time',
                    halign: "center",
                    align: "center",
                    title: '创建时间',
                    templet: function (v) {
                        return timeFun(v.create_time);
                    }
                },
                {
                    field: 'update_time',
                    halign: "center",
                    align: "center",
                    title: '更新时间',
                    templet: function (v) {
                        return timeFun(v.update_time);
                    }
                },
                {
                    field: 'laston_ip',
                    halign: "center",
                    align: "center",
                    title: '最后登录ip',
                },
                {
                    field: 'laston_time',
                    halign: "center",
                    align: "center",
                    title: '最后登录时间',
                    templet: function (v) {
                        return timeFun(v.laston_time);
                    }
                },
                {
                    field: 'templet',
                    halign: "center",
                    align: "center",
                    title: '操作',
                    templet: function (v) {
                        return `
                                <a href='javascript:;' onclick='edit(`+v.admin_id+`)' class='layui-btn layui-btn-primary layui-btn-sm'>编辑</a>
                                <a href='javascript:;' onclick='dele(`+v.admin_id+`)' class='layui-btn layui-btn-primary layui-btn-sm'>删除</a>
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
 * 角色组名特殊处理
 * @param {*} roleName 
 * @returns 
 */
function roleFun(roleName)
{
    if (roleName) {
        return roleName;
    } else {
        return `<span style='color:red;'>未绑定角色组</span>`;
    }
}

function add() {
    let addUrl = '/index/User/userEdit?id=0';
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
function edit(id) {
    let editUrl = '/index/User/userEdit?id='+id;
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

function dele(id)
{
    layer.confirm('是否要删除所选项?',{
        btn: ['删除', '点错了~']
    }, function(index, layero){
        $.post('/index/User/userDele',{adminId:id},function(code){
            commonDeleReturn(code,index);
        });
    }, function(index){
        layer.close(index);
    });
}