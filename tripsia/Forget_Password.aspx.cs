using System;
using System.Net;
using System.Net.Mail;
using System.Web.Security;
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
            string randPassword = Membership.GeneratePassword(12, 5);

            User user = new User(email: emailTxtBox.Text, password: randPassword).UpdateUserPasswordById();

            if (user != null)
            {
                SendEmail(user.email, user.name, randPassword);
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
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com", 587);

                mail.IsBodyHtml = true;
                mail.From = new MailAddress("projectemail123789456@gmail.com");
                mail.To.Add(args[0]);
                mail.Subject = "Forget Password";
                mail.Body =
                mail.Body = string.Format("Dear, {0}<br />" +
                    "<p>It seems that you have forgotten your password.</p>" +
                    "<p>Your password is <strong>{1}</strong>.",
                    args[1], args[2]);

                SmtpServer.Credentials = new NetworkCredential("projectemail123789456@gmail.com", "eadpproject2020");
                SmtpServer.EnableSsl = true;

                SmtpServer.Send(mail);
            }
            catch (Exception e)
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