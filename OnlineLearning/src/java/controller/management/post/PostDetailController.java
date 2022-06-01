package controller.management.post;

import dao.BlogCategoryBlogDAO;
import dao.BlogCategoryDAO;
import dao.BlogDAO;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Blog;
import model.BlogCategory;
import model.BlogCategoryBlog;

@WebServlet(name = "PostDetailController", urlPatterns = {"/management/post-detail"})

public class PostDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String action = "";
        if (request.getParameter("bid") == null) {
            action = "SAVE";
        } else {
            int bid = Integer.parseInt(request.getParameter("bid"));
            Blog blog = new BlogDAO().getBlogByID(bid);
            ArrayList<BlogCategory> listCategoryOfBlog = new BlogCategoryDAO().getCategoryByID(bid);
            action = "EDIT";

            request.setAttribute("listCategoryOfBlog", listCategoryOfBlog);
            request.setAttribute("Post", blog);
            request.setAttribute("bid", request.getParameter("bid"));
        }

        //getPostDetail(request, response);
        ArrayList<BlogCategory> listBlogCategory = getListCategoryBlog();
        request.setAttribute("listBlogCategory", listBlogCategory);
        request.setAttribute("action", action);

        request.getRequestDispatcher("../view/post-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("SAVE")) {
            addBlogToData(request, response);

        } else if (action.equalsIgnoreCase("EDIT")) {
            editBlogToData(request, response);
            response.sendRedirect("post-detail?bid=" + request.getParameter("bid"));
        }
    }

    private void addBlogToData(HttpServletRequest request, HttpServletResponse response) {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        String thumbnailUrl = request.getParameter("thumbnailUrl");
        boolean display = request.getParameter("status").equals("display");
        String[] categoryBlogID = request.getParameterValues("blogCategory");

        Account account = (Account)request.getSession().getAttribute("account");

        Blog blog = new Blog();
        blog.setTitle(title);
        blog.setDescription(description);
        blog.setContent(content);
        blog.setCreatedDate(Date.valueOf(LocalDate.now()));
        blog.setAuthorID(account);
        blog.setDisplay(display);
        blog.setThumbnailUrl(thumbnailUrl);
        blog.setNumberOfView(0);
        int blogID = -1;
        try {
            blogID = new BlogDAO().insertBlog(blog);
        } catch (Exception ex) {
            Logger.getLogger(PostDetailController.class.getName()).log(Level.SEVERE, null, ex);
        }

        //get id of blog just created
        int idBlogNew = new BlogDAO().getBlogIdNewest();
        Blog blogNew = new Blog();
        blogNew.setBlogID(idBlogNew);

        for (String category : categoryBlogID) {
            BlogCategory blogCategory = new BlogCategory();
            blogCategory.setBlogCategoryID(Integer.parseInt(category));

            BlogCategoryBlog blogCategoryBlog = new BlogCategoryBlog(blogNew, blogCategory);

            new BlogCategoryBlogDAO().insertBlogCategoryBlog(blogCategoryBlog);
        }

        try {
            response.sendRedirect("post-detail?bid=" + blogID);
        } catch (IOException ex) {
            Logger.getLogger(PostDetailController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void editBlogToData(HttpServletRequest request, HttpServletResponse response) {

        int blogId = Integer.parseInt(request.getParameter("bid"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        String thumbnailUrl = request.getParameter("thumbnailUrl");
        boolean display = request.getParameter("status").equals("display");
        String[] categoryBlogID = request.getParameterValues("blogCategory");

        Account account = (Account)request.getSession().getAttribute("account");

        Blog blog = new Blog();
        blog.setBlogID(blogId);
        blog.setTitle(title);
        blog.setDescription(description);
        blog.setContent(content);
        blog.setCreatedDate(Date.valueOf(LocalDate.now()));
        blog.setAuthorID(account);
        // edit
        blog.setDisplay(display);
        blog.setThumbnailUrl(thumbnailUrl);
        blog.setNumberOfView(0);

        new BlogDAO().updateBlog(blog);

        new BlogCategoryBlogDAO().deleteByBlogID(blogId);
        
        for (String category : categoryBlogID) {
            BlogCategory blogCategory = new BlogCategory();
            blogCategory.setBlogCategoryID(Integer.parseInt(category));

            BlogCategoryBlog blogCategoryBlog = new BlogCategoryBlog(blog, blogCategory);

            new BlogCategoryBlogDAO().insertBlogCategoryBlog(blogCategoryBlog);
        }

        ArrayList<BlogCategory> listCategoryOfBlog = new BlogCategoryDAO().getCategoryByID(blogId);
        request.setAttribute("listCategoryOfBlog", listCategoryOfBlog);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    public ArrayList<BlogCategory> getListCategoryBlog() {
        ArrayList<BlogCategory> listCategoryBlog = new BlogCategoryDAO().getAllBlogCategory();
        return listCategoryBlog;
    }

}