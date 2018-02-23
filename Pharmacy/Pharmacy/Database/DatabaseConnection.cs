using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Pharmacy.Database
{
    public class DatabaseConnection
    {
        public static SqlConnection dbConnection;
        public void openConnection()
        {
            dbConnection = new SqlConnection("Data Source=CRAZY-PC\\SQL;Initial Catalog=Pharmacy;Integrated Security=True");
            dbConnection.Open();
        }

        public void closeConnection()
        {
            dbConnection.Close();
        }
    }
}