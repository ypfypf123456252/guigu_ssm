package com.atguigu.controller;

import com.atguigu.bean.Employee;
import com.atguigu.bean.Msg;
import com.atguigu.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量删除1-2-3
     * 单个删除1
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        //批量删除
        if (ids.contains("-")){
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        //单个删除
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 员工更新方法
     * ajax直接发送PUT请求,在map中拿不到
     * Tomcat一般PUT请求不会被封装为一个map,只有POST形式的请求才可以
     * 解决办法:
     *  1.  web.xml文件配置HttpPutFormContentFilter;
     *  2.作用在于,可以把请求体中的数据封装为一个map
     *  3.request被重新包装,request.getparameter()被重写,就会从自己的map中取数据
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println("将要跟新的员工数据:"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }
    /**
     * 检查用户名是否可用
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        String regx="(^[a-z0-9_-]{3,16}$)";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","__用户名必须是3~16位的字母或数字的组合");
        }
        //数据库校验
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
    /**
     * 员工保存
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败,应该返回失败,在模态框中显示校验失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors){
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    @ResponseBody
    @RequestMapping("/emps2")
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括我们查询出来的数据,传入连续显示的页数
        PageInfo pageInfo=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    /**
     * 查询员工数据()分页查询
     */
    @RequestMapping("/emps1")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括我们查询出来的数据,传入连续显示的页数
        PageInfo pageInfo=new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
