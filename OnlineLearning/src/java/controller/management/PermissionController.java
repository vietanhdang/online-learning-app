package controller.management;

import dao.PermissionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Permission;

@WebServlet(name = "PermissionController", urlPatterns = {"/management/permission"})
public class PermissionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List permissions = new PermissionDAO().findAll();
        RequestDispatcher dispatcher = req.getRequestDispatcher("../view/permission-management.jsp");
        req.setAttribute("permissions", permissions);
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String permissionName = req.getParameter("permissionName");
        String requestUrl = req.getParameter("requestUrl");
        String method = req.getParameter("method");
        PermissionDAO permissionDAO = new PermissionDAO();
        Permission permission = new Permission(0, permissionName, requestUrl, method);
        permissionDAO.save(permission);
        resp.sendRedirect("./permission");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        PermissionDAO permissionDAO = new PermissionDAO();
        permissionDAO.deleteById(id);
        resp.setStatus(200);
        resp.flushBuffer();
    }
}
