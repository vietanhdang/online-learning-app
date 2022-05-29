<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Account"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
              integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/base.css" rel="stylesheet" type="text/css"/>
        <link href="css/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;600&display=swap" rel="stylesheet">
        <title>Document</title>
        <script src="https://kit.fontawesome.com/d98f50bd37.js" crossorigin="anonymous"></script>
        <%
            Object isNoti = request.getAttribute("isNoti");
            Account account = (Account) request.getSession().getAttribute("account");
        %>
    </head>

    <body>

        <!-- Navbar Start -->
        <nav class="navbar">
            <a href="index.html" class="navbar-brand">
                <h2><i class="fa-solid fa-book"></i>eLEARNING</h2>
            </a>
            <div class="navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav">
                    <a href="index.html" class="nav-item nav-link">Home</a>
                    <a href="courses.html" class="nav-item nav-link">Courses</a>
                    <a href="#" class="nav-item nav-link">My Courses</a>
                    <a href="blog.html" class="nav-item nav-link">Blog</a>
                </div>
                <!-- <a href="login.html" class="btn-primary">Join Now <i class="fa-solid fa-arrow-right"></i></a> -->
                <div id="top-bar">
                    <ul>
                        <div class="topbar-divider"></div>
                        <!-- Nav Item - User Information -->
                        <li>
                            <a href="#" id="dropdown-toggle" onclick="dropdown()">
                                <span>${account.firstName} ${account.lastName}</span>
                                <img src="https://cdn.pixabay.com/photo/2014/03/24/13/49/avatar-294480_1280.png">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div id="dropdown-menu">
                                <a class="dropdown-item" href="#">
                                    <i class="fa-solid fa-address-card"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fa-solid fa-gear"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fa-solid fa-list-check"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

        <div id="container">
            <form action="profile" method="POST" onsubmit="return submitForm()">
                <div id="table-header">
                    <span>My profile</span>
                </div>

                <div>
                    <table>                   
                        <% if (isNoti != null) { %>
                        <tr>
                            <td colspan="2">
                                <div id="notification">
                                    <span>Profile has been changed successfully!</span>
                                </div>
                            </td>
                        </tr>
                        <%}%>
                        <tr>
                            <td>First name</td>
                            <td><input type="text" name="firstName" value="${account.firstName}" /></td>
                        </tr>
                        <tr><td colspan="2" id="error-current-password" style="color: red"></td></tr>

                        <tr>
                            <td>Last name</td>
                            <td><input type="text" name="lastName" value="${account.lastName}" /></td>
                        </tr>
                        <tr><td colspan="2" id="error-password" style="color: red"></td></tr>

                        <tr>
                            <td>Gender</td>
                            <td>
                                <input style="width: 15px" type="radio" name="gender" <c:if test="${account.gender==true}">checked="checked"</c:if> value="male" />Male
                                <input style="width: 15px; margin-left: 70px;" type="radio" name="gender" <c:if test="${account.gender==false}">checked="checked"</c:if> value="female" />Female
                                </td>
                            </tr>
                            <tr><td colspan="2" id="error-password" style="color: red"></td></tr>

                            <tr>
                                <td>Phone</td>
                                <td><input type="text" name="phone" value="${account.phone}" /></td>
                        </tr>
                        <tr><td colspan="2" id="error-re-password" style="color: red"></td></tr>

                        <tr>
                            <td>Email</td>
                            <td><input type="text" name="email" value="${account.email}" disabled="disabled"/></td>
                        </tr>
                        <tr><td colspan="2" id="error-re-password" style="color: red"></td></tr>

                        <tr>
                            <td>Address</td>
                            <td><input type="text" name="address" value="${account.address}" /></td>
                        </tr>
                        <tr><td colspan="2" id="error-re-password" style="color: red"></td></tr>

                        <tr>
                            <td colspan="2"><input id="submit-btn" type="submit" value="Save" /></td>
                        </tr>
                    </table>
                </div>
            </form>

            <div id="avatar">
                <img src="https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=" alt="Girl in a jacket" width="250" height="250">
            </div>  
        </div>

        <div class="footer">
            <ul>
                <li>
                    <h4>Contact</h4>
                    <p><i class="fa-solid fa-location-dot"></i>Ha Noi, Viet Nam</p>
                    <p><i class="fa-solid fa-phone"></i>+84 123 456 789</p>
                    <p><i class="fa-solid fa-envelope"></i>Email@gmail.com</p>
                </li>
                <li>
                    <h4>Gallery</h4>
                    <div class="gallery-img">
                        <img src="img/course-1.jpg" alt="">
                        <img src="img/course-2.jpg" alt="">
                        <img src="img/course-3.jpg" alt="">
                        <img src="img/course-3.jpg" alt="">
                        <img src="img/course-1.jpg" alt="">
                        <img src="img/course-2.jpg" alt="">

                    </div>
                </li>
                <li>
                    <h4>Newsletter</h4>
                    <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                </li>
            </ul>
        </div>

        <script>
            function submitForm() {
                var currentPassword = document.getElementById("currentPassword").value;
                var valuePassword = document.getElementById("password").value;
                var valueRePassword = document.getElementById("re-password").value;

                if (currentPassword != <%= account.getPassword()%>) {
                    document.getElementById("error-current-password").innerHTML = "Current password not same as old password";
                    return false;
                } else {
                    document.getElementById("error-current-password").innerHTML = "";
                }
                if (valuePassword.length < 6) {
                    document.getElementById("error-password").innerHTML = "Password must be greater than 6 characters";
                    return false;
                } else {
                    document.getElementById("error-password").innerHTML = "";
                }
                if (valueRePassword != valuePassword) {
                    document.getElementById("error-re-password").innerHTML = "Confirm password not same as password";
                    return false;
                } else {
                    document.getElementById("error-password").innerHTML = "";
                }
                return true;
            }

            function dropdown() {
                var dropdownMenu = document.querySelector('#dropdown-menu');

                if (dropdownMenu.style.display == 'flex') {
                    dropdownMenu.style.display = 'none';
                } else {
                    dropdownMenu.style.display = 'flex';
                }
            }
        </script>
    </body>

</html>