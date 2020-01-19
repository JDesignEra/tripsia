using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;

namespace tripsia.DAL
{
    public class UserDAO
    {
        private string db = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        public bool Insert(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE email = @email";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@email", user.email);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count < 1)
            {
                sql = "INSERT INTO Users (email, password, name) VALUES (@email, @password, @name)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@email", user.email);
                cmd.Parameters.AddWithValue("@password", user.password);
                cmd.Parameters.AddWithValue("@name", user.name);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                return result != 0;
            }

            return false;
        }

        public User SelectByEmailAndPassword(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE email = @email AND password = @password";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@email", user.email);
            da.SelectCommand.Parameters.AddWithValue("@password", user.password);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["name"].ToString(), row["name"].ToString());
            }

            return null;
        }

        public User SelectById(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE id = @id";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", user.id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["password"].ToString(), row["name"].ToString());
            }

            return null;
        }
    }
}