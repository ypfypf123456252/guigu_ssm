package com.atguigu.service;

import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 检验用户名是否可用
     * true:代表当前姓名可用
     * false:不可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }
    /**
     * 查询所有员工
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
    /**
     * 员工保存
     */
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }
    /**
     * 按照员工id查询员工
     */
    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
    /**
     * 员工更新
     */
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    /**
     * 员工删除
     */
    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }
    /**
     * 员工批量删除
     */
    public void deleteBatch(List<Integer> ids){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
