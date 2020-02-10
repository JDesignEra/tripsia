using System;
using System.Net.Mail;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    nameTxtBox.Text = Session["name"].ToString();
                    emailTxtBox.Text = Session["email"].ToString();
                }
            }
        }

        protected void saveBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                User user = new User(
                    int.Parse(Session["uid"].ToString()),
                    emailTxtBox.Text,
                    !string.IsNullOrEmpty(passTxtBox.Text) ? passTxtBox.Text : null,
                    nameTxtBox.Text
                ).UpdateUserById();

                if (user != null)
                {
                    Session["uid"] = user.id;
                    Session["name"] = user.name;
                    Session["email"] = user.email;

                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        "toastSuccess('Profile updated successfully.');",
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=profile.aspx");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        "toastDanger('Fail to update profile.');",
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

        protected void PasswordValidate(object sender, ServerValidateEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Value.ToString()))
            {
                if (!e.Value.ToString().Equals(cfmPassTxtBox.Text.ToString()))
                {
                    passValidator.ErrorMessage = "Password does not match with Confirm Password.";
                    e.IsValid = false;

                    cfmPassValidator.ErrorMessage = "Confirm Password does not match with Password.";
                    cfmPassValidator.IsValid = false;
                }
                else if (e.Value.Length < 8)
                {
                    passValidator.ErrorMessage = "Password has to be 8 characters or more.";
                    e.IsValid = false;
                }
            }
        }

        protected void CfmPasswordValidate(object sender, ServerValidateEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Value.ToString()))
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
}