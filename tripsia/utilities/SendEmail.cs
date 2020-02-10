using System;
using System.Net.Mail;

namespace tripsia.utilities
{
    public class SendEmail
    {
        public bool Send(string toEmail, string subject, string msg = null)
        {
            SmtpClient client = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new System.Net.NetworkCredential("dev.projectemail123789456@gmail.com", "eadpproject2020"),
            };

            MailMessage mail = new MailMessage
            {
                From = new MailAddress("dev.shaunnp@gmail.com", "AIRMAZE"),
                Subject = subject,
                IsBodyHtml = true,
                Body = string.Format("<html><head></head><body>{0}</body></html>", msg),
            };

            mail.To.Add(new MailAddress(toEmail));

            try
            {
                client.Send(mail);
            }
            catch (Exception e)
            {
                return false;
            }

            return true;
        }
    }
}