package me.ffs.www.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

public class Activity implements Serializable{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 3764282776888722655L;

	/**
     * 活动id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
     * @return reamrk
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param reamrk
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }
}