package me.ffs.www.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

public class Customer implements Serializable{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -3430376640195506609L;

	/**
     * 客户编号
     */
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;

    /**
     * 姓名
     */
    private String name;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 地址
     */
    private String address;

    /**
     * 所属活动id
     */
    @Column(name = "activity_id")
    private Integer activityId;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

    private String remark1;

    private String remark2;

    private String remark3;

    private String remark4;

    private String remark5;

    /**
     * 获取客户编号
     *
     * @return id - 客户编号
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置客户编号
     *
     * @param id 客户编号
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取姓名
     *
     * @return name - 姓名
     */
    public String getName() {
        return name;
    }

    /**
     * 设置姓名
     *
     * @param name 姓名
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取手机号
     *
     * @return phone - 手机号
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 设置手机号
     *
     * @param phone 手机号
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取地址
     *
     * @return address - 地址
     */
    public String getAddress() {
        return address;
    }

    /**
     * 设置地址
     *
     * @param address 地址
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * 获取所属活动id
     *
     * @return activity_id - 所属活动id
     */
    public Integer getActivityId() {
        return activityId;
    }

    /**
     * 设置所属活动id
     *
     * @param activityId 所属活动id
     */
    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
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
     * @return remark1
     */
    public String getRemark1() {
        return remark1;
    }

    /**
     * @param remark1
     */
    public void setRemark1(String remark1) {
        this.remark1 = remark1;
    }

    /**
     * @return remark2
     */
    public String getRemark2() {
        return remark2;
    }

    /**
     * @param remark2
     */
    public void setRemark2(String remark2) {
        this.remark2 = remark2;
    }

    /**
     * @return remark3
     */
    public String getRemark3() {
        return remark3;
    }

    /**
     * @param remark3
     */
    public void setRemark3(String remark3) {
        this.remark3 = remark3;
    }

    /**
     * @return remark4
     */
    public String getRemark4() {
        return remark4;
    }

    /**
     * @param remark4
     */
    public void setRemark4(String remark4) {
        this.remark4 = remark4;
    }

    /**
     * @return remark5
     */
    public String getRemark5() {
        return remark5;
    }

    /**
     * @param remark5
     */
    public void setRemark5(String remark5) {
        this.remark5 = remark5;
    }
}