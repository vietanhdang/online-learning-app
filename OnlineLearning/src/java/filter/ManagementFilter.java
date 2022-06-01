package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Role;

public class ManagementFilter implements Filter {

    private FilterConfig filterConfig = null;

    public ManagementFilter() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        Account loggedAccount = (Account) req.getSession().getAttribute("account");

        if (loggedAccount == null) {
//            resp.sendRedirect("./login");
            resp.sendError(401);
        } else {
            String role = loggedAccount.getRole().getName();

            if (Role.ADMIN.equals(role)
                    || Role.EXPERT.equals(role)
                    || Role.MARKETING.equals(role)
                    || Role.SALE.equals(role)) {
                chain.doFilter(request, response);
            } else {
                resp.sendError(403);
            }
        }
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }
}
