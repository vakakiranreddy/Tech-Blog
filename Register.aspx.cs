using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

namespace miniProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Server-side validations
            if (!IsValidEmail(email))
            {
                lblMessage.Text = "Please enter a valid Gmail address.";
                lblMessage.CssClass = "form-text text-danger";
                return;
            }

            if (!IsValidPassword(password))
            {
                lblMessage.Text = "Password must be 6–12 chars, 1 uppercase, 1 special character.";
                lblMessage.CssClass = "form-text text-danger";
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                lblMessage.CssClass = "form-text text-danger";
                return;
            }

            string hashedPassword = GetHash(password);
            string role = "user";
            string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("adduser", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fullname", name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@passwordhash", hashedPassword);
                cmd.Parameters.AddWithValue("@role", role);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "User registered successfully!";
                    lblMessage.CssClass = "form-text text-success";

                    // Optional: clear fields after success
                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
                catch (SqlException ex)
                {
                    lblMessage.CssClass = "form-text text-danger";
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

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new MailAddress(email);
                return addr.Address == email && email.ToLower().EndsWith("@gmail.com");
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPassword(string password)
        {
            if (password.Length < 6 || password.Length > 12)
                return false;

            bool hasUpper = false;
            bool hasDigit = false;

            foreach (char c in password)
            {
                if (char.IsUpper(c)) hasUpper = true;
                if (char.IsDigit(c)) hasDigit = true;
            }

            return hasUpper && hasDigit;
        }
    }
}
