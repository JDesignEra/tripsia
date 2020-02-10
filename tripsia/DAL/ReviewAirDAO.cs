using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace tripsia.DAL
{
    public class ReviewAirDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(BLL.ReviewAir ReviewAir)
        {
            SqlConnection conn = new SqlConnection(db);
            

            DataSet ds = new DataSet();

            string sql = "INSERT INTO ReviewAirline (uid, subject, description, rating) VALUES (@uid, @subject, @description, @rating)";
            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@subject", ReviewAir.Subject);
            cmd.Parameters.AddWithValue("@description", ReviewAir.Description);
            cmd.Parameters.AddWithValue("@uid", ReviewAir.Uid);
            cmd.Parameters.AddWithValue("@rating", ReviewAir.Rating);

            conn.Open();
            int result = cmd.ExecuteNonQuery();
            conn.Close();

            return result != 0;
        }

    }
}