$(function () {
    window.yns.validations = {};
    window.yns.validations.managerAccountValidation = function (account) {
        account = $.trim(account);
        if (account.length == 0) {
            return { success: false, message: "请输入帐号" };
        } else if (!account.length >= 6 && account.length <= 18) {
            return { success: false, message: "帐号是6~18位的字符" };
        } else if (!/^[\w]+$/.test(account)) {
            return { success: false, message: "帐号是字母、数字或下划线" };
        } else {
            return { success: true };
        }
    }
});
