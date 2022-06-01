<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="./base-view/baseTagAdmin.jsp"></jsp:include>

        <link rel="stylesheet" href="../css/account-list.css">

        <title>Dashboard</title>
    </head>
    <body>
        <div class="display-flex min-height-100vh">
            <jsp:include page="./base-view/headerAdmin.jsp"></jsp:include>

            <div class="width85">
                    
                <jsp:include page="./base-view/dropDownAdmin.jsp"></jsp:include>

                <!-- Container Start -->

                <div class="container">
                    <h1 class="container-title">Dashboard</h1>
                </div>
            </div>
        </div>
    </body>
</html>
