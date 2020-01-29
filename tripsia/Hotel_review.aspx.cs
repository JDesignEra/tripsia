using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tripsia.BLL;
using tripsia.DAL;

namespace tripsia
{
    public partial class Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void BtnPost_Click(object sender, EventArgs e)
        {
            Hotel_review hotelObj = new Hotel_review();
            hotelObj = hotelObj.GetHotelReviewById(review_Id);
            if (hotelObj != null)
            {

            }
        }
    }
}