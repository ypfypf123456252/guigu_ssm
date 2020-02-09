<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <title>员工列表</title>
    <script src="static/jquery-3.4.1.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="xxx@atgui.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="email" name="email" class="form-control" id="email_add_input" placeholder="xxx@atgui.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <%--部门提交部门id即可--%>
                                <select class="form-control" name="dId" id="dept_add_select">
                                </select>
                            </div>
                        </div>

                    </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="clo-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="clo-md-6 col-md-offset-6" id="page_nav_area">

        </div>
    </div>
</div>
<%--1.页面加载完成后,直接去发送ajax请求,要到分页数据--%>
    <script type="text/javascript">
        var totalRecord,currentPage;
        $(function () {
            //去首页
            to_page(1);
        });
        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps2",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    //解析并显示员工信息
                    build_emps_table(result);
                    //解析并显示分页信息
                    build_page_info(result);
                    //解析并显示分页条数据
                    build_page_nav(result);
                }
            });
        }
        //解析并显示员工信息
        function build_emps_table(result) {
            //清空table表格
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                /**
                 *  <button class="btn btn-primary btn-sm">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                        编辑
                    </button>
                 */
                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性,来表示员工id
                editBtn.attr("edit-id",item.empId);
                /**
                 *  <button class="btn btn-danger btn-sm">
                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        删除
                    </button>
                 */
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的id
                delBtn.attr("del-id",item.empId);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);

                //append方法执行完成以后还是原来的元素
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btnTd)
                    .appendTo("#emps_table tbody");

            });
        }
        //解析并显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页," +
                "共"+result.extend.pageInfo.pages+"页,共"+result.extend.pageInfo.total+"条记录");
            //总记录页数
            totalRecord=result.extend.pageInfo.total;
            //本页面
            currentPage=result.extend.pageInfo.pageNum;
        }
        //解析并显示分页条数据
        function build_page_nav(result){
            $("#page_nav_area").empty();
            //page_nav_area
            var ul=$("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled")
            }else {
                //为元素添加点击翻页的事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                });
            }
            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if (result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //添加首页和前一页的提示
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }
            ul.append(firstPageLi).append(prePageLi);
                //1,2,3,4,5遍历给ul中添加页码的提示
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi=$("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum==item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //重置表单,清空表单样式及内容
        function reset_form(ele){
            //清空表单数据
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        //点击新增按钮,弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //清除表单数据(表单重置)
            // $("#empAddModal form")[0].reset();
            reset_form("#empAddModal form");
            //发送ajax请求,查出部门信息,显示在下拉列表中
            getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });
        //查出部门信息,显示在下拉列表中
        function getDepts(ele) {
            //清空之前的下拉列表的值
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    //Object { code: 100, msg: "处理成功", extend: {…} }
                    $.each(result.extend.depts,function () {
                        var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                        //显示部门信息在下拉列表中
                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        //校验表单数据
        function validate_add_form(){
            //1,拿到要校验的数据,使用正则表达式
            var empName=$("#empName_add_input").val();
            var regName=/^[a-z0-9_-]{3,16}$/;
            if(!regName.test(empName)){
                // alert("用户名可以是3~16位的字母或数字的组合");
                // $("#empName_add_input").parent().addClass("has-error");
                // $("#empName_add_input").next("span").text("用户名可以是6~16位的字母或数字的组合");
                show_validate_msg("#empName_add_input","error","用户名可以是3~16位的字母或数字的组合");
                return false;
            }else {
                // $("#empName_add_input").parent().addClass("has-success");
                // $("#empName_add_input").next("span").text("");
                show_validate_msg("#empName_add_input","success","");
            }

            //校验邮箱信息
            var email=$("#email_add_input").val();
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式不正确");
                // $("#email_add_input").parent().addClass("has-error");
                // $("#email_add_input").next("span").text("邮箱格式不正确");
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else {
                // $("#email_add_input").parent().addClass("has-success");
                // $("#email_add_input").next("span").text("");
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }
        //显示校验结果的提示信息
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");
            if ("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            } else if ("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }
        //ajax检验用户名是否可用
        $("#empName_add_input").change(function () {
            var empName=this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            })
        });
        //点击保存,保存员工
        $("#emp_save_btn").click(function () {
            //1.模态框中填写的表单数据提交给服务器进行保存
            //1.先对要提交给服务器的数据进行校验
            if (!validate_add_form()){
                return false;
            }
            //1.判断之前的ajax用户名校验是否成功
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }

            //2.发ajax请求保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    // alert(result.msg);
                    //员工保存成功;
                    if (result.code==100){
                        //1.关闭模态框
                        $("#empAddModal").modal('hide');
                        //2.来到最后一页,显示刚才保存的数据
                        //发送ajax请求显示最后一页数据即可
                        to_page(totalRecord);
                    }else {
                        //显示错误信息
                        //有那个字段的错误信息,就显示哪个字段的
                        if (undefined != result.extend.errorFields.email){
                            //显示邮箱的错误信息
                            show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                        }
                        if (undefined != result.extend.errorFields.empName){
                            //显示员工名字的错误信息
                            show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        }
                    }
                }
            });
        });

        $(document).on("click",".edit_btn",function () {
            //1.查出部门信息,并显示部门列表
            getDepts("#empUpdateModal select");
            //2.查处员工信息,显示员工信息
            getEmp($(this).attr("edit-id"));
            //3.把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    console.log(result);
                    var empDate=result.extend.emp;
                    $("#empName_update_static").text(empDate.empName);
                    $("#email_update_input").val(empDate.email);
                    $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                    $("#empUpdateModal select").val([empDate.dId]);
                }
            });
        }
        //点击更新,更新员工信息
        $("#emp_update_btn").click(function () {
            //1.邮箱验证
            var email=$("#email_update_input").val();
            var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }
            //2.发送ajax请求保存跟新的员工数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                // type:"POST",
                // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    // alert(result);
                    //1.关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //回到本页
                    to_page(currentPage);
                }
            })
        });
        //单个删除
        $(document).on("click",".delete_btn",function () {
            //1.弹出是否确认删除对话框
            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del-id");
            // alert($(this).parents("tr").find("td:eq(2)").text());
            if (confirm("确认删除["+empName+"]吗?")){
                //确认,发送ajax请求删除即可
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        });
        //完成全选/全不选功能
        $("#check_all").click(function () {
            //attr获取checked是undefined
            //我们这些原生的属性:attr获取不到,attr获取自定义的属性值
            //prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });
        //check_item
        $(document).on("click",".check_item",function () {
            var flag=$(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        //点击全部删除,就批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                // alert($(this).parents("tr").find("td:eq(2)").text());
                //组装员工名字的字符串
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id的字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除多余的,-
            empNames=empNames.substring(0,empNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if (confirm("确认删除["+empNames+"]吗?")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                })
            }
        });
    </script>
</body>
</html>