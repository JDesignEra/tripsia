using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace tripsia.DAL
{
    public class ItineraryDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(BLL.Itinerary itinerary)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary WHERE uid = @uid AND title = @title";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@uid", itinerary.uid);
            da.SelectCommand.Parameters.AddWithValue("@title", itinerary.title);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count < 1)
            {
                sql = "INSERT INTO Itinerary (title, description, uid) VALUES (@title, @description, @uid)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@title", itinerary.title);
                cmd.Parameters.AddWithValue("@description", itinerary.description);
                cmd.Parameters.AddWithValue("@uid", itinerary.uid);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }

            return false;
        }

        public bool UpdateByUidAndTitle(BLL.Itinerary itinerary)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary WHERE id != @id AND uid = @uid AND title = @title";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", itinerary.id);
            da.SelectCommand.Parameters.AddWithValue("@uid", itinerary.uid);
            da.SelectCommand.Parameters.AddWithValue("@title", itinerary.title);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count < 1)
            {
                sql = "SELECT * FROM Itinerary WHERE id = @id AND uid = @uid";
                da = new SqlDataAdapter(sql, conn);
                da.SelectCommand.Parameters.AddWithValue("@id", itinerary.id);
                da.SelectCommand.Parameters.AddWithValue("@uid", itinerary.uid);

                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sql = "UPDATE Itinerary SET title = @title, description = @description WHERE id = @id AND uid = @uid";
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    cmd.Parameters.AddWithValue("@id", itinerary.id);
                    cmd.Parameters.AddWithValue("@title", itinerary.title);
                    cmd.Parameters.AddWithValue("@description", itinerary.description);
                    cmd.Parameters.AddWithValue("@uid", itinerary.uid);

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();
                    conn.Close();

                    return result != 0;
                }

                return false;
            }

            return false;
        }

        public DataTable SelectById(BLL.Itinerary itinerary)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary WHERE id = @id";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", itinerary.id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public DataTable SelectByUid(BLL.Itinerary itinerary)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary WHERE uid = @uid";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@uid", itinerary.uid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public bool DeleteItinerary(BLL.Itinerary itinerary)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary WHERE id = @id AND uid = @uid";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", itinerary.id);
            da.SelectCommand.Parameters.AddWithValue("@uid", itinerary.uid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                sql = "DELETE FROM Itinerary WHERE id = @id AND uid = @uid";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@id", itinerary.id);
                cmd.Parameters.AddWithValue("@uid", itinerary.uid);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }

            return false;
        }
    }
}