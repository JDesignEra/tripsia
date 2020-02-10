using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;

namespace tripsia.DAL
{
    public class FnbReviewsDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(FnbReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "INSERT INTO Fnb_Review (review, pid, uid, rating, dateTime) VALUES (@review, @pid, @uid, @rating, @dateTime)";
            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@review", hotelReviews.review);
            cmd.Parameters.AddWithValue("@pid", hotelReviews.pid);
            cmd.Parameters.AddWithValue("@uid", hotelReviews.uid);
            cmd.Parameters.AddWithValue("@rating", hotelReviews.rating);
            cmd.Parameters.AddWithValue("@dateTime", hotelReviews.dateTime);

            conn.Open();
            int result = cmd.ExecuteNonQuery();
            conn.Close();

            return result != 0;
        }

        public DataTable SelectByPidSortByDate(FnbReviews fnbReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM [Fnb_Review] JOIN Users ON [Fnb_Review].uid = Users.id WHERE Fnb_Review.pid = @pid ORDER BY dateTime ASC";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@pid", fnbReviews.pid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }
    }
}