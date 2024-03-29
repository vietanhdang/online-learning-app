<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Subject</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!--Font Awesome-->
        <script src="https://kit.fontawesome.com/7b806b5ab9.js" crossorigin="anonymous"></script>
        <!--Jquery-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link href="../css/subject-list.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <script src="../js/subject-list.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-2 min-vh-100 bg-dark p-0">
                    <jsp:include page="sidenav.jsp?page=Manage Subject"/>
                </div>
                <div class="col-sm-10 p-0">
                    <jsp:include page="navbar-header.jsp?page=Manage Subject"/>

                    <div class="container">
                        <div class="container-table">
                            <div class="table-content">
                                <div class="search">
                                    <a class="margin-auto-0 btn btn-primary" href="subject-add" ><i class="fa-solid fa-plus"></i> Add Subject</a>

                                    <form class="search-form"> 
                                        <div class="filter-status">
                                            <select name="status" class="select-tag form-select form-select-sm" onchange="search()" aria-label=".form-select-sm example">
                                                <option value="-1" >All Status</option>
                                                <option value="false" ${display == "false" ? "selected" : ""}>Unpublished</option>
                                                <option value="true" ${display == "true" ? "selected" : ""}>Published</option>     
                                            </select>
                                        </div>

                                        <div class="filter-category" onmouseover="showFilterBox()" onmouseout="hideFilterBox()" >
                                            <i id="filter-icon" class="fa-solid fa-filter"></i>
                                            <div id="filter-category-box">
                                                <div id="search-category-box">
                                                    <input onkeyup="searchCategory()" id="search-category" type="text" value="" placeholder="Search for category name"/>
                                                </div>
                                                <div id="category-checkbox">
                                                    <c:forEach var="mainCategory" items="${subjectMainCategories}">
                                                        <div>
                                                            <div class="main-category">
                                                                <input onchange="checkedSubcategory(this)" id="maincategory${mainCategory.mainCategoryID}" type="checkbox" />
                                                                <label for="maincategory${mainCategory.mainCategoryID}">${mainCategory.name}</label>
                                                            </div>
                                                            <c:forEach var="category" items="${subjectCategories}">
                                                                <c:if test="${category.mainCategoryID.mainCategoryID == mainCategory.mainCategoryID}">
                                                                    <div class="category">
                                                                        <input onchange="checkedCategory(this)" id="category${category.categoryID}" type="checkbox" name="categoryID" value="${category.categoryID}" />
                                                                        <label for="category${category.categoryID}">${category.name}</label>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                            <div class="others">
                                                                <input onchange="checkedCategory(this)" id="other${mainCategory.mainCategoryID}" type="checkbox" name="categoryID" value="${mainCategory.mainCategoryID}" />
                                                                <label for="other${mainCategory.mainCategoryID}">Others</label>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <table class="table table-striped" id="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Category</th>
                                            <th>Number of courses</th>
                                            <th>Course</th>
                                            <th>Owner</th>
                                            <th>Status</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var = "count" value = "-1"/>
                                        <c:forEach items="${subjects}" var="subject">
                                            <c:set var = "count" value = "${count+1}"/>
                                            <tr>
                                                <td>${subject.subjectId}</td>
                                                <td><img class="img-thumbnail-blog" src="../img/${subject.image}"></td>
                                                <td>${subject.name}</td>
                                                <td>${subject.categoryID.name != null ? subject.categoryID.name : subject.mainCategoryID.name}</td>
                                                <td>${numberCourse[count]}</td>
                                                <td><a class="text-primary courses" href="../management/course-list?Sid=${subject.subjectId}">Courses</a></td>
                                                <td>${subject.ownerID.firstName} ${subject.ownerID.lastName}</td>
                                                <c:choose>
                                                    <c:when test = "${subject.status == true}">
                                                        <td>Published</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>Unpublished</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${sessionScope.account.role.id==4}">
                                                            <div id="action">
                                                                <a class="text-primary" href="../management/slide-view?id=${slider.sliderID}">View</a>&nbsp;/&nbsp;
                                                                <a class="text-primary" href="../management/subject-detail?subjectID=${subject.subjectId}">Edit</a>&nbsp;/&nbsp;
                                                                <button class="text-danger" onclick="deleteSubject(${subject.subjectId}, this)">Delete</button>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="subjectCanAccess" items="${listSubjectCanAccess}">
                                                                <c:if test="${subjectCanAccess.subjectId==subject.subjectId}">
                                                                    <div id="action">
                                                                        <a class="text-primary" href="../management/slide-view?id=${slider.sliderID}">View</a>&nbsp;/&nbsp;
                                                                        <a class="text-primary" href="../management/subject-detail?subjectID=${subject.subjectId}">Edit</a>&nbsp;/&nbsp;
                                                                        <button class="text-danger" onclick="deleteSubject(${subject.subjectId}, this)">Delete</button>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JavaScript -->    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

    </body>

</html>