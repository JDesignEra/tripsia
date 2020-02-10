using System;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class Login : System.Web.UI.Page
    {

        protected string toastMsg { get { return Session["name"].ToString(); } }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                User user = new User(email: emailTxtBox.Text.ToString(), password: passTxtBox.Text.ToString()).Login();

                if (user != null)
                {
                    Session["uid"] = user.id;
                    Session["email"] = user.email;
                    Session["name"] = user.name;

                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        string.Format("toastSuccess('Welcome back, <strong>{0}</strong>');", user.name),
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=default.aspx");
                }
                else
                {
                    emailValidator.ErrorMessage = "Invalid login credentials";
                    emailValidator.IsValid = false;
                }
            }
        }

        protected void EmailValidate(object source, ServerValidateEventArgs e)
        {
            try
            {
                MailAddress email = new MailAddress(e.Value.ToString());
            }
            catch (FormatException)
            {
                emailValidator.ErrorMessage = "Invalid email format.";
                e.IsValid = false;
            }
        }
    }
}