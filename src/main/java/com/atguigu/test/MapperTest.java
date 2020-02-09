package com.atguigu.test;

import com.atguigu.bean.Department;
import com.atguigu.bean.Employee;
import com.atguigu.dao.DepartmentMapper;
import com.atguigu.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层
 * 推荐spring的项目使用spring的单元测试,可以自动的注入我们需要的组件
 * 1.导入springtest模块
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext01.xml"})
public class MapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    //批量的SQLSession
    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testCRUD(){
        //创建IOC容器,从容器中获取mapper:用不了
        /*ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext01.xml");
        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);*/

//        1.插入两个部门
        System.out.println(departmentMapper);
        departmentMapper.insertSelective(new Department(null,"项目部"));
        departmentMapper.insertSelective(new Department(null,"市场部"));
        //2.插入一个员工
//        employeeMapper.insertSelective(new Employee(null,"jerry","M","jerry@atguigu.com",1));
        //3.批量插入多个员工:使用可以执行批量操作的SQLSession.
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        System.out.println(mapper);
//        for (int i=0;i<1000;i++){
//            String username="ypf"+i;
//            if (i%2==0){
//                mapper.insertSelective(new Employee(null,username,"M",username+"@atguigu.com",1));
//            }else {
//                mapper.insertSelective(new Employee(null,username,"W",username+"@atguigu.com",2));
//            }
//        }
    }
}
