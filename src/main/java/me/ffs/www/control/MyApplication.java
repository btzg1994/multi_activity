package me.ffs.www.control;

import javax.servlet.MultipartConfigElement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

import tk.mybatis.spring.annotation.MapperScan;


/**
 * @author: 456
 * @date: 2018/3/6
 *
 */
@MapperScan(basePackages = "me.ffs.www.dao.mapper")
@ComponentScan(basePackages={"me.ffs"})
@SpringBootApplication
@EnableScheduling
public class MyApplication {

	public static void main(String[] args) {
		SpringApplication.run(MyApplication.class, args);

	}
	
	/**  
     * 文件上传配置  
     * @return  
     */  
    @Bean  
    public MultipartConfigElement multipartConfigElement() {  
        MultipartConfigFactory factory = new MultipartConfigFactory();  
        //单个文件最大  
        factory.setMaxFileSize("10240KB"); //KB,MB  
        return factory.createMultipartConfig();  
    }
}
