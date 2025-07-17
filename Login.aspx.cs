using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace miniProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string hashedPassword = GetHash(password);

            string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("loginuser", conn); // lowercase name
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@passwordhash", hashedPassword);

                try
                {
                    conn.Open();
                    object roleObj = cmd.ExecuteScalar();

                    if (roleObj != null)
                    {
                        string role = roleObj.ToString().ToLower(); // normalize role string
                        Session["Email"] = email;
                        Session["Role"] = role;

                        if (role == "admin")
                            Response.Redirect("AdminHome.aspx");
                        else
                            Response.Redirect("UserHome.aspx"); // updated name
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        private string GetHash(string text)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(text));
                return Convert.ToBase64String(bytes);
            }
        }
    }
}
