package com.plick.min;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/player/audios/*")
public class FileDownlaodServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청에서 파일 이름 가져오기
		String fileName = request.getPathInfo().substring(1); // "/example.mp3"
		System.out.println(fileName);
		File audioFile = new File("C:\\Users\\k8489\\git\\sist-semi2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\semi2\\player\\audios\\", fileName); // 오디오 파일이 저장된 경로

		if (audioFile.exists() && !audioFile.isDirectory()) {
			// 응답의 콘텐츠 타입 설정 (오디오 파일의 MIME 타입)
			response.setContentType("audio/mpeg");

			// 파일 전송
			try (FileInputStream in = new FileInputStream(audioFile); OutputStream out = response.getOutputStream()) {
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = in.read(buffer)) != -1) {
					out.write(buffer, 0, bytesRead);
				}
				out.flush();
			}
		} else {
			// 파일이 없을 경우 처리
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
		}
	}
}
