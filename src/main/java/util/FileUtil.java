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
		long fileSize = multfile.getSize();
		if (contentType.contains("image")) {
			if ((realType.equals("jpg") || realType.equals("jpeg") || realType.equals("png")
					|| realType.contains("bmp") || realType.contains("gif"))) {
				return true;
			}
		}
		return false;
	}
}
