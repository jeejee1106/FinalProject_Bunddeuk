package data.notice;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletContext;
import org.springframework.web.multipart.MultipartFile;

public class UploadFileHelper {
	
	public static String upload(ServletContext servletContext, MultipartFile multipartFile) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String fileName = sdf.format(new Date()) + multipartFile.getOriginalFilename();
			Path path = Paths.get(servletContext.getRealPath("/webapp/ckupload/" + fileName));
			Files.write(path, multipartFile.getBytes());
			return fileName;
		} catch (Exception e) {
			return null;
		}
	}

}
