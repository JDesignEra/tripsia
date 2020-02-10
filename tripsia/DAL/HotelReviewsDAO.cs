using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;

namespace tripsia.DAL
{
    public class HotelReviewsDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(HotelReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "INSERT INTO Hotel_Review (review, pid, uid, rating, dateTime) VALUES (@review, @pid, @uid, @rating, @dateTime)";
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

        public bool UpdateById(HotelReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Hotel_Review WHERE id = @id AND uid = @uid";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", hotelReviews.id);
            da.SelectCommand.Parameters.AddWithValue("@uid", hotelReviews.uid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                sql = "UPDATE Hotel_Review SET review = @review, rating = @rating, dateTime = @dateTime WHERE id = @id AND uid = @uid";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@review", hotelReviews.review);
                cmd.Parameters.AddWithValue("@rating", hotelReviews.rating);
                cmd.Parameters.AddWithValue("@dateTime", hotelReviews.dateTime);
                cmd.Parameters.AddWithValue("@id", hotelReviews.id); ;
                cmd.Parameters.AddWithValue("@uid", hotelReviews.uid); ;

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }

            return false;
        }

        public DataTable SelectByPidSortByDate(HotelReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM [Hotel_Review] JOIN Users ON [Hotel_Review].uid = Users.id WHERE Hotel_Review.pid = @pid ORDER BY dateTime ASC";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@pid", hotelReviews.pid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public DataTable SelectByUidSortByDate(HotelReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Hotel_Review WHERE uid = @uid ORDER BY dateTime ASC";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@uid", hotelReviews.uid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public bool DeleteById(HotelReviews hotelReviews)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "DELETE FROM Hotel_Review WHERE id = @id";
            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@id", hotelReviews.id);

            conn.Open();
            int result = cmd.ExecuteNonQuery();
            conn.Close();

            return result != 0;
        }
    }
}