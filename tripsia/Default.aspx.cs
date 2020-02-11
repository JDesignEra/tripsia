using System;

namespace tripsia
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                loginLink.Style.Add("display", "none !important");
                registerLink.Style.Add("display", "none !important");
            }
        }
    }
}