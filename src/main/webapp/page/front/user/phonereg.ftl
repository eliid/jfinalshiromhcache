<#include "/page/front/common/_layout.ftl"/>
<@html title="用户注册 - ${siteTitle!}" description="用户注册" page_tab="reg" sidebar_about="show">
<div class="panel panel-default">
    <div class="panel-heading">
        <ol class="breadcrumb">
            <li><a href="${baseUrl!}/">首页</a></li>
            <li class="active">短信注册</li>
        </ol>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" style="margin-top: 20px;">
            <div class="form-group">
                <label for="email" class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="email" class="form-control" id="reg_phone" placeholder="手机号（必填）"/>
                        <span class="input-group-btn">
                            <button class="btn btn-raised btn-default" type="button" id="send_sms_btn" onclick="sendSMS()">获取短信验证码</button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="valicode" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="valicode" placeholder="验证码(必填)">
                </div>
            </div>
            <div class="form-group">
                <label for="nickname" class="col-sm-2 control-label">昵称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="reg_nickname" placeholder="昵称(必填)">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="reg_password" placeholder="密码(必填)">
                </div>
            </div>

            <div class="form-group">
                <label for="user_type" class="col-sm-2 control-label">用户类型</label>
                <div class="col-sm-8">
                    <select name="user_type" id="user_type">
                        <option value="1">学生</option>
                        <option value="2">教师</option>
                        <option value="3">家长</option>
                        <option value="3">学校</option>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <span id="regMsg"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <a onclick="reg()" id="reg_btn" class="btn btn-raised btn-default">注册</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    function sendSMS() {
        $("#send_sms_btn").attr("disabled", true);
        $.ajax({
            url: "${baseUrl!}/sendSMSValiCode",
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {
                type: 'reg',
                phone: $("#reg_phone").val()
            },
            success: function (data) {
                if (data.code == '200') {
                    $("#send_sms_btn").html("发送成功");
                    $("#reg_phone").attr("disabled", true);
                } else {
                    $("#regMsg").css("color", "red").html(data.description);
                    $("#send_sms_btn").attr("disabled", false);
                }
            }
        });
    }
    function reg() {
        $("#reg_btn").attr("disabled", true);
        $.ajax({
            url: "${baseUrl!}/api/index/phonereg",
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {
                valicode: $("#valicode").val(),
                reg_phone: $("#reg_phone").val(),
                reg_password: $("#reg_password").val(),
                reg_nickname: $("#reg_nickname").val(),
                user_type: $("#user_type").val()
            },
            success: function (data) {
                if (data.code == '200') {
                    location.href="${baseUrl!}/";
                } else {
                    $("#regMsg").css("color", "red").html(data.description);
                    $("#reg_btn").attr("disabled", false);
                }
            }
        });
    }
</script>
</@html>