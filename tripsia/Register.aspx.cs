using System;
using System.Net.Mail;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void regBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                User user = new User(email: emailTxtBox.Text.ToString(), password: passTxtBox.Text.ToString(), name: nameTxtBox.Text.ToString());

                if (!user.CreateUser())
                {
                    emailValidator.ErrorMessage = "Email is already registered with us.";
                    emailValidator.IsValid = false;
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        string.Format("toastSuccess('<strong>{0}</strong> registered successfully.');", user.email),
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=login.aspx");
                }
            }
        }

        protected void EmailValidate(object sender, ServerValidateEventArgs e)
        {
            try
            {
                MailAddress email = new MailAddress(e.Value.ToString());
            }
            catch (FormatException)
            {
                emailValidator.ErrorMessage = "Email format is invalid.";
                e.IsValid = false;
            }
        }

        protected void PasswordValidate(object sender, ServerValidateEventArgs e)
        {
            if (!e.Value.ToString().Equals(cfmPassTxtBox.Text.ToString()))
            {
                passValidator.ErrorMessage = "Password does not match with Confirm Password.";
                e.IsValid = false;

                cfmPassValidator.ErrorMessage = "Confirm Password does not match with Password.";
                cfmPassValidator.IsValid = false;
            }
        }

        protected void CfmPasswordValidate(object sender, ServerValidateEventArgs e)
        {
            if (!e.Value.ToString().Equals(passTxtBox.Text.ToString()))
            {
                passValidator.ErrorMessage = "Password does not match with Password.";
                passValidator.IsValid = false;

                cfmPassValidator.ErrorMessage = "Confirm Password does not match with Password.";
                e.IsValid = false;
            }
        }
    }
}