using System;
using System.Web;
using System.Web.UI;

namespace tripsia
{
    public partial class main : System.Web.UI.MasterPage
    {
        public string hostUrl;

        protected void Page_Load(object sender, EventArgs e)
        {
            hostUrl = HttpContext.Current.Request.Url.Authority;
            currYearLbl.Text = DateTime.Now.Year.ToString();

            if (Session["uid"] != null)
            {
                loginRegBtnState.Style.Add("display", "none");
                profileState.Style.Remove("display");
                loginNavState.Style.Remove("display");
            }
            else
            {
                loginRegBtnState.Style.Remove("display");
                profileState.Style.Add("display", "none");
                loginNavState.Style.Add("display", "none");
            }
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Page.ClientScript.RegisterStartupScript(
                this.GetType(),
                "toast",
                "toastSuccess('Logout sucessfully.');",
                true
            );

            Response.AddHeader("REFRESH", "1;URL=default.aspx");
        }
    }
}