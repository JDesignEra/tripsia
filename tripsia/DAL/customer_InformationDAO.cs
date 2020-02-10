using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using tripsia.BLL;
using tripsia.DAL;

namespace tripsia.DAL
{
    public class customer_informationDAO
    {
        public Customer_information SelectById(string id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "SELECT * FROM Customer_info WHERE id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            DataSet ds = new DataSet();

            da.Fill(ds);

            Customer_information cus = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record

                string name = row["tdName"].ToString();
                string ic = row["tdIc"].ToString();
                string address = row["tdAddress"].ToString();
                string mobile = row["tdMobile"].ToString();
                cus = new Customer_information(id, name, ic, address, mobile);

            }
            else
            {
                cus = null;
            }

            return cus;




        }
    }
}