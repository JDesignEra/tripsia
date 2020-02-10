using System;
using System.Data;
using System.Web.UI;
using tripsia.BLL;

namespace tripsia
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                Page.Title = string.Format("Tripsia | {0}'s Profile", Session["name"]);

                DataTable hotelReviews = new HotelReviews(uid: int.Parse(Session["uid"].ToString())).getByUidSortByDate();

                if (hotelReviews != null)
                {
                    hotelReviewsRepeater.DataSource = hotelReviews;
                    hotelReviewsRepeater.DataBind();

                    hotelsReview.Style.Remove("display");
                    emptyHotelReview.Style.Add("display", "none !important");
                }
            }
        }
    }
}