package me.ffs.www.control.controller;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import me.ffs.www.service.PublicService;

@Controller
public class ImageController {
	private static Logger logger = LoggerFactory.getLogger(ImageController.class);
	
	@RequestMapping("images/{aid}/{filename}")
	public void images(@PathVariable("aid") String aid,@PathVariable("filename") String filename,HttpServletRequest request,HttpServletResponse response){
		try {
			String filepath = PublicService.basePath + "images/"+aid+"/"+filename;
			FileInputStream fis = new FileInputStream(filepath);
			ServletOutputStream os = response.getOutputStream();
			int len = 0;
			byte[] b = new byte[1024];
			while((len = fis.read(b)) != -1){
				os.write(b, 0, len);
			}
			os.flush();
			os.close();
		} catch (Exception e) {
			logger.warn("图片读取:",e);
		}
	}
}
