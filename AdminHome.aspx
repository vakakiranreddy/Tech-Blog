<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="miniProject.AdminHome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet" />

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        h1, h2, h3, h4, h5, h6, .card-title, .summary-card h5 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        .card {
            border-radius: 12px;
            transition: transform 0.3s ease;
        }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
            }

        .summary-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(to right, #007BFF, #00BFFF);
            color: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

            .summary-card h5 {
                margin: 0;
                font-size: 20px;
            }

            .summary-card span,
            .summary-card .fs-3 {
                font-size: 32px;
                font-weight: bold;
            }
    </style>
</head>

<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminHome.aspx">TechBlog Admin</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="AdminHome.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="UserManagement.aspx">User Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="NewsManagement.aspx">News Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="GadgetManagement.aspx">Gadget Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="EmailNotification.aspx">Notification Management</a></li>
                </ul>
                <a href="BellIcon.aspx" class="btn btn-outline-light position-relative">🔔
<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificationCount" runat="server">0</span>
                </a>

                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light ms-2" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>
        <div id="google_translate_element" style="float: right; margin: 10px;"></div>


        <div class="container mt-4">
            <h2 class="mb-4 text-center">Welcome, Admin!</h2>

            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="summary-card">
                        <h5>Total Users</h5>
                        <asp:Label ID="lblUserCount" runat="server" CssClass="fs-3"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- Tech News Section -->
            <h4 class="mb-3">Latest Tech News</h4>
            <div class="row" id="newsContainer" runat="server"></div>

            <!-- Gadget Section -->
            <h4 class="mt-5 mb-3">Latest Gadgets</h4>
            <div class="row" id="gadgetsContainer" runat="server"></div>

            <!-- Courses Section -->
            <h4 class="mt-5 mb-3">Latest Courses</h4>
            <div class="row" id="coursesContainer" runat="server"></div>
        </div>
    </form>
    <script type="text/javascript">
        function googleTranslateElementInit() {
            new google.translate.TranslateElement(
                {
                    pageLanguage: 'en',
                    includedLanguages: 'hi,te,en',
                    layout: google.translate.TranslateElement.InlineLayout.SIMPLE
                },
                'google_translate_element'
            );
        }
    </script>
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
