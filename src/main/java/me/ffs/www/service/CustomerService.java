package me.ffs.www.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import me.ffs.www.dao.mapper.CustomerMapper;
import me.ffs.www.model.Customer;
import tk.mybatis.mapper.entity.Example;

@Service
public class CustomerService {

	@Resource
	private CustomerMapper customerMapper;

	/**
	 * 根据日期范围和活动id查询订购用户
	 * @param startDate
	 * @param endDate
	 * @param aid
	 * @return
	 */
	public List<Customer> findByDateRangeAndActivityId(String startDate,String endDate ,Integer aid){
		if(StringUtils.isBlank(startDate)|| StringUtils.isBlank(endDate)){
			return null;
		}
		Example example = new Example(Customer.class);
		example.createCriteria().andCondition("create_time >= '" + startDate+"'").andCondition("create_time <= '" + endDate +"'").andEqualTo("activityId",aid);
		return customerMapper.selectByExample(example);
	}
	
	/**
	 * 根据活动id查询客户列表 ,根据id降序排列
	 * @param aid
	 * @return
	 */
	public List<Customer> findByActivityId(Integer aid){
		Example example = new Example(Customer.class);
		example.createCriteria().andEqualTo("activityId",aid);
		example.setOrderByClause("id desc");
		return customerMapper.selectByExample(example);
	}
	
	/**
	 * 添加客户
	 * @param customer
	 * @return
	 */
	public Integer addOne(Customer customer){		
		return customerMapper.insertSelective(customer);
	}
	
	/**
	 * 根据活动id和手机号查询客户
	 * @param aid
	 * @param phone
	 * @return
	 */
	public Customer findByActivityIdAndPhone(Integer aid,String phone){
		Example example = new Example(Customer.class);
		example.createCriteria().andEqualTo("activityId", aid).andEqualTo("phone", phone);
		List<Customer> list = customerMapper.selectByExample(example);
		if(list !=null && list.size() > 0){
			return list.get(0);
		}else{
			return null;
		}
	}
}
