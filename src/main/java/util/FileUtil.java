package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
	public static String fileToBase64(File file) {
		String base64 = null;
		InputStream in = null;
		try {
			in = new FileInputStream(file);
			byte[] bytes = FileUtils.readFileToByteArray(file);
			base64 = Base64.getEncoder().encodeToString(bytes);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return base64;
	}

	public static boolean isImage(MultipartFile multfile) {
		String contentType = multfile.getContentType();
		String realType = contentType.substring(contentType.indexOf('/') + 1, contentType.length());
		if (contentType.contains("image")) {
			if ((realType.equals("jpg") || realType.equals("jpeg") || realType.equals("png")
					|| realType.contains("bmp") || realType.contains("gif"))) {
				return true;
			}
		}
		return false;
	}
	
	public static boolean isAudio(MultipartFile multfile) {
		String contentType = multfile.getContentType();
		String realType = contentType.substring(contentType.indexOf('/') + 1, contentType.length());
		if (contentType.contains("audio")) {
			if ((realType.equals("mp3"))) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	 * @param basePath  配置文件中的目录
	 * @param parentPath  父文件夹路径
	 * @param multipartFile 文件
	 * @param id  活动id
	 * @throws Exception
	 */
	public static String storeFile(String basePath ,String parentPath,MultipartFile multipartFile,Integer id) throws Exception{
		File dir = new File(parentPath);
		if (!dir.exists()) {// 判断目标目录是否存在
			dir.mkdirs();// 不存在则创建
		}
		
		File tmp = new File(basePath + "tmp");
		if (!tmp.exists()) {
			tmp.mkdirs();
		}
		String fileName = multipartFile.getOriginalFilename();
		String prefix = fileName.substring(fileName.lastIndexOf("."));

		File tempFile = File.createTempFile(fileName, prefix, tmp);
		multipartFile.transferTo(tempFile);

		fileName = System.currentTimeMillis() + "_";
		fileName += id + prefix;
		
		File localFile = new File(dir, fileName);
		tempFile.renameTo(localFile);
		return fileName;
	}
	
}
