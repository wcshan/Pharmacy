using Pharmacy.Database;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Windows.Forms;
using Pharmacy.WebForms;
using System.Web.UI;

namespace Pharmacy.Classes
{
    public class ClassCustomer
    {
        string vCustomerId, vReadCustomerId, vCustomerName, vAddressId, vDateBecomeCustomer, vCreditCardNo, vCCExpireDate, vLine01, vLine02, vLine03, vCity, vStateProvince, vZipPostal;
        int vNewCustomerId;
        public string GenerateCustomerId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(customerId) FROM Customers";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadCustomerId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadCustomerId))
                {
                    vCustomerId = "CUS001";
                }
                else
                {
                    vNewCustomerId = Convert.ToInt32(vReadCustomerId.Substring(3)) + 1;
                    vCustomerId = "CUS" + vNewCustomerId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vCustomerId;
        }

        public void addNewCustomer(CustomersPage addCustomer)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vCustomerId = addCustomer.txCustomerId.Text;
                vCustomerName = addCustomer.txCustomerName.Text;
                vAddressId = addCustomer.ddAddress.SelectedValue;
                vDateBecomeCustomer = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
                vCreditCardNo = addCustomer.txCreditCardNo.Text;
                vCCExpireDate = addCustomer.txCardExpireDate.Text;
                vLine01 = addCustomer.txAddressLine1.Text;
                vLine02 = addCustomer.txAddressLine2.Text;
                vLine03 = addCustomer.txAddressLine3.Text;
                vCity = addCustomer.txCity.Text;
                vStateProvince = addCustomer.txStateProvince.Text;
                vZipPostal = addCustomer.txZipPostCode.Text;

                if (addCustomer.rbListAddress.SelectedIndex == 0)
                {
                    vAddressId = addCustomer.txNewAddressId.Text;
                    string sqlInsertCom = "INSERT INTO Addresses VALUES('" + vAddressId + "', '" + vLine01 + "', '" + vLine02 + "', '" + vLine03 + "', '" + vCity + "', '" + vZipPostal + "', '" + vStateProvince + "')";
                    SqlCommand com = new SqlCommand(sqlInsertCom, DatabaseConnection.dbConnection);
                    com.ExecuteNonQuery();
                }

                string sqlInsertCmd = "INSERT INTO Customers VALUES('" + vCustomerId + "', '" + vAddressId + "', '" + vCustomerName + "', '" + vDateBecomeCustomer + "', '" + vCreditCardNo + "', '" + vCCExpireDate + "')";
                SqlCommand cmd = new SqlCommand(sqlInsertCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection(); 
                ScriptManager.RegisterClientScriptBlock(addCustomer, this.GetType(), "SweetAlert", "swal('Success!', 'New Customer Registered', 'success').then(function(){window.location='CustomersPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void LoadCustomerUpdateData(CustomersPage loadCustomer)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                loadCustomer.txUpdateCustomerId.Text = loadCustomer.GridViewCustomers.SelectedRow.Cells[1].Text;
                loadCustomer.txUpdateAddressId.Text = loadCustomer.GridViewCustomers.SelectedRow.Cells[2].Text;
                loadCustomer.txUpdateCustomerName.Text = loadCustomer.GridViewCustomers.SelectedRow.Cells[3].Text;
                loadCustomer.txUpdateCreditCardNo.Text = loadCustomer.GridViewCustomers.SelectedRow.Cells[5].Text;
                loadCustomer.txUpdateCardExpireDate.Text = loadCustomer.GridViewCustomers.SelectedRow.Cells[6].Text;
                vAddressId = loadCustomer.GridViewCustomers.SelectedRow.Cells[2].Text;

                string sqlSelectCmd = "SELECT * FROM Addresses where addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                loadCustomer.txUpdateAddressLine1.Text = read[1].ToString();
                loadCustomer.txUpdateAddressLine2.Text = read[2].ToString();
                loadCustomer.txUpdateAddressLine3.Text = read[3].ToString();
                loadCustomer.txUpdateCity.Text = read[4].ToString();
                loadCustomer.txUpdateZipPostCode.Text = read[5].ToString();
                loadCustomer.txUpdateStateProvince.Text = read[6].ToString();
                read.Close();

                DB.closeConnection();                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void UpdateCustomer(CustomersPage updateCustomer)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vCustomerId = updateCustomer.txUpdateCustomerId.Text;
                vCustomerName = updateCustomer.txUpdateCustomerName.Text;
                vAddressId = updateCustomer.txUpdateAddressId.Text;                
                vCreditCardNo = updateCustomer.txUpdateCreditCardNo.Text;
                vCCExpireDate = updateCustomer.txUpdateCardExpireDate.Text;
                vLine01 = updateCustomer.txUpdateAddressLine1.Text;
                vLine02 = updateCustomer.txUpdateAddressLine2.Text;
                vLine03 = updateCustomer.txUpdateAddressLine3.Text;
                vCity = updateCustomer.txUpdateCity.Text;
                vStateProvince = updateCustomer.txUpdateStateProvince.Text;
                vZipPostal = updateCustomer.txUpdateZipPostCode.Text;
                                                
                string sqlUpdateCom = "UPDATE Addresses SET line1Number = '" + vLine01 + "', line2Street = '" + vLine02 + "', line3Area = '" + vLine03 + "', city = '" + vCity + "', zipPostCode = '" + vZipPostal + "', stateProvinceCountry = '" + vStateProvince + "' WHERE addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlUpdateCom, DatabaseConnection.dbConnection);
                com.ExecuteNonQuery();
              

                string sqlUpdateCmd = "UPDATE Customers SET customerName = '" + vCustomerName + "', creditCardNo = '" + vCreditCardNo + "', cardExpiryDate = '" + vCCExpireDate + "' WHERE customerId = '" + vCustomerId + "'";
                SqlCommand cmd = new SqlCommand(sqlUpdateCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(updateCustomer, this.GetType(), "SweetAlert", "swal('Success!', 'Customer Updated', 'success').then(function(){window.location='CustomersPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void DeleteCustomer(CustomersPage deleteCustomer)
        {
            try
            {                
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vCustomerId = deleteCustomer.GridViewCustomers.SelectedRow.Cells[1].Text;
                string sqlDeleteUpdateCmd = "DELETE FROM Customers WHERE customerID = '" + vCustomerId + "'";
                SqlCommand cmd = new SqlCommand(sqlDeleteUpdateCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(deleteCustomer, this.GetType(), "SweetAlert", "swal('Success!', 'Customer Deleted', 'success').then(function(){window.location='CustomersPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}