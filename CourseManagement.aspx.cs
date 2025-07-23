using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace miniProject
{
    public partial class CourseManagement : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    UpdateNotificationCount();
                    LoadTop3Courses();        
                    LoadCourseCount();
                    gvCourses.Visible = false; 
                }
                catch (Exception ex)
                {
                    lblCourseCount.Text = "Error loading data: " + ex.Message;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string title = txtTitle.Text.Trim();
                string description = txtDescription.Text.Trim();
                string provider = txtProvider.Text.Trim();
                string link = txtLink.Text.Trim();
                string imagePath = "";

                if (fileImage.HasFile)
                {
                    string fileName = Path.GetFileName(fileImage.PostedFile.FileName);
                    string folderPath = Server.MapPath("~/uploads/");
                    if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                    imagePath = "uploads/" + fileName;
                    fileImage.SaveAs(Path.Combine(folderPath, fileName));
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd;
                    if (string.IsNullOrEmpty(hdnCourseId.Value))
                    {
                        cmd = new SqlCommand("addcourse", conn);
                    }
                    else
                    {
                        cmd = new SqlCommand("updatecourse", conn);
                        cmd.Parameters.AddWithValue("@courseid", hdnCourseId.Value);
                    }

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@provider", provider);
                    cmd.Parameters.AddWithValue("@link", link);
                    cmd.Parameters.AddWithValue("@image", imagePath);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                ClearForm();
                LoadTop3Courses();
                LoadCourseCount();
                LoadAllCourses();
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error saving course: " + ex.Message;
            }
        }
        private void UpdateNotificationCount()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("sp_getnotificationcount", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        notificationCount.InnerText = result.ToString();
                    }
                }
            }
            catch (Exception)
            {
                notificationCount.InnerText = "0";
            }
        }

        protected void gvCourses_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "EditCourse")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("select * from latestcourses where courseid = @id", conn);
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtTitle.Text = reader["title"].ToString();
                            txtDescription.Text = reader["description"].ToString();
                            txtProvider.Text = reader["provider"].ToString();
                            txtLink.Text = reader["link"].ToString();
                            hdnCourseId.Value = reader["courseid"].ToString();
                        }
                    }
                }
                else if (e.CommandName == "DeleteCourse")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("deletecourse", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@courseid", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadTop3Courses();
                    LoadCourseCount();
                    LoadAllCourses();
                }
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error processing course: " + ex.Message;
            }
        }

        protected void btnRefreshCourses_Click(object sender, EventArgs e)
        {
            try
            {
                gvCourses.Visible = true;   
                LoadTop3Courses();
                LoadAllCourses();           
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error refreshing courses: " + ex.Message;
            }
        }

        private void LoadTop3Courses()
        {
            try
            {
                topCourseCards.Controls.Clear();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("select top 3 * from latestcourses order by courseid DESC", conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string title = reader["title"].ToString(); 
                        string desc = reader["description"].ToString();
                        string provider = reader["provider"].ToString();
                        string link = reader["link"].ToString();
                        string image = reader["image"].ToString();

                        string cardHtml = $@"
<div class='col-lg-4 col-md-6 mb-4'>
    <div class='card h-100 shadow-sm border-0 rounded-4' style='transition: transform 0.3s ease;'>
        <img src='{image}' alt='Course Image' class='card-img-top rounded-top-4' style='height:180px; object-fit:cover;' />
        <div class='card-body'>
            <h5 class='card-title text-primary fw-semibold' style='font-family: Poppins, sans-serif;'>{title}</h5>
            <p class='card-text text-muted' style='font-family: Roboto, sans-serif;'>{(desc.Length > 100 ? desc.Substring(0, 100) + "..." : desc)}</p>
            <p class='mb-2 text-secondary'><strong>Provider:</strong> {provider}</p>
            <a href='{link}' class='btn btn-outline-primary btn-sm rounded-pill' target='_blank'>Visit Course</a>
        </div>
    </div>
</div>";


                        topCourseCards.Controls.Add(new LiteralControl(cardHtml));
                    }
                }
            }
            catch (Exception ex)
            {
                topCourseCards.Controls.Add(new LiteralControl("<p class='text-danger'>Error loading top courses: " + ex.Message + "</p>"));
            }
        }

        private void LoadAllCourses()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("select * from latestcourses order by courseid desc", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvCourses.DataSource = dt;
                    gvCourses.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error loading all courses: " + ex.Message;
            }
        }

        private void LoadCourseCount()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("select count(*) from latestcourses", conn);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblCourseCount.Text = "Total Courses: " + count;
                }
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error counting courses: " + ex.Message;
            }
        }

        private void ClearForm()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtProvider.Text = "";
            txtLink.Text = "";
            hdnCourseId.Value = "";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            try
            {
                Session.Clear();
                Response.Redirect("Login.aspx");
            }
            catch (Exception ex)
            {
                lblCourseCount.Text = "Error during logout: " + ex.Message;
            }
        }
    }
}
