using Pharmacy.Database;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Windows.Forms;
using Pharmacy.WebForms;

namespace Pharmacy.Classes
{
    public class ClassAddresses
    {
        string vReadAddressId, vAddressId;
        int vNewAddressId;
        public string GenerateAddressId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(addressId) FROM Addresses";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadAddressId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadAddressId))
                {
                    vAddressId = "ADD001";
                }
                else
                {
                    vNewAddressId = Convert.ToInt32(vReadAddressId.Substring(3)) + 1;
                    vAddressId = "ADD" + vNewAddressId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vAddressId;
        }
        
        public void ViewAddress(CustomersPage loadAddress)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                
                vAddressId = loadAddress.GridViewCustomers.SelectedRow.Cells[2].Text;
                loadAddress.txViewAddressId.Text = vAddressId;

                string sqlSelectCmd = "SELECT * FROM Addresses where addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                loadAddress.txViewAddressLine1.Text = read[1].ToString();
                loadAddress.txViewAddressLine2.Text = read[2].ToString();
                loadAddress.txViewAddressLine3.Text = read[3].ToString();
                loadAddress.txViewCity.Text = read[4].ToString();
                loadAddress.txViewZipPostCode.Text = read[5].ToString();
                loadAddress.txViewStateProvince.Text = read[6].ToString();
                read.Close();

                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void ViewAddress(PhysiciansPage loadAddress)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vAddressId = loadAddress.GridViewPhysicians.SelectedRow.Cells[2].Text;
                loadAddress.txViewAddressId.Text = vAddressId;

                string sqlSelectCmd = "SELECT * FROM Addresses where addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                loadAddress.txViewAddressLine1.Text = read[1].ToString();
                loadAddress.txViewAddressLine2.Text = read[2].ToString();
                loadAddress.txViewAddressLine3.Text = read[3].ToString();
                loadAddress.txViewCity.Text = read[4].ToString();
                loadAddress.txViewZipPostCode.Text = read[5].ToString();
                loadAddress.txViewStateProvince.Text = read[6].ToString();
                read.Close();

                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}