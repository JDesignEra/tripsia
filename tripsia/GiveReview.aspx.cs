using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace EADP_Project.Pages
{
    public partial class GiveReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlgr = "Insert into Review (Subject, Description, Rating) Values (@paraSubject, @paraDescription, @paraRating)";
            SqlCommand sqlCmd = new SqlCommand(sqlgr, myConn);

            sqlCmd.Parameters.AddWithValue("@paraSubject", tbSubject.Text);
            sqlCmd.Parameters.AddWithValue("@paraDescription", tbDesc.Text);
            sqlCmd.Parameters.AddWithValue("@paraRating", Int64.Parse(ddlRating.SelectedValue));

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            lblResult.Text = "Successfully Sent Review";
            
        }
    }
}