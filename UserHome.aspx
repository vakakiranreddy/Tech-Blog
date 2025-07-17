<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="miniProject.UserHome" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet" />

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        h1, h2, h3, h4, h5, h6, .card-title {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        .card {
            border-radius: 12px;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand" href="UserHome.aspx">TechBlog</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link active" href="#newsSection">Tech News</a></li>
                        <li class="nav-item"><a class="nav-link" href="#gadgetSection">Gadgets</a></li>
                        <li class="nav-item"><a class="nav-link" href="#courseSection">Courses</a></li>
                    </ul>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>
         <div id="google_translate_element" style="float: right; margin: 10px;"></div>
        <div class="container mt-4">
            <h2 class="mb-4 text-center">Welcome to TechBlog 👋</h2>

            <!-- Tech News Section -->
            <h4 class="mb-3" id="newsSection">Latest Tech News</h4>
            <div class="row" id="newsContainer" runat="server"></div>

            <!-- Gadgets Section -->
            <h4 class="mt-5 mb-3" id="gadgetSection">Latest Gadgets</h4>
            <div class="row" id="gadgetsContainer" runat="server"></div>

            <!-- Courses Section -->
            <h4 class="mt-5 mb-3" id="courseSection">Latest Courses</h4>
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
