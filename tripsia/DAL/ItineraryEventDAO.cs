using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;

namespace tripsia.DAL
{
    public class ItineraryEventDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(ItineraryEvent itineraryEvent)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary_Event WHERE iid = @iid AND dateTime = @dateTime";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@iid", itineraryEvent.iid);
            da.SelectCommand.Parameters.AddWithValue("@dateTime", itineraryEvent.dateTime);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count < 1)
            {
                sql = "INSERT INTO Itinerary_Event (iid, title, description, dateTime) VALUES (@iid, @title, @description, @dateTime)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@iid", itineraryEvent.iid);
                cmd.Parameters.AddWithValue("@title", itineraryEvent.title);
                cmd.Parameters.AddWithValue("@description", itineraryEvent.description);
                cmd.Parameters.AddWithValue("@dateTime", itineraryEvent.dateTime);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }
            
            return false;
        }

        public bool UpdateById(ItineraryEvent itineraryEvent)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary_Event WHERE id = @id";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", itineraryEvent.id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                sql = "UPDATE Itinerary_Event SET title = @title, description = @description, dateTime = @dateTime WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@id", itineraryEvent.id);
                cmd.Parameters.AddWithValue("@title", itineraryEvent.title);
                cmd.Parameters.AddWithValue("@description", itineraryEvent.description);
                cmd.Parameters.AddWithValue("@dateTime", itineraryEvent.dateTime);;

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }

            return false;
        }

        public DataTable getByDate(ItineraryEvent itineraryEvent)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Itinerary_Event WHERE iid = @iid AND CAST(dateTime AS date) = @date ORDER BY dateTime ASC";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@iid", itineraryEvent.iid);
            da.SelectCommand.Parameters.AddWithValue("@date", itineraryEvent.dateTime);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public DataTable SelectDateNoDupeByIid(ItineraryEvent itineraryEvent)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT DISTINCT CAST(dateTime AS DATE) AS dateTime FROM Itinerary_Event WHERE iid = @iid ORDER BY dateTime ASC";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@iid", itineraryEvent.iid);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds.Tables[0];
            }

            return null;
        }

        public bool DeleteByIid(ItineraryEvent itineraryEvent)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "DELETE FROM Itinerary_Event WHERE iid = @iid";
            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@iid", itineraryEvent.iid);

            conn.Open();
            int result = cmd.ExecuteNonQuery();
            conn.Close();

            return result != 0;
        }
    }
}