const $ = layui.jquery;
const form = layui.form;
const table = layui.table;

var pjFunData = [];

$(function(){
    let environId = $('select[name="environId"]').val();
    pjData(environId);
})

form.on('select(environId)', function(data){
    //data.value 得到被选中的值
    pjData(data.value);
});

function pjData(environId) {
    $('#pjId').html("");
    $.ajax({
        url:"/index/PublicTool/pubPjIdName",
        type:'post',
        data: {"environId":environId},
        dataType: "json",
        success:function(result){
            pjFunData = result;
            $.each(result, function(key, val) {
                option = $("<option>").val(key).text(val);
                $("#pjId").append(option);
                form.render('select');
            })
            layuiForm();
        }
    })
}

$('#search').on('click', function () {
    layuiForm();
})
// 构建查询条件
function queryParams(params) {
    var queryParams = {
        environId: $("#environId").val(),
        pjId: $("#pjId").val(),
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
                field: 'environ_id',
                halign: "center",
                align: "center",
                title: '环境',
                templet: function (v) {
                    return environFun(v.environ_id);
                }
            },
            {
                field: 'pj_id',
                halign: "center",
                align: "center",
                title: '项目名称',
                templet: function (v) {
                    return pjFun(v.pj_id);
                }
            },
            {
                field: 'pj_url',
                halign: "center",
                align: "center",
                title: '项目地址',
            },
            {
                field: 'pj_ip',
                halign: "center",
                align: "center",
                title: '项目的IP负载列表',
            },
            {
                field: 'pj_while_ip',
                halign: "center",
                align: "center",
                title: '项目的白名单IP列表',
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

function environFun(environId)
{
    return environTypeJson[environId];
}

function pjFun(pjId)
{
    return pjFunData[pjId];
}

function add() {
    let addUrl = '/index/Config/pjServerEdit?id=0';
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
    let editUrl = '/index/Config/pjServerEdit?id='+id;
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
        $.post('/index/Config/pjServerDele',{id:id},function(code){
            commonDeleReturn(code,index);
        });
    }, function(index){
        layer.close(index);
    });
}