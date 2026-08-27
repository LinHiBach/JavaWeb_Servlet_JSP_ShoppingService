package vn.hcmute.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.hcmute.utils.Constant;

@WebServlet(urlPatterns = "/image")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String[] SEARCH_DIRS = {
        Constant.DIR,
        "C:\\upload",
        "C:\\Users\\LEGIO\\Documents\\workspace-spring-tools-for-eclipse-5.3.0.RELEASE\\BaiTapMVC_JDBC\\upload",
        "upload"
    };

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rawFileName = req.getParameter("fname");
        if (rawFileName == null || rawFileName.trim().isEmpty() || rawFileName.contains("..")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file name");
            return;
        }

        String fileName = URLDecoder.decode(rawFileName.trim(), StandardCharsets.UTF_8);
        if (fileName.startsWith("/") || fileName.startsWith("\\")) {
            fileName = fileName.substring(1);
        }

        File targetFile = findImageFile(fileName, req);

        if (targetFile == null || !targetFile.exists() || !targetFile.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found: " + fileName);
            return;
        }

        String mimeType = URLConnection.guessContentTypeFromName(targetFile.getName());
        if (mimeType == null) {
            String lowerName = targetFile.getName().toLowerCase();
            if (lowerName.endsWith(".png")) {
                mimeType = "image/png";
            } else if (lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg")) {
                mimeType = "image/jpeg";
            } else if (lowerName.endsWith(".gif")) {
                mimeType = "image/gif";
            } else if (lowerName.endsWith(".webp")) {
                mimeType = "image/webp";
            } else {
                mimeType = "application/octet-stream";
            }
        }

        resp.setContentType(mimeType);
        resp.setContentLengthLong(targetFile.length());
        resp.setHeader("Cache-Control", "public, max-age=86400");

        try (FileInputStream in = new FileInputStream(targetFile);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
        }
    }

    private File findImageFile(String fileName, HttpServletRequest req) {
        for (String dirPath : SEARCH_DIRS) {
            if (dirPath != null && !dirPath.isEmpty()) {
                File file = new File(dirPath, fileName);
                if (file.exists() && file.isFile()) {
                    return file;
                }
            }
        }

        // Kiểm tra trong ServletContext thực tế
        try {
            String contextPath = req.getServletContext().getRealPath("/upload/" + fileName);
            if (contextPath != null) {
                File file = new File(contextPath);
                if (file.exists() && file.isFile()) {
                    return file;
                }
            }
        } catch (Exception ignored) {}

        return null;
    }
}
