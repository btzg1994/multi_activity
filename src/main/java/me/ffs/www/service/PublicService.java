package me.ffs.www.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PublicService {
	/**
	 * 后台登陆用户
	 */
	public static final String BACK_ADMIN_SESSION = "BACK_ADMIN_SESSION";
	
	/**
	 * 后台首页
	 */
	public static final String BACK_INDEX = "back/anony/index";
	
	/**
	 * 时间格式
	 */
	public static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss"; 
	/**
	 * 来访ip池
	 */
	public static final String IP_MAP_SERVLET_CONTEXT = "IP_MAP_SERVLET_CONTEXT"; 
	/**
	 * 本地资源路径
	 */
	public static String basePath;
	
	/**
	 * 是否为开发模式
	 */
	public static boolean devMode;
	
	/**
	 * 管理员账号
	 */
	public static String adminName;
	
	/**
	 * 管理员密码
	 */
	public static String adminPwd;
	/**
	 * 明细展示天数
	 */
	public static Integer statisticsDays; 

	@Value("${dev_mode}")
	public void setDevMode(String devMode) {
		if("true".equals(devMode)){
			PublicService.devMode = true;
		}else{
			PublicService.devMode = false;
		}
	}
	
	@Value("${admin_name}")
	public  void setAdminName(String adminName) {
		PublicService.adminName = adminName;
	}
	
	@Value("${admin_pwd}")
	public void setAdminPwd(String adminPwd) {
		PublicService.adminPwd = adminPwd;
	}

	@Value("${local_basepath}")
	public void setBasePath(String basePath) {
		PublicService.basePath = basePath;
	}

	@Value("${statistics_days}")
	public  void setStatisticsDays(Integer statisticsDays) {
		PublicService.statisticsDays = statisticsDays;
	}
	
	/**
	 * 检查活动是否开启
	 * @param startTime
	 * @return
	 */
	public static boolean activityIsStarted(Date startTime){
		Date now = new Date();
		if(startTime.before(now)){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 检查活动是否结束
	 * @param startTime
	 * @return
	 */
	public static boolean activityIsEnded(Date endTime){
		Date now = new Date();
		if(endTime.before(now)){
			return true;
		}else{
			return false;
		}
	}
	
	
	
}
