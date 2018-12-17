package me.ffs.www.control.controller.back;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.gserv.serv.commons.util.DateUtils;
import com.github.gserv.serv.commons.util.IpUtil;
import com.github.pagehelper.PageInfo;

import me.ffs.www.model.Activity;
import me.ffs.www.model.Customer;
import me.ffs.www.service.ActivityService;
import me.ffs.www.service.CustomerService;
import me.ffs.www.service.PublicService;
import util.FileUtil;

@Controller
@RequestMapping("back")
public class BackController {

	private static final Logger logger = LoggerFactory.getLogger(BackController.class);

	@Resource
	private ActivityService activityService;
	@Resource
	private CustomerService customerService;

	// --------------anony module start----------------

	/**
	 * 后台登陆页面
	 * 
	 * @return
	 */
	@RequestMapping("anony/index")
	public String index() {
		return "back/login";
	}

	/**
	 * 后台登陆
	 * 
	 * @param request
	 * @param loginName
	 * @param loginPwd
	 * @param checkcode
	 * @return
	 */
	@RequestMapping("anony/login")
	public String login(HttpServletRequest request, String loginName, String loginPwd, String checkcode) {
		HttpSession session = request.getSession();
		String remoteIp = IpUtil.getRemoteIp(request);
		// 校验验证码
		String key = (String) session.getAttribute("backend_key");
		if (StringUtils.isBlank(checkcode) || !checkcode.equalsIgnoreCase(key)) {
			request.setAttribute("back_errMsg", "您输入的验证码有误！");
			return "back/login";
		}

		// 校验其余入参
		if (StringUtils.isBlank(loginName) || StringUtils.isBlank(loginPwd)) {
			request.setAttribute("back_errMsg", "用户名或密码格式不正确！");
			return "back/login";
		}

		// 校验用户名密码
		String adminName = PublicService.adminName;
		String adminPwd = PublicService.adminPwd;
		if (adminName.equals(loginName) && adminPwd.equals(loginPwd)) {
			// 存入session
			session.setAttribute(PublicService.BACK_ADMIN_SESSION, adminName);
			logger.info("[{}]后台登陆成功！", remoteIp);
			return "redirect:/back/activity/findActivities/1/10";
		} else {
			request.setAttribute("back_errMsg", "用户名或密码错误！");
			return "back/login";
		}

	}
	// --------------anony module end----------------

	// ------------------activity module start--------------------------------

	/**
	 * 分页查询活动
	 * 
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @return
	 */
	@RequestMapping("activity/findActivities/{pageNum}/{pageSize}")
	public String findActivities(@PathVariable(value = "pageNum", required = false) Integer pageNum,
			@PathVariable(value = "pageSize", required = false) Integer pageSize, HttpServletRequest request) {
		try {
			if (pageNum == null || pageNum < 1) {
				pageNum = 1;
			}
			if (pageSize == null || pageSize < 1) {
				pageSize = 10;
			}
			PageInfo<Activity> info = activityService.getActivityByPage(pageNum, pageSize);
			request.setAttribute("pageInfo", info);
		} catch (Exception e) {
			logger.warn("分页查询活动信息异常：", e);
		}
		return "back/activity";
	}

	/**
	 * 添加活动视图
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("activity/addActivityView")
	public String addActivityView(HttpServletRequest request) {
		return "back/activity_add";
	}

	/**
	 * 添加活动
	 * 
	 * @param request
	 * @param banner
	 * @return
	 */
	@RequestMapping("activity/addActivity")
	@ResponseBody
	public Map<String, Object> addActivity(HttpServletRequest request, @RequestParam("banner") MultipartFile banner,
			@RequestParam("music") MultipartFile music, @RequestParam("shareImg") MultipartFile shareImg,@RequestParam("img2") MultipartFile img2) {
		HashMap<String, Object> rspMap = new HashMap<String, Object>();
		try {
			String name = request.getParameter("name") != null ? request.getParameter("name") : "";
			String startTime = request.getParameter("startTime") != null ? request.getParameter("startTime") : "";
			String endTime = request.getParameter("endTime") != null ? request.getParameter("endTime") : "";
			String remark = request.getParameter("remark") != null ? request.getParameter("remark") : "";

			String bgColor = request.getParameter("bgColor") != null ? request.getParameter("bgColor") : "";
			String btnColor = request.getParameter("btnColor") != null ? request.getParameter("btnColor") : "";
			String btnTextColor = request.getParameter("btnTextColor") != null ? request.getParameter("btnTextColor")
					: "";

			String shareText = request.getParameter("shareText") != null ? request.getParameter("shareText") : "";
			String baseNumber = request.getParameter("baseNumber") != null ? request.getParameter("baseNumber") : "";
			String pvBaseNumber = request.getParameter("pvBaseNumber") != null ? request.getParameter("pvBaseNumber")
					: "";

			String img2Href = request.getParameter("img2Href") != null ? request.getParameter("img2Href") : "";

			// 校验参数
			if (StringUtils.isBlank(name) || StringUtils.isBlank(startTime) || StringUtils.isBlank(endTime)) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "提交的参数有误！");
				logger.info("提交的参数name[{}],startTime[{}],endTime[{}]有误！",name,startTime,endTime);
				return rspMap;
			}
			if (banner.isEmpty() || !FileUtil.isImage(banner)) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "上传的图片格式错误！");
				logger.info("上传的图片格式错误！");
				return rspMap;
			}

			if (music.isEmpty() || !FileUtil.isAudio(music)) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "上传的音乐格式错误！");
				logger.info("上传的音乐格式错误！");
				return rspMap;
			}

			if (shareImg.isEmpty() || !FileUtil.isImage(shareImg)) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "上传的图片格式错误！");
				logger.info("上传的图片格式错误！");
				return rspMap;
			}

			if (!StringUtils.isNumeric(baseNumber) || Integer.parseInt(baseNumber) < 0) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "报名基数必须是大于等于0的整数！");
				logger.info("报名基数必须是大于等于0的整数！");
				return rspMap;
			}

			if (!StringUtils.isNumeric(pvBaseNumber) || Integer.parseInt(pvBaseNumber) < 0) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "关注人数基数必须是大于等于0的整数！");
				logger.info("关注人数基数必须是大于等于0的整数！");
				return rspMap;
			}

			String regex = "[0-9a-f]{6}";
			Pattern colorPattern = Pattern.compile(regex);
			if (!colorPattern.matcher(bgColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "背景色值格式有误！");
				logger.info("背景色值[{}]格式有误！",bgColor);
				return rspMap;
			}

			if (!colorPattern.matcher(btnColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "按钮色值格式有误！");
				logger.info("按钮色值[{}]格式有误！",btnColor);
				return rspMap;
			}

			if (!colorPattern.matcher(btnTextColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "按钮内文字色值格式有误！");
				logger.info("钮内文字色值[{}]格式有误！",bgColor);
				return rspMap;
			}
			
			if (!img2.isEmpty()) {// 文件不为空
				if (!FileUtil.isImage(img2)) {// 文件类型错误
					rspMap.put("rspCode", "0");
					rspMap.put("rspMsg", "上传的图片2格式错误！");
					logger.info("上传的图片2格式有误！",bgColor);
					return rspMap;
				}
			}

			String pattern = PublicService.DATETIME_PATTERN;

			Date startDate = DateUtils.parseDate(startTime, pattern);
			Date endDate = DateUtils.parseDate(endTime, pattern);

			if ((startDate.getTime() - endDate.getTime()) > 0) {
				// 开始时间大于了结束时间
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "活动开始时间不能大于活动结束时间！");
				logger.info("活动开始时间[{}]不能大于活动结束时间[{}]！",startTime,endTime);
				return rspMap;
			}

			// 添加活动
			Activity activity = new Activity();
			activity.setName(name);
			activity.setStartTime(startDate);
			activity.setEndTime(endDate);
			activity.setCreateTime(new Date());
			activity.setRemark(remark);
			activity.setBgColor(bgColor);
			activity.setBtnColor(btnColor);
			activity.setBtnTextColor(btnTextColor);
			activity.setPv(1);
			activity.setShareText(shareText);
			activity.setBaseNumber(Integer.parseInt(baseNumber));
			activity.setPvBaseNumber(Integer.parseInt(pvBaseNumber));
			activity.setImg2Href(img2Href);
			Integer res = activityService.addOne(activity);

			if (res != 1) {
				throw new Exception();
			}
			Integer id = activity.getId();

			String basePath = PublicService.basePath;
			// 存储banner图片
			String path_banner = "images/" + id;
			String dirPath = basePath + path_banner;
			String bannerFileName = FileUtil.storeFile(basePath, dirPath, banner, id);

			// 存储音乐
			String path_music = "audio/" + id;
			String audioDirPath = basePath + path_music;
			String musicFileName = FileUtil.storeFile(basePath, audioDirPath, music, id);

			// 存储微信分享图片
			String path_share_img = "share_img/" + id;
			String shareImgDirPath = basePath + path_share_img;
			String shareImgFileName = FileUtil.storeFile(basePath, shareImgDirPath, shareImg, id);
			
			// 图片和音乐上传成功后，存储路径到数据库
			Activity activity2 = new Activity();
			activity2.setId(id);
			activity2.setBannerUrl(path_banner + "/" + bannerFileName);
			activity2.setMusicUrl(path_music + "/" + musicFileName);
			activity2.setShareImg(path_share_img + "/" + shareImgFileName);
			// 存储图片2
			if (!img2.isEmpty()) {// 文件不为空
				String path_img2 = "img2/" + id;
				String img2DirPath = basePath + path_img2;
				String img2FileName = FileUtil.storeFile(basePath, img2DirPath, img2, id);
				activity2.setImg2(path_img2 + "/" + img2FileName);
			}

			
			Integer res2 = activityService.updateOne(activity2);
			if (res2 != 1) {
				throw new Exception();
			}

			rspMap.put("rspCode", "1");
			rspMap.put("rspMsg", "添加成功！");
			logger.info("活动[{}]添加成功！",name);
			return rspMap;
		} catch (Exception e) {
			logger.warn("添加活动异常:", e);
			rspMap.put("rspCode", "-1");
			rspMap.put("rspMsg", "系统繁忙！");
			return rspMap;
		}
	}

	/**
	 * 根据id查活动
	 * 
	 * @param request
	 */
	@RequestMapping("activity/findActivityById")
	public String findActivityById(HttpServletRequest request, @RequestParam("id") String id) {
		try {
			if (id == null) {
				return "404";
			}
			int id_ = Integer.parseInt(id);
			Activity activity = activityService.findById(id_);
			request.setAttribute("activity", activity);
			return "back/activity_edit";
		} catch (Exception e) {
			logger.warn("根据id查活动 异常：", e);
			return "404";
		}
	}

	/**
	 * 编辑活动
	 * 
	 * @return
	 */
	@RequestMapping("activity/editActivity")
	@ResponseBody
	public Map<String, Object> editActivity(HttpServletRequest request, @RequestParam("banner") MultipartFile banner,
			@RequestParam("music") MultipartFile music, @RequestParam("shareImg") MultipartFile shareImg,@RequestParam("img2") MultipartFile img2) {
		HashMap<String, Object> rspMap = new HashMap<String, Object>();
		try {
			String id_ = request.getParameter("id") != null ? request.getParameter("id") : "";
			String name = request.getParameter("name") != null ? request.getParameter("name") : "";
			String startTime = request.getParameter("startTime") != null ? request.getParameter("startTime") : "";
			String endTime = request.getParameter("endTime") != null ? request.getParameter("endTime") : "";
			String remark = request.getParameter("remark") != null ? request.getParameter("remark") : "";

			String bgColor = request.getParameter("bgColor") != null ? request.getParameter("bgColor") : "";
			String btnColor = request.getParameter("btnColor") != null ? request.getParameter("btnColor") : "";
			String btnTextColor = request.getParameter("btnTextColor") != null ? request.getParameter("btnTextColor")
					: "";

			String shareText = request.getParameter("shareText") != null ? request.getParameter("shareText") : "";
			String baseNumber = request.getParameter("baseNumber") != null ? request.getParameter("baseNumber") : "";
			String pvBaseNumber = request.getParameter("pvBaseNumber") != null ? request.getParameter("pvBaseNumber")
					: "";
			
			String img2Href = request.getParameter("img2Href") != null ? request.getParameter("img2Href") : "";
			// 校验参数
			if (StringUtils.isBlank(name) || StringUtils.isBlank(startTime) || StringUtils.isBlank(endTime)
					|| StringUtils.isBlank(id_)) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "提交的参数有误！");
				logger.info("提交的参数name[{}],startTime[{}],endTime[{}]有误！",name,startTime,endTime);
				return rspMap;
			}
			String pattern = PublicService.DATETIME_PATTERN;

			Date startDate = DateUtils.parseDate(startTime, pattern);
			Date endDate = DateUtils.parseDate(endTime, pattern);

			if ((startDate.getTime() - endDate.getTime()) > 0) {
				// 开始时间大于了结束时间
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "活动开始时间不能大于活动结束时间！");
				logger.info("活动开始时间[{}]不能大于活动结束时间[{}]！",startTime,endTime);
				return rspMap;
			}

			String regex = "[0-9a-f]{6}";
			Pattern colorPattern = Pattern.compile(regex);
			if (!colorPattern.matcher(bgColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "背景色值格式有误！");
				logger.info("背景色值[{}]格式有误！",bgColor);
				return rspMap;
			}

			if (!colorPattern.matcher(btnColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "按钮色值格式有误！");
				logger.info("按钮色值[{}]格式有误！",btnColor);
				return rspMap;
			}

			if (!colorPattern.matcher(btnTextColor).matches()) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "按钮内文字色值格式有误！");
				logger.info("钮内文字色值[{}]格式有误！",bgColor);
				return rspMap;
			}

			if (!StringUtils.isNumeric(baseNumber) || Integer.parseInt(baseNumber) < 0) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "报名基数必须是大于等于0的整数！");
				logger.info("报名基数必须是大于等于0的整数！");
				return rspMap;
			}

			if (!StringUtils.isNumeric(pvBaseNumber) || Integer.parseInt(pvBaseNumber) < 0) {
				rspMap.put("rspCode", "0");
				rspMap.put("rspMsg", "关注人数基数必须是大于等于0的整数！");
				logger.info("关注人数基数必须是大于等于0的整数！");
				return rspMap;
			}
			
			

			Integer id = Integer.parseInt(id_);
			Activity activity = new Activity();
			activity.setId(id);
			activity.setName(name);
			activity.setStartTime(startDate);
			activity.setEndTime(endDate);
			activity.setRemark(remark);
			activity.setBgColor(bgColor);
			activity.setBtnColor(btnColor);
			activity.setBtnTextColor(btnTextColor);
			activity.setShareText(shareText);
			activity.setBaseNumber(Integer.parseInt(baseNumber));
			activity.setPvBaseNumber(Integer.parseInt(pvBaseNumber));
			activity.setImg2Href(img2Href);
			String basePath = PublicService.basePath;
			if (!banner.isEmpty()) {// 文件不为空
				if (!FileUtil.isImage(banner)) {// 文件类型错误
					rspMap.put("rspCode", "0");
					rspMap.put("rspMsg", "上传的活动图片格式错误！");
					return rspMap;
				}
				// 存储banner图片

				String path_banner = "images/" + id;
				String dirPath = basePath + path_banner;

				String bannerFileName = FileUtil.storeFile(basePath, dirPath, banner, id);

				activity.setBannerUrl((path_banner + "/" + bannerFileName));
			}

			if (!music.isEmpty()) {// 文件不为空
				if (!FileUtil.isAudio(music)) {// 文件类型错误
					rspMap.put("rspCode", "0");
					rspMap.put("rspMsg", "上传的音乐格式错误！");
					logger.info("上传的音乐格式错误！");
					return rspMap;
				}
				// 存储音乐
				String path_music = "audio/" + id;
				String audioDirPath = basePath + path_music;
				String musicFileName = FileUtil.storeFile(basePath, audioDirPath, music, id);
				activity.setMusicUrl(path_music + "/" + musicFileName);
			}

			if (!shareImg.isEmpty()) {// 文件不为空
				if (!FileUtil.isImage(shareImg)) {// 文件类型错误
					rspMap.put("rspCode", "0");
					rspMap.put("rspMsg", "上传的微信分享图片格式错误！");
					logger.info("上传的微信分享图片格式错误！");
					return rspMap;
				}
				// 存储微信分享图片
				String path_share_img = "share_img/" + id;
				String shareImgDirPath = basePath + path_share_img;
				String shareImgFileName = FileUtil.storeFile(basePath, shareImgDirPath, shareImg, id);
				activity.setShareImg(path_share_img + "/" + shareImgFileName);
			}
			
			// 存储图片2
			if (!img2.isEmpty()) {// 文件不为空
				if (!FileUtil.isImage(img2)) {// 文件类型错误
					rspMap.put("rspCode", "0");
					rspMap.put("rspMsg", "上传的图片2格式错误！");
					logger.info("上传的图片2格式错误！");
					return rspMap;
				}
				String path_img2 = "img2/" + id;
				String img2DirPath = basePath + path_img2;
				String img2FileName = FileUtil.storeFile(basePath, img2DirPath, img2, id);
				activity.setImg2(path_img2 + "/" + img2FileName);
			}
						
			

			// 修改数据库
			Integer res2 = activityService.updateOne(activity);
			if (res2 != 1) {
				throw new Exception();
			}

			rspMap.put("rspCode", "1");
			rspMap.put("rspMsg", "编辑成功！");
			logger.info("编辑活动[{}]成功",name);
			return rspMap;
		} catch (Exception e) {
			logger.warn("编辑活动异常:", e);
			rspMap.put("rspCode", "-1");
			rspMap.put("rspMsg", "系统繁忙！");
			return rspMap;
		}
	}
	// ------------------activity module end--------------------------------

	// ------------------statistics module start--------------------------------

	/**
	 * 根据活动id下载某天的数据
	 * 
	 * @param response
	 * @param request
	 * @param id
	 * @param date
	 */
	@RequestMapping(value = "statistics/download/{id}/{date}", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> download(HttpServletResponse response, HttpServletRequest request,
			@PathVariable("id") String id, @PathVariable("date") String date) {
		Map<String, Object> rspMap = new HashMap<String, Object>();
		try {
			// 处理入参
			if (StringUtils.isBlank(id) || StringUtils.isBlank(date)) {
				throw new Exception();
			}
			Integer id_ = Integer.parseInt(id);
			DateUtils.parseDate(date, "yyyy-MM-dd");

			Activity activity = activityService.findById(id_);
			String name = activity.getName();

			String startDate = date + " 00:00:00";
			String endDate = date + " 23:59:59";
			List<Customer> customers = customerService.findByDateRangeAndActivityId(startDate, endDate, id_);
			String head = "姓名,电话,报名时间\n";
			StringBuffer sb = new StringBuffer();
			sb.append(head);
			// 下载
			if (customers != null && customers.size() > 0) {
				for (Customer customer : customers) {
					sb.append(customer.getName()).append(",");
					sb.append(customer.getPhone()).append(",");
					sb.append(DateUtils.formatDate(customer.getCreateTime(), PublicService.DATETIME_PATTERN));
					sb.append("\n");
				}
			}

			String filename = id_ + "_" + name + "_" + date + ".csv";
			filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("content-disposition", "attachment;filename=" + filename);

			OutputStream os = response.getOutputStream();
			os.write(sb.toString().getBytes());
			os.flush();
			os.close();
			return null;

		} catch (Exception e) {
			logger.warn("下载统计数据异常：", e);
			rspMap.put("rspMsg", "下载失败,服务器繁忙!");
			return rspMap;
		}
	}

	/**
	 * 明细下载页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("statistics/index")
	public String statisticsIndex(HttpServletRequest request) {
		try {
			String id_ = request.getParameter("id") != null ? request.getParameter("id") : "";
			if (StringUtils.isBlank(id_)) {
				throw new Exception();
			}
			int id = Integer.parseInt(id_);

			List<Map<String, String>> links = new ArrayList<Map<String, String>>();
			Integer count = PublicService.statisticsDays;
			String prefix = "";
			if (PublicService.devMode) {// 开发模式
				prefix = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
						+ request.getContextPath() + "/back/statistics/download/" + id + "/";
			} else {
				prefix = request.getScheme() + "://" + request.getServerName() + request.getContextPath()
						+ "/back/statistics/download/" + id + "/";
			}

			Calendar calendar = Calendar.getInstance();
			for (int i = 0; i < count; i++) {
				Map<String, String> map = new HashMap<String, String>();
				Date time = calendar.getTime();
				String formatDate = DateUtils.formatDate(time, "yyyy-MM-dd");
				map.put("value", prefix + formatDate);
				map.put("name", formatDate);
				links.add(map);
				calendar.add(Calendar.DAY_OF_YEAR, -1);// 减一天
			}

			request.setAttribute("links", links);
			return "back/statistics_index";

		} catch (Exception e) {
			logger.warn("明细下载页面异常：", e);
			return "404";
		}
	}

	// ------------------statistics module end--------------------------------

}
