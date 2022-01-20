// 设置输入框边框红色和焦点
function fcous(id)
{
    randomCode();// 刷新验证码
    let idObj = $('#'+id);
    idObj.focus();// 获取焦点
    idObj.addClass('layui-form-danger layui-form-danger:focus');
}

function msgFun(msg)
{
    layer.msg(msg);
}

function errorCaveat(msg,obj)
{
    layer.tips(msg,'#'+obj);
    fcous(obj);
}

function jumpSuccess(msg,url,time)
{
    layer.msg(msg);
    setTimeout(()=>{
        window.location.href = url;
    },time)
}

$('.obj-btu i').on("mouseover",function(){
    $('.obj-btu i').css('color','#1c84c6');
});
$('.obj-btu i').on("mouseout",function(){
    $('.obj-btu i').css('color','');
});


/**
 * 时间公共处理函数
 * @param {*} time 
 */
function timeFun(time)
{
    if (time) {
        let now = new Date(time*1000);
        return now.getFullYear()+"-" + (now.getMonth()+1) + "-" + (now.getDate()) + " " + (now.getHours()) + ":" + (now.getMinutes()) + ":" + (now.getSeconds());
    } else {
        return '-';
    }
}


/**
 * 状态类型
 * @param {*} status 状态
 * @returns 
 */
function statusFun(status)
{
    switch (status) {
        case 1:
            return statusViewJson[status];
        break;
        case 2:
            return `<span style='color:red;'>`+statusViewJson[status]+`</span>`;
        break;
        case 3:
            return `<span style='color:green;'>`+statusViewJson[status]+`</span>`;
        break;
        default:
            return '-';
        break;
    }
}