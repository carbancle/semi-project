package utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jakartaee.commons.io.IOUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import jakarta.servlet.http.HttpServletRequest;

/**
 * 멀티파트 요청을 처리하는 클래스다.
 * @author lee_e
 *
 */
public class MultipartRequest {
	
	private String saveDirectory;
	private Map<String, List<FileItem>> parameterMap = new HashMap<>();

	/**
	 * 요청객체, 업로드파일 저장 경로를 전달받아서 MultipartRequest객체를 생성한다.
	 * @param request 요청객체
	 * @param saveDirectory 업로드된 파일을 저장할 디렉토리 경로
	 * @throws IOException 업로드된 파일 처리 중 오류가 발생했을 때
	 */
	public MultipartRequest(HttpServletRequest request, String saveDirectory) throws IOException {
		this.saveDirectory = saveDirectory;
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024*1024*10);
		factory.setDefaultCharset("utf-8");
		ServletFileUpload fileUpload = new ServletFileUpload(factory);
		parameterMap = fileUpload.parseParameterMap(request);
		
		upload();
	}	
	
	/**
	 * 지정된 이름의 요청파라미터값을 반환한다.
	 * @param name 요청파라미터 이름
	 * @return 요청파라미터 값, 지정된 이름의 요청파라미터가 존재하지 않으면 null을 반환한다.
	 */
	public String getParameter(String name) {
		List<FileItem> items = parameterMap.get(name);
		if (items == null || items.isEmpty()) {
			return null;
		}
		FileItem item = items.get(0);
		if (item == null) {
			return null;
		}
		
		return item.getString();
	}
	
	/**
	 * 지정된 이름의 요청파라미터값을 배열에 담아서 반환한다.
	 * @param name 요청파라미터 이름
	 * @return 요청파라미터값이 포함된 배열, 지정된 이름의 요청파라미터가 존재하지 않으면 null을 반환한다.
	 */
	public String[] getParameterValues(String name) {
		List<FileItem> items = parameterMap.get(name);
		if (items == null || items.isEmpty()) {
			return null;
		}
		
		String[] values = new String[items.size()];
		int index = 0;
		for (FileItem item : items) {
			values[index++] = item.getString();
		}
		return values;
	}
	
	/**
	 * 지정된 이름으로 업로드된 첨부파일의 이름을 반환한다.
	 * @param name 요청파라미터 이름
	 * @return 첨부파일명, 첨부파일을 선택하지 않은 경우 null이 반환된다.
	 */
	public String getFilename(String name) {
		List<FileItem> items = parameterMap.get(name);
		if (items == null || items.isEmpty()) {
			return null;
		}
		return getFilename(items.get(0));
	}
	
	/**
	 * 업로드된 모든 파일을 지정된 디렉토리에 저장한다.
	 * @throws IOException 업로드된 파일 처리 중 오류가 발생했을 때
	 */
	private void upload() throws IOException {
		Collection<List<FileItem>> mapValues =  parameterMap.values();
		for (List<FileItem> items : mapValues) {
			for (FileItem item : items) {
				if (!item.isFormField()) {
					String filename = getFilename(item);
					if (filename != null) {
						IOUtils.copy(item.getInputStream(), new FileOutputStream(new File(saveDirectory, filename)));
					}
				}
			}
		}
		
	}
	
	/**
	 * 파일명을 반환한다.
	 * @param fileItem 파일아이템 객체
	 * @return 파일명, 파일아이템객체가 null이거나 크기가 0이면 null을 반환한다.
	 */
	private String getFilename(FileItem fileItem) {
		if (fileItem == null) {
			return null;
		}
		
		if (fileItem.isFormField()) {
			return null;
		}
		
		if (fileItem.getSize() == 0) {
			return null;
		}
		
		String path = fileItem.getName();
		int index = path.lastIndexOf(File.separator);
		return path.substring(index + 1);
	}
	 
}
