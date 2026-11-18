package vn.hcmute.config;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.WriteListener;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

@WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class SiteMeshFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Bỏ qua các tài nguyên tĩnh và image servlet
        String lowerPath = path.toLowerCase();
        if (path.startsWith("/image") || path.startsWith("/assets") || path.startsWith("/static") || path.startsWith("/upload")
                || lowerPath.endsWith(".css") || lowerPath.endsWith(".js") || lowerPath.endsWith(".png")
                || lowerPath.endsWith(".jpg") || lowerPath.endsWith(".jpeg") || lowerPath.endsWith(".gif")
                || lowerPath.endsWith(".webp") || lowerPath.endsWith(".svg") || lowerPath.endsWith(".ico")
                || lowerPath.endsWith(".woff") || lowerPath.endsWith(".woff2") || lowerPath.endsWith(".ttf")
                || lowerPath.endsWith(".map")) {
            chain.doFilter(request, response);
            return;
        }

        // Tránh bọc lặp lại chính các file decorator JSP
        if (path.startsWith("/WEB-INF/decorators")) {
            chain.doFilter(request, response);
            return;
        }

        String decoratorPath = getDecoratorPath(path);

        // Các trang không áp dụng layout (login, register, otp, logout, waiting...) đi thẳng qua chain
        if (decoratorPath == null) {
            chain.doFilter(request, response);
            return;
        }

        FilteredRequestWrapper wrappedRequest = new FilteredRequestWrapper(req);
        CharResponseWrapper responseWrapper = new CharResponseWrapper(resp);

        chain.doFilter(wrappedRequest, responseWrapper);

        // Nếu response đã redirect hoặc báo lỗi HTTP thì dừng
        if (responseWrapper.isRedirectedOrError() || resp.isCommitted()) {
            return;
        }

        String contentType = responseWrapper.getContentType();
        String capturedText = responseWrapper.toString();

        if (capturedText != null && !capturedText.trim().isEmpty()
                && (contentType == null || contentType.contains("text/html"))) {

            String title = extractPattern(capturedText, "<title>(.*?)</title>", Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
            String head = extractPattern(capturedText, "<head[^>]*>(.*?)</head>", Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
            String rawBody = extractPattern(capturedText, "<body[^>]*>(.*?)</body>", Pattern.DOTALL | Pattern.CASE_INSENSITIVE);

            String body = (rawBody != null && !rawBody.trim().isEmpty()) ? rawBody : capturedText;

            if (head != null) {
                head = head.replaceAll("(?is)<title>.*?</title>", "")
                           .replaceAll("(?is)<meta\\s+charset=[^>]*>", "")
                           .replaceAll("(?is)<meta\\s+name=[\"']viewport[\"'][^>]*>", "")
                           .trim();
            }

            String safeTitle = title != null ? title : "Shopping Store";
            String safeHead = head != null ? head : "";

            req.setAttribute("title", safeTitle);
            req.setAttribute("head", safeHead);
            req.setAttribute("body", body);

            req.setAttribute("sitemesh.title", safeTitle);
            req.setAttribute("sitemesh.head", safeHead);
            req.setAttribute("sitemesh.body", body);

            CharResponseWrapper decoratorWrapper = new CharResponseWrapper(resp);
            try {
                req.getRequestDispatcher(decoratorPath).include(req, decoratorWrapper);
                String decoratedContent = decoratorWrapper.toString();

                if (decoratedContent != null && !decoratedContent.trim().isEmpty()) {
                    decoratedContent = decoratedContent
                            .replace("<sitemesh:write property=\"body\"/>", body)
                            .replace("<sitemesh:write property='body'/>", body)
                            .replace("<decorator:body/>", body)
                            .replace("${sitemesh.body}", body)
                            .replace("<sitemesh:write property=\"title\"/>", safeTitle)
                            .replace("<sitemesh:write property='title'/>", safeTitle)
                            .replace("<decorator:title/>", safeTitle)
                            .replace("<sitemesh:write property=\"head\"/>", safeHead)
                            .replace("<sitemesh:write property='head'/>", safeHead)
                            .replace("<decorator:head/>", safeHead);

                    resp.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = resp.getWriter();
                    out.write(decoratedContent);
                    out.flush();
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.write(capturedText != null ? capturedText : "");
        out.flush();
    }

    private String getDecoratorPath(String path) {
        if (path == null || path.equals("/") || path.trim().isEmpty()) {
            return null;
        }
        if (path.startsWith("/admin")) {
            return "/WEB-INF/decorators/admin.jsp";
        } else if (path.startsWith("/manager")) {
            return "/WEB-INF/decorators/manager.jsp";
        } else if (path.startsWith("/login") || path.startsWith("/register") || path.startsWith("/waiting")
                || path.startsWith("/logout") || path.startsWith("/forgot-password")
                || path.startsWith("/reset-password") || path.startsWith("/verify-otp")) {
            return null;
        } else {
            return "/WEB-INF/decorators/web.jsp";
        }
    }

    private String extractPattern(String content, String regex, int flags) {
        Pattern pattern = Pattern.compile(regex, flags);
        Matcher matcher = pattern.matcher(content);
        if (matcher.find()) {
            return matcher.group(1).trim();
        }
        return null;
    }

    @Override
    public void destroy() {}

    private static class FilteredRequestWrapper extends HttpServletRequestWrapper {
        public FilteredRequestWrapper(HttpServletRequest request) {
            super(request);
        }

        @Override
        public RequestDispatcher getRequestDispatcher(String path) {
            RequestDispatcher dispatcher = super.getRequestDispatcher(path);
            if (dispatcher == null) {
                return null;
            }
            return new RequestDispatcherWrapper(dispatcher);
        }
    }

    private static class RequestDispatcherWrapper implements RequestDispatcher {
        private final RequestDispatcher targetDispatcher;

        public RequestDispatcherWrapper(RequestDispatcher targetDispatcher) {
            this.targetDispatcher = targetDispatcher;
        }

        @Override
        public void forward(ServletRequest request, ServletResponse response) throws ServletException, IOException {
            targetDispatcher.include(request, response);
        }

        @Override
        public void include(ServletRequest request, ServletResponse response) throws ServletException, IOException {
            targetDispatcher.include(request, response);
        }
    }

    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        private PrintWriter writer;
        private ServletOutputStream servletOutputStream;
        private boolean redirectedOrError = false;

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public void sendRedirect(String location) throws IOException {
            this.redirectedOrError = true;
            super.sendRedirect(location);
        }

        @Override
        public void sendError(int sc) throws IOException {
            this.redirectedOrError = true;
            super.sendError(sc);
        }

        @Override
        public void sendError(int sc, String msg) throws IOException {
            this.redirectedOrError = true;
            super.sendError(sc, msg);
        }

        @Override
        public void flushBuffer() throws IOException {
            if (writer != null) {
                writer.flush();
            }
        }

        public boolean isRedirectedOrError() {
            return redirectedOrError;
        }

        @Override
        public ServletOutputStream getOutputStream() throws IOException {
            if (writer != null) {
                throw new IllegalStateException("getWriter() has already been called for this response");
            }
            if (servletOutputStream == null) {
                servletOutputStream = new ServletOutputStream() {
                    @Override
                    public boolean isReady() { return true; }
                    @Override
                    public void setWriteListener(WriteListener writeListener) {}
                    @Override
                    public void write(int b) { outputStream.write(b); }
                    @Override
                    public void write(byte[] b, int off, int len) { outputStream.write(b, off, len); }
                };
            }
            return servletOutputStream;
        }

        @Override
        public PrintWriter getWriter() throws IOException {
            if (servletOutputStream != null) {
                throw new IllegalStateException("getOutputStream() has already been called for this response");
            }
            if (writer == null) {
                String encoding = getCharacterEncoding();
                if (encoding == null) encoding = "UTF-8";
                writer = new PrintWriter(new OutputStreamWriter(outputStream, encoding), true);
            }
            return writer;
        }

        @Override
        public String toString() {
            if (writer != null) {
                writer.flush();
            }
            String encoding = getCharacterEncoding();
            if (encoding == null) encoding = "UTF-8";
            try {
                return outputStream.toString(encoding);
            } catch (Exception e) {
                return outputStream.toString();
            }
        }
    }
}
