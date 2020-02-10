using System;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using tripsia.BLL;
using tripsia.utilities;

namespace tripsia
{
    public partial class Forget_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void forgotPassBtn_Click(object sender, EventArgs e)
        {
            string randPassword = Membership.GeneratePassword(12, 5);

            User user = new User(email: emailTxtBox.Text, password: randPassword).UpdateUserPasswordById();

            if (user != null)
            {
                string emailMsg = string.Format("Dear, {0}<br />" +
                    "<p>It seems that you have forgotten your password.</p>" +
                    "<p>Your password is <strong>{1}</strong>.",
                    user.name, randPassword);

                if (!new SendEmail().Send(user.email, "Forgot Password", ""))
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        "toastDanger('Fail to send email out.');",
                        true
                    );
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
    }
}