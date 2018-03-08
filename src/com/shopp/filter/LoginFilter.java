package com.shopp.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(description = "登录过滤器", filterName = "loginFilter", urlPatterns = { "/*" }, initParams = { @WebInitParam(name = "loginPage", value = "login.jsp") })
public class LoginFilter implements Filter {

    private FilterConfig config;

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        String loginPage = config.getInitParameter("loginPage");
        HttpSession session = ((HttpServletRequest) request).getSession();
        String requestPath = ((HttpServletRequest) request).getServletPath();
        if (session.getAttribute("uname") == null
                && (requestPath.endsWith("myGoods.jsp")
                || requestPath.endsWith("collection.jsp")
                ||  requestPath.endsWith("showMessage.jsp"))) {
            request.getRequestDispatcher(loginPage).forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig config) throws ServletException {
        this.config = config;
    }

}