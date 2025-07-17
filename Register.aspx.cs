using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace miniProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (name == "" || email == "" || password == "")
            {
                lblMessage.Text = "Please fill all fields.";
                return;
            }

            string hashedPassword = GetHash(password);
            string role = "user"; // <-- matches DB check constraint

            string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("adduser", con); // use lowercase stored procedure name
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fullname", name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@passwordhash", hashedPassword);
                cmd.Parameters.AddWithValue("@role", role);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.CssClass = "form-text text-success";
                    lblMessage.Text = "User registered successfully!";
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("UNIQUE"))
                        lblMessage.Text = "Email already exists.";
                    else
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
