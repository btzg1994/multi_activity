package me.ffs.www.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

public class Activity implements Serializable{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 7434392207680596846L;

	/**
     * 活动id
     */
    @Id
    private Integer id;

    /**
     * 活动名称
     */
    private String name;

    /**
     * 活动主图
     */
    @Column(name = "banner_url")
    private String bannerUrl;

    /**
     * 开始时间
     */
    @Column(name = "start_time")
    private Date startTime;

    /**
     * 结束时间
     */
    @Column(name = "end_time")
    private Date endTime;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

    private String remark;

    /**
     * 页面访问次数
     */
    private Integer pv;

    /**
     * 背景色
     */
    @Column(name = "bg_color")
    private String bgColor;

    /**
     * 按钮颜色
     */
    @Column(name = "btn_color")
    private String btnColor;

    /**
     * 按钮文本颜色
     */
    @Column(name = "btn_text_color")
    private String btnTextColor;

    /**
     * 音乐地址
     */
    @Column(name = "music_url")
    private String musicUrl;

    @Column(name = "share_img")
    private String shareImg;

    /**
     * 报名人数基数
     */
    @Column(name = "base_number")
    private Integer baseNumber;

    /**
     * 页面访问次数基数
     */
    @Column(name = "pv_base_number")
    private Integer pvBaseNumber;

    @Column(name = "share_text")
    private String shareText;

    /**
     * 获取活动id
     *
     * @return id - 活动id
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置活动id
     *
     * @param id 活动id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取活动名称
     *
     * @return name - 活动名称
     */
    public String getName() {
        return name;
    }

    /**
     * 设置活动名称
     *
     * @param name 活动名称
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取活动主图
     *
     * @return banner_url - 活动主图
     */
    public String getBannerUrl() {
        return bannerUrl;
    }

    /**
     * 设置活动主图
     *
     * @param bannerUrl 活动主图
     */
    public void setBannerUrl(String bannerUrl) {
        this.bannerUrl = bannerUrl;
    }

    /**
     * 获取开始时间
     *
     * @return start_time - 开始时间
     */
    public Date getStartTime() {
        return startTime;
    }

    /**
     * 设置开始时间
     *
     * @param startTime 开始时间
     */
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    /**
     * 获取结束时间
     *
     * @return end_time - 结束时间
     */
    public Date getEndTime() {
        return endTime;
    }

    /**
     * 设置结束时间
     *
     * @param endTime 结束时间
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    /**
     * 获取创建时间
     *
     * @return create_time - 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置创建时间
     *
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * @return remark
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    /**
     * 获取页面访问次数
     *
     * @return pv - 页面访问次数
     */
    public Integer getPv() {
        return pv;
    }

    /**
     * 设置页面访问次数
     *
     * @param pv 页面访问次数
     */
    public void setPv(Integer pv) {
        this.pv = pv;
    }

    /**
     * 获取背景色
     *
     * @return bg_color - 背景色
     */
    public String getBgColor() {
        return bgColor;
    }

    /**
     * 设置背景色
     *
     * @param bgColor 背景色
     */
    public void setBgColor(String bgColor) {
        this.bgColor = bgColor;
    }

    /**
     * 获取按钮颜色
     *
     * @return btn_color - 按钮颜色
     */
    public String getBtnColor() {
        return btnColor;
    }

    /**
     * 设置按钮颜色
     *
     * @param btnColor 按钮颜色
     */
    public void setBtnColor(String btnColor) {
        this.btnColor = btnColor;
    }

    /**
     * 获取按钮文本颜色
     *
     * @return btn_text_color - 按钮文本颜色
     */
    public String getBtnTextColor() {
        return btnTextColor;
    }

    /**
     * 设置按钮文本颜色
     *
     * @param btnTextColor 按钮文本颜色
     */
    public void setBtnTextColor(String btnTextColor) {
        this.btnTextColor = btnTextColor;
    }

    /**
     * 获取音乐地址
     *
     * @return music_url - 音乐地址
     */
    public String getMusicUrl() {
        return musicUrl;
    }

    /**
     * 设置音乐地址
     *
     * @param musicUrl 音乐地址
     */
    public void setMusicUrl(String musicUrl) {
        this.musicUrl = musicUrl;
    }

    /**
     * @return share_img
     */
    public String getShareImg() {
        return shareImg;
    }

    /**
     * @param shareImg
     */
    public void setShareImg(String shareImg) {
        this.shareImg = shareImg;
    }

    /**
     * 获取报名人数基数
     *
     * @return base_number - 报名人数基数
     */
    public Integer getBaseNumber() {
        return baseNumber;
    }

    /**
     * 设置报名人数基数
     *
     * @param baseNumber 报名人数基数
     */
    public void setBaseNumber(Integer baseNumber) {
        this.baseNumber = baseNumber;
    }

    /**
     * 获取页面访问次数基数
     *
     * @return pv_base_number - 页面访问次数基数
     */
    public Integer getPvBaseNumber() {
        return pvBaseNumber;
    }

    /**
     * 设置页面访问次数基数
     *
     * @param pvBaseNumber 页面访问次数基数
     */
    public void setPvBaseNumber(Integer pvBaseNumber) {
        this.pvBaseNumber = pvBaseNumber;
    }

    /**
     * @return share_text
     */
    public String getShareText() {
        return shareText;
    }

    /**
     * @param shareText
     */
    public void setShareText(String shareText) {
        this.shareText = shareText;
    }
}