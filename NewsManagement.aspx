<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsManagement.aspx.cs" Inherits="miniProject.NewsManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>News Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
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
                    <li class="nav-item"><a class="nav-link active" href="NewsManagement.aspx">News Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="GadgetManagement.aspx">Gadget Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                    <li class="nav-item"><a class="nav-link active" href="EmailNotification.aspx">Notification Management</a></li>
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
            <h3 class="mb-4">News Management</h3>

            <!-- Top 3 News Cards -->
            <div class="row" id="topNewsCards" runat="server">
                <!-- Cards injected from code-behind -->
            </div>

            <!-- News Count and View Button -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <asp:Label ID="lblNewsCount" runat="server" CssClass="fw-bold"></asp:Label>
                <asp:Button ID="btnRefreshNews" runat="server" Text="View All News" CssClass="btn btn-outline-secondary" OnClick="btnRefreshNews_Click" />
            </div>

            <!-- Add / Update News Form -->
            <div class="card mb-4">
                <div class="card-header">Add / Update News</div>
                <div class="card-body">
                    <div class="mb-3">
                        <label>Title</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Content</label>
                        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Upload Image</label>
                        <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control" />
                    </div>
                    <asp:HiddenField ID="hdnNewsId" runat="server" />
                    <asp:Button ID="btnSave" runat="server" Text="Add News" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                </div>
            </div>

            <!-- Full News List -->
            <asp:GridView ID="gvNews" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="gvNews_RowCommand">
                <Columns>
                    <asp:BoundField DataField="newsid" HeaderText="ID" />
                    <asp:BoundField DataField="title" HeaderText="Title" />
                    <asp:BoundField DataField="posteddate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# Eval("image") %>' style="height: 60px; width: 100px; object-fit: cover;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="EditNews" CommandArgument='<%# Eval("newsid") %>' Text="Edit" CssClass="btn btn-sm btn-warning" />
                            <asp:Button ID="btnDelete" runat="server" CommandName="DeleteNews" CommandArgument='<%# Eval("newsid") %>' Text="Delete" CssClass="btn btn-sm btn-danger ms-1" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
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
