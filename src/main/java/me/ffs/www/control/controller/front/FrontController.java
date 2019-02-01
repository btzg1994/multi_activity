package me.ffs.www.control.controller.front;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.gserv.serv.commons.util.IpUtil;
import com.github.gserv.serv.commons.util.JsonMapper;

import me.ffs.www.model.Activity;
import me.ffs.www.model.Customer;
import me.ffs.www.service.ActivityService;
import me.ffs.www.service.CustomerService;
import me.ffs.www.service.PublicService;

@Controller
@RequestMapping("front")
public class FrontController {
	
	private static Logger logger = LoggerFactory.getLogger(FrontController.class);
	
	@Resource
	private ActivityService activityService;
	@Resource
	private CustomerService customerService;
	
	/**
	 * 活动主页
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("anony/index/{id}")
	public String index(@PathVariable("id") String id,HttpServletRequest request){
		try {
			if(!StringUtils.isNumeric(id)){
				logger.info("活动id为空！");
				throw new Exception("活动id为空！");
			}	
			int id_ = Integer.parseInt(id);
			
			Activity activity = activityService.findById(id_);
			Date startTime = activity.getStartTime();
			boolean isStarted = PublicService.activityIsStarted(startTime);
			if(!isStarted){//活动未开启
				return "not_start";
			}
			
			
			//正在关注数量加1并更新数据库
			Integer pv = activity.getPv() + 1;
			Activity activity2 = new Activity();
			activity2.setId(activity.getId());
			activity2.setPv(pv);
			activityService.updateOne(activity2);
			
			List<Customer> customers = customerService.findByActivityId(id_);
			int customer_count = 0;
			if(customers != null){
				customer_count = customers.size();
			}
			
			List<HashMap<String, Object>> customer_list = new ArrayList<HashMap<String,Object>>();
			int count = customer_count;
			int i = 0;
			//数据加密处理
			for (Customer customer : customers) {
				i++;
				if(i > 50){
					break;
				}
				String phone = customer.getPhone();
				String name = customer.getName();
				String encryName = name.substring(0,1) + "**";
				String encryphone = phone.substring(0, 3) + "****" + phone.substring(7, 11);
				customer.setPhone(encryphone);
				customer.setName(encryName);
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("customer", customer);
				map.put("number", count);
				count--;
				customer_list.add(map);
			}
			long endTime = activity.getEndTime().getTime();
			request.setAttribute("activity", activity);//活动对象
			request.setAttribute("customer_list", customer_list);//客户信息map
			request.setAttribute("customer_count", customer_count);//客户数量
			request.setAttribute("endTime", endTime);//活动结束时间
			
			String wxShareImgUrl = "";//微信分享图地址
			String wxShareUrl = "";// 微信分享地址
			if(PublicService.devMode){//开发模式
				wxShareImgUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/" +activity.getShareImg(); 
				wxShareUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() +"/front/anony/index/" + activity.getId();
			}else{
				wxShareImgUrl = request.getScheme() + "://" + request.getServerName() + request.getContextPath() +"/" +activity.getShareImg(); 
				wxShareUrl = request.getScheme() + "://" + request.getServerName()  + request.getContextPath() +"/front/anony/index/" + activity.getId();
			}
			request.setAttribute("wxShareImgUrl", wxShareImgUrl);//活动结束时间
			request.setAttribute("wxShareUrl", wxShareUrl);//活动结束时间
			
			
		} catch (Exception e) {
			logger.warn("活动首页异常：",e);
			return "404";
		}
		
		return "front/index";
	}
	
	//	  报名页面
	/*@RequestMapping("anony/signupView/{id}")
	public String signupView(@PathVariable("id") String id,HttpServletRequest request){
		request.setAttribute("id", id);
		return "front/signup";
	}*/
	
	/**
	 * 客户报名
	 * @param id
	 * @param name
	 * @param phone
	 * @return
	 */
	@RequestMapping("anony/signup")
	@ResponseBody
	public String signup(String id,String name,String phone,String county,HttpServletRequest request){
		String remoteIp = IpUtil.getRemoteIp(request);
		logger.info("客户报名:IP[{}],活动id[{}],姓名[{}],电话[{}],县区[{}]",remoteIp,id,name,phone,county);
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			//校验入参
			if(StringUtils.isBlank(id) || StringUtils.isBlank(name) || StringUtils.isBlank(phone) || !StringUtils.isNumeric(id)){
				map.put("rspCode","0");
				map.put("rspMsg","提交的数据格式错误!");
				logger.info("客户报名:提交的数据格式错误!");
				return JsonMapper.toJsonString(map);
			}
			
			String regex = "1\\d{10}";
			boolean matches = Pattern.compile(regex).matcher(phone).matches();
			if(!matches){
				map.put("rspCode","0");
				map.put("rspMsg","提交的数据格式错误!");
				logger.info("客户报名:提交的数据格式错误!");
				return JsonMapper.toJsonString(map);
			}
			
			int id_ = Integer.parseInt(id);
			Activity activity = activityService.findById(id_);
			Date startTime = activity.getStartTime();
			Date endTime = activity.getEndTime();
			/*检测当前活动时间是否合法*/
			boolean isStarted = PublicService.activityIsStarted(startTime);
			boolean isEnded = PublicService.activityIsEnded(endTime);
			if(!isStarted || isEnded){
				//活动未开始或者已经结束
				map.put("rspCode","0");
				map.put("rspMsg","活动已结束！");
				logger.info("客户报名:活动已结束！");
				return JsonMapper.toJsonString(map);
			}
			
			/*添加客户*/
			//添加之前判断同活动是否手机号重复
			Customer find = customerService.findByActivityIdAndPhone(id_, phone);
			if(find != null){
				//已存在
				map.put("rspCode","0");
				map.put("rspMsg","手机号 "+phone+" 已经报名成功，请勿重复提交!");
				logger.info("客户报名:手机号 [{}]重复报名",phone);
				return JsonMapper.toJsonString(map);
			}
			
			Customer customer = new Customer();
			customer.setActivityId(id_);
			customer.setCreateTime(new Date());
			customer.setName(name);
			customer.setPhone(phone);
			customer.setRemark1(county);
			
			Integer res = customerService.addOne(customer);
			if(res == 1){
				map.put("rspCode","1");
				logger.info("客户报名:手机号 [{}]报名成功",phone);
				return JsonMapper.toJsonString(map);
			}else{
				logger.info("客户报名:数据库添加失败");
				throw new Exception();
			}
		} catch (Exception e) {
			logger.warn("客户报名:添加客户异常：",e);
			map.put("rspCode","-1");
			map.put("rspMsg","服务器繁忙!");
			return JsonMapper.toJsonString(map);
		}
	}
	
	//报名成功页面
	/*@RequestMapping("anony/finishView")
	public String signupView(){
		return "front/finish";
	}
	*/
	
}
