using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tripsia
{
    public partial class Airlines_Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //if (Session["uid"] != null && Page.IsValid)
            //{
            BLL.ReviewAir reviewAir = new BLL.ReviewAir(
                subject: tbSubject.Text.ToString(),
                description: tbDesc.Text.ToString(),
                rating: int.Parse(ddlRating.SelectedValue),
                uid: 1337420//int.Parse(Session["uid"].ToString())
                );

            if (reviewAir.Create())
            {
                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    string.Format("toastSuccess('Review created.');"),
                    true
                );

                Response.AddHeader("REFRESH", "1;URL=itineraries.aspx");
            }
            //else
            //{
                //newTitleValidator.ErrorMessage = "There is already an itinerary with that Title, please enter a diffferent title.";
                //newTitleValidator.IsValid = false;

                //Page.ClientScript.RegisterStartupScript(this.GetType(), "modal", string.Format("showModal('#newModal');"), true);
            //}
            //}
        }
    }
}