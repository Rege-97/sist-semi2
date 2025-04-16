package com.plick.player;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/resources/songs/*")
public class FileDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = request.getPathInfo().substring(1);
        ServletContext context = getServletContext();
        String absolutePath = context.getRealPath("/resources/songs/");
        File file = new File(absolutePath, filePath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        long fileLength = file.length();
        String rangeHeader = request.getHeader("Range");
        long start = 0;
        long end = fileLength - 1;

        if (rangeHeader != null && rangeHeader.startsWith("bytes=")) {
            String[] ranges = rangeHeader.substring(6).split("-");
            try {
                start = Long.parseLong(ranges[0]);
                if (ranges.length > 1 && !ranges[1].isEmpty()) {
                    end = Long.parseLong(ranges[1]);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            if (end >= fileLength) {
                end = fileLength - 1;
            }
            response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
        }

        long contentLength = end - start + 1;

        response.setHeader("Content-Type", "audio/mpeg");
        response.setHeader("Accept-Ranges", "bytes");
        response.setHeader("Content-Length", String.valueOf(contentLength));
        response.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + fileLength);

        try (OutputStream out = response.getOutputStream();
             FileInputStream in = new FileInputStream(file)) {

            in.skip(start);

            byte[] buffer = new byte[4096];
            long remaining = contentLength;
            int read;

            while (remaining > 0 && (read = in.read(buffer, 0, (int)Math.min(buffer.length, remaining))) != -1) {
                out.write(buffer, 0, read);
                remaining -= read;
            }
        }
    }
}
