using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace miniProject
{
    public partial class UserHome : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Role"] == null || Session["Role"].ToString() != "user")
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                LoadNews();
                LoadGadgets();
                LoadCourses();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        private void LoadNews()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 3 title, content, image FROM latesttechnews ORDER BY posteddate DESC", con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string title = reader["title"].ToString();
                        string content = reader["content"].ToString();
                        string image = reader["image"].ToString();

                        newsContainer.Controls.Add(new LiteralControl($@"
                            <div class='col-md-4 mb-3'>
                                <div class='card h-100'>
                                    <img src='{image}' class='card-img-top' style='height:180px; object-fit:cover;' />
                                    <div class='card-body'>
                                        <h5 class='card-title'>{title}</h5>
                                        <p class='card-text'>{(content.Length > 100 ? content.Substring(0, 100) + "..." : content)}</p>
                                    </div>
                                </div>
                            </div>"));
                    }
                }
            }
            catch (Exception)
            {
                // Handle errors silently or log
            }
        }

        private void LoadGadgets()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 3 name, description, image FROM latestgadgets ORDER BY releasedate DESC", con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string name = reader["name"].ToString();
                        string desc = reader["description"].ToString();
                        string image = reader["image"].ToString();

                        gadgetsContainer.Controls.Add(new LiteralControl($@"
                            <div class='col-md-4 mb-3'>
                                <div class='card h-100'>
                                    <img src='{image}' class='card-img-top' style='height:180px; object-fit:cover;' />
                                    <div class='card-body'>
                                        <h5 class='card-title'>{name}</h5>
                                        <p class='card-text'>{(desc.Length > 100 ? desc.Substring(0, 100) + "..." : desc)}</p>
                                    </div>
                                </div>
                            </div>"));
                    }
                }
            }
            catch (Exception)
            {
                // Handle errors silently or log
            }
        }

        private void LoadCourses()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 3 title, description, image FROM latestcourses", con);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string title = reader["title"].ToString();
                        string desc = reader["description"].ToString();
                        string image = reader["image"].ToString();

                        coursesContainer.Controls.Add(new LiteralControl($@"
                            <div class='col-md-4 mb-3'>
                                <div class='card h-100'>
                                    <img src='{image}' class='card-img-top' style='height:180px; object-fit:cover;' />
                                    <div class='card-body'>
                                        <h5 class='card-title'>{title}</h5>
                                        <p class='card-text'>{(desc.Length > 100 ? desc.Substring(0, 100) + "..." : desc)}</p>
                                    </div>
                                </div>
                            </div>"));
                    }
                }
            }
            catch (Exception)
            {
                // Handle errors silently or log
            }
        }
    }
}
