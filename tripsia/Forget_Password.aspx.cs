using System;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class Forget_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void forgotPassBtn_Click(object sender, EventArgs e)
        {
            User user = new User(email: emailTxtBox.Text);

            if (user != null)
            {
                SendEmail(user.email, user.name, user.password);
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

        private void SendEmail(params string[] args)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                mail.IsBodyHtml = true;
                mail.From = new MailAddress("projectemail123789456@gmail.com");
                mail.To.Add(args[0]);
                mail.Subject = "Forget Password";
                mail.Body =
                mail.Body = string.Format("Dear, {0}<br />" +
                    "<p>You have send a request to have a new password as you forgetten your old password.</p>" +
                    "<p>Your password is <strong>{1}</strong>.",
                    args[1], args[2]);

                SmtpServer.Credentials = new System.Net.NetworkCredential("projectemail123789456@gmail.com", "eadpproject2020");
                SmtpServer.EnableSsl = true;

                SmtpServer.Send(mail);
            }
            catch
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
}