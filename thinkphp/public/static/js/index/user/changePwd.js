function submit(){
    let data = {
        adminId     : $('#adminId').val(),
        oldPwd      : hex_md5($('#oldPwd').val()),
        password    : $('#password').val(),
        confirmPwd  : $('#confirmPwd').val(),
    }
    let pwdRule = /^[\S]{6,12}$/;
    if (!(pwdRule.test(data.password))) {
        msgFun(msg['error_format']);
        return false;
    }
    if (!(pwdRule.test(data.confirmPwd))) {
        msgFun(msg['error_format']);
        return false;
    }
    data.password = hex_md5(data.password);
    data.confirmPwd = hex_md5(data.confirmPwd);
    $.ajax({
        type:   'post',
        data:   data,
        url:    '/index/User/changePwdSave',
        dataType: 'json',
        success:function(code){
            if (code == 1) {
                msgFun(msg['success_'+code]);
            } else {
                msgFun(msg['error_'+code])
            }
            parent.window.location.href = '/index/Index/loginOut';
        }
    })

}
