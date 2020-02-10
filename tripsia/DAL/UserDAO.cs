using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using tripsia.BLL;
using tripsia.utilities;

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
                cmd.Parameters.AddWithValue("@password", new PasswordUtilities().Hash(user.password));
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

            string sql = "SELECT * FROM Users WHERE email = @email";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@email", user.email);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                if (new PasswordUtilities().HashCheck(user.password, row["password"].ToString()))
                {
                    return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["password"].ToString(), row["name"].ToString());
                }

                return null;
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

        public User SelectByEmail(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE email = @email";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@email", user.email);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["password"].ToString(), row["name"].ToString());
            }

            return null;
        }

        public User UpdateById(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE id = @id";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@id", user.id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            DataRow row = ds.Tables[0].Rows[0];

            if (ds.Tables[0].Rows.Count == 1)
            {
                sql = "UPDATE Users SET email = @email, password = @password, name = @name WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@email", user.email);
                cmd.Parameters.AddWithValue("@password", !string.IsNullOrEmpty(user.password) ? new PasswordUtilities().Hash(row["password"].ToString()) : user.password);
                cmd.Parameters.AddWithValue("@name", user.name); ;
                cmd.Parameters.AddWithValue("@id", user.id);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                if (result > 0)
                {
                    sql = "SELECT * FROM Users WHERE id = @id";
                    da = new SqlDataAdapter(sql, conn);
                    da.SelectCommand.Parameters.AddWithValue("@id", user.id);

                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        row = ds.Tables[0].Rows[0];

                        return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["password"].ToString(), row["name"].ToString());
                    }
                }

                return null;
            }

            return null;
        }

        public User UpdatePasswordByEmail(User user)
        {
            SqlConnection conn = new SqlConnection(db);

            string sql = "SELECT * FROM Users WHERE email = @email";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.SelectCommand.Parameters.AddWithValue("@email", user.email);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];

                sql = "UPDATE Users SET password = @password WHERE email = @email";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@password", !string.IsNullOrEmpty(user.password) ? new PasswordUtilities().Hash(row["password"].ToString()) : user.password);
                cmd.Parameters.AddWithValue("@email", user.email);

                conn.Open();
                int result = cmd.ExecuteNonQuery();
                conn.Close();

                if (result > 0)
                {
                    sql = "SELECT * FROM Users WHERE email = @email";
                    da = new SqlDataAdapter(sql, conn);
                    da.SelectCommand.Parameters.AddWithValue("@email", user.email);

                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        row = ds.Tables[0].Rows[0];

                        return new User(int.Parse(row["id"].ToString()), row["email"].ToString(), row["password"].ToString(), row["name"].ToString());
                    }
                }

                return null;
            }

            return null;
        }
    }
}