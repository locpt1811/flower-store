<%-- 
    Document   : header_loginedAdmin
    Created on : 20-Mar-2023, 17:44:46
    Author     : Tan Loc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="style/header.css" type="text/css"/>
    </head>
    <body>
        <header class="p-3 mb-3 border-bottom">
            <div class="container">
                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <a href="adminPage.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
                        <img src="images/logo.jpg" alt="Logo" width="40" height="32" class="me-2">
                    </a>

                    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                        <li><a href="mainController?action=manageAccounts" class="nav-link px-2 link-secondary">Manage Accounts</a></li>
                        <li><a href="mainController?action=manageOrders" class="nav-link px-2 link-dark">Manage Orders</a></li>
                        <li><a href="mainController?action=managePlants" class="nav-link px-2 link-dark">Manage Plants</a></li>
                        <li><a href="mainController?action=manageCategories" class="nav-link px-2 link-dark">Manage Categories</a></li>
                        <li><a href="index.jsp" class="nav-link px-2 link-dark">Shopping</a></li>
                    </ul>

                    <div class="dropdown text-end">
                        <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="images/admin.jpg" alt="mdo" width="32" height="32" class="rounded-circle">
                        </a>
                        <ul class="dropdown-menu text-small">
                            <li> <a class="dropdown-item" href="personalPage.jsp">View Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="mainController?action=logout">Log out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </body>
</html>
