// 刷新验证码
function randomCode(){
    let src = document.getElementById("captcha").src;
    document.getElementById("captcha").src = src + "?value=" + Math.random();
}

layui.use('form', function() {
    let form = layui.form;
    let $ = layui.jquery;

    //自定义验证规则
    form.verify({
        required: [
            /\S/
            ,errorListJson['error_not_empty']
        ],
        password: [
            /^[\S]{6,12}$/
            ,errorListJson['error_format']
        ]
    });
    //监听提交
    form.on('submit(button)', function(){
        let data = {
            userName : $('#userName').val(),
            password : hex_md5($('#password').val()),
            vercode : $('#vercode').val(),
        }
        $.ajax({
            type:   'post',
            data:   data,
            url:    '/login/Login/loginCheck',
            dataType: 'json',
            success:function(code){
                switch (code) {
                    case -1:
                    case 5:
                    case 6:
                        msgFun(errorListJson['error']);
                        break;
                    case 1:
                        jumpSuccess(errorListJson['success'],'/index/Index/index',3000)
                        break;
                    case 2:
                        errorCaveat(errorListJson['error_2'],'vercode');
                        break;
                    case 3:
                        errorCaveat(errorListJson['error_3'],'userName');
                        break;
                    case 4:
                        errorCaveat(errorListJson['error_4'],'password');
                        break;
                }
            }
        })
    });
});
