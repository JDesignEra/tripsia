using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;

namespace tripsia.DAL
{
    public class Hotel_reviewDAO
    {
        public int Insert(Hotel_review td)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO Hotel_review (review_Id, hotel_id, user_id, name, " +
                                    "review)" +
                             "VALUES (@paraReview_id,@paraHotel_id,@paraUser_id,@paraName," +
                                    "@paraReview)";

            int result = 0;    // Execute NonQuery return an integer value
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraReview_Id", td.review_Id);
            sqlCmd.Parameters.AddWithValue("@paraHotel_id", td.hotel_id);
            sqlCmd.Parameters.AddWithValue("@paraUser_id", td.user_id);
            sqlCmd.Parameters.AddWithValue("@paraReview", td.name);
            sqlCmd.Parameters.AddWithValue("@paraName", td.review);
            
            myConn.Open();
            result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }
        public Hotel_review SelectById(string review_Id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "SELECT * FROM Customer WHERE id = @paraReview_id";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            da.SelectCommand.Parameters.AddWithValue("@paraReview_Id", review_Id);

            DataSet ds = new DataSet();

            da.Fill(ds);

            Hotel_review rev = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string review_id = row["review_id"].ToString();
                string hotel_id = row["hotel_id"].ToString();
                string user_id = row["user_id"].ToString();
                string name = row["name"].ToString();
                string review = row["review"].ToString();
                rev = new Hotel_review(review_id, hotel_id, user_id, name, review);

            }
            else
            {
                rev = null;
            }

            return rev;




        }
    }
}