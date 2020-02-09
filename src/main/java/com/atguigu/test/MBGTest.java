package com.atguigu.test;

import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.dao.EmployeeMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class MBGTest {
    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }

    @Test
    public void test() throws Exception{
        String resource="mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);

            //封装查询条件的example
            EmployeeExample example = new EmployeeExample();
            //创建一个Criteria,这个Criteria就是拼装查询条件
            EmployeeExample.Criteria criteria = example.createCriteria();
            criteria.andEmpNameLike("%e%");
            criteria.andGenderEqualTo("1");

            EmployeeExample.Criteria criteria1 = example.createCriteria();
            criteria1.andEmailLike("%e%");

            example.or(criteria1);

            List<Employee> employees = mapper.selectByExample(example);
            for (Employee employee:employees){
                System.out.println(employee);
            }
        }finally {

        }
    }
}
