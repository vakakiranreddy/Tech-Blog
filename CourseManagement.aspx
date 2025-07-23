<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseManagement.aspx.cs" Inherits="miniProject.CourseManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Management</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        h3, h4, h5, h6, .card-title, .navbar-brand {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        .card {
            border-radius: 12px;
            transition: all 0.3s ease;
        }

            .card:hover {
                transform: translateY(-4px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

        .form-control, .btn {
            border-radius: 8px;
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
                    <li class="nav-item"><a class="nav-link active" href="CourseManagement.aspx">Course Management</a></li>
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
            <h3 class="mb-4 text-center">Course Management</h3>

            <!-- Top 3 Course Cards -->
            <div class="row" id="topCourseCards" runat="server">
                <!-- Cards injected from code-behind -->
            </div>

            <!-- Count + Refresh Button -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
                <asp:Label ID="lblCourseCount" runat="server" CssClass="fw-bold mb-2"></asp:Label>
                <asp:Button ID="btnRefreshCourses" runat="server" Text="View All Courses" CssClass="btn btn-outline-secondary mb-2" OnClick="btnRefreshCourses_Click" />
            </div>

            <!-- Add / Update Course Form -->
            <div class="card mb-4">
                <div class="card-header">Add / Update Course</div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Title</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Provider</label>
                            <asp:TextBox ID="txtProvider" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-12">
                            <label class="form-label">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Link</label>
                            <asp:TextBox ID="txtLink" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Upload Image</label>
                            <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-12">
                            <asp:HiddenField ID="hdnCourseId" runat="server" />
                            <asp:Button ID="btnSaveCourse" runat="server" Text="Add Course" CssClass="btn btn-primary mt-2" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Full Course List -->
            <div class="table-responsive">
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" OnRowCommand="gvCourses_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="courseid" HeaderText="ID" />
                        <asp:BoundField DataField="title" HeaderText="Title" />
                        <asp:BoundField DataField="provider" HeaderText="Provider" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src='<%# Eval("image") %>' style="height: 60px; width: 100px; object-fit: cover;" class="img-thumbnail" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnEditCourse" runat="server" CommandName="EditCourse" CommandArgument='<%# Eval("courseid") %>' Text="Edit" CssClass="btn btn-sm btn-warning" />
                                <asp:Button ID="btnDeleteCourse" runat="server" CommandName="DeleteCourse" CommandArgument='<%# Eval("courseid") %>' Text="Delete" CssClass="btn btn-sm btn-danger ms-1" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>
