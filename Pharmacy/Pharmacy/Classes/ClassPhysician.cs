using Pharmacy.Database;
using Pharmacy.WebForms;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Windows.Forms;

namespace Pharmacy.Classes
{
    public class ClassPhysician
    {
        string vPhysicianId, vReadPhysicianId, vPhysicianName, vAddressId, vLine01, vLine02, vLine03, vCity, vStateProvince, vZipPostal;
        int vNewPhysicianId;
        public string GeneratePhysicianId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(physicianId) FROM Physicians";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadPhysicianId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadPhysicianId))
                {
                    vPhysicianId = "PHY001";
                }
                else
                {
                    vNewPhysicianId = Convert.ToInt32(vReadPhysicianId.Substring(3)) + 1;
                    vPhysicianId = "PHY" + vNewPhysicianId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vPhysicianId;
        }

        public void addNewPhysician(PhysiciansPage addPhysician)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vPhysicianId = addPhysician.txPhysicianId.Text;
                vPhysicianName = addPhysician.txPhysicianName.Text;
                vAddressId = addPhysician.ddAddress.SelectedValue;                
                vLine01 = addPhysician.txAddressLine1.Text;
                vLine02 = addPhysician.txAddressLine2.Text;
                vLine03 = addPhysician.txAddressLine3.Text;
                vCity = addPhysician.txCity.Text;
                vStateProvince = addPhysician.txStateProvince.Text;
                vZipPostal = addPhysician.txZipPostCode.Text;

                if (addPhysician.rbListAddress.SelectedIndex == 0)
                {
                    vAddressId = addPhysician.txNewAddressId.Text;
                    string sqlInsertCom = "INSERT INTO Addresses VALUES('" + vAddressId + "', '" + vLine01 + "', '" + vLine02 + "', '" + vLine03 + "', '" + vCity + "', '" + vZipPostal + "', '" + vStateProvince + "')";
                    SqlCommand com = new SqlCommand(sqlInsertCom, DatabaseConnection.dbConnection);
                    com.ExecuteNonQuery();
                }

                string sqlInsertCmd = "INSERT INTO Physicians VALUES('" + vPhysicianId + "', '" + vAddressId + "', '" + vPhysicianName + "')";
                SqlCommand cmd = new SqlCommand(sqlInsertCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(addPhysician, this.GetType(), "SweetAlert", "swal('Success!', 'New Physician Registered', 'success').then(function(){window.location='PhysiciansPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void LoadPhysicianUpdateData(PhysiciansPage loadPhysician)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                loadPhysician.txUpdatePhysicianId.Text = loadPhysician.GridViewPhysicians.SelectedRow.Cells[1].Text;
                loadPhysician.txUpdateAddressId.Text = loadPhysician.GridViewPhysicians.SelectedRow.Cells[2].Text;
                loadPhysician.txUpdatePhysicianName.Text = loadPhysician.GridViewPhysicians.SelectedRow.Cells[3].Text;                
                vAddressId = loadPhysician.GridViewPhysicians.SelectedRow.Cells[2].Text;

                string sqlSelectCmd = "SELECT * FROM Addresses where addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                loadPhysician.txUpdateAddressLine1.Text = read[1].ToString();
                loadPhysician.txUpdateAddressLine2.Text = read[2].ToString();
                loadPhysician.txUpdateAddressLine3.Text = read[3].ToString();
                loadPhysician.txUpdateCity.Text = read[4].ToString();
                loadPhysician.txUpdateZipPostCode.Text = read[5].ToString();
                loadPhysician.txUpdateStateProvince.Text = read[6].ToString();
                read.Close();

                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void UpdatePhysician(PhysiciansPage updatePhysician)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vPhysicianId = updatePhysician.txUpdatePhysicianId.Text;
                vPhysicianName = updatePhysician.txUpdatePhysicianName.Text;
                vAddressId = updatePhysician.txUpdateAddressId.Text;                
                vLine01 = updatePhysician.txUpdateAddressLine1.Text;
                vLine02 = updatePhysician.txUpdateAddressLine2.Text;
                vLine03 = updatePhysician.txUpdateAddressLine3.Text;
                vCity = updatePhysician.txUpdateCity.Text;
                vStateProvince = updatePhysician.txUpdateStateProvince.Text;
                vZipPostal = updatePhysician.txUpdateZipPostCode.Text;

                string sqlUpdateCom = "UPDATE Addresses SET line1Number = '" + vLine01 + "', line2Street = '" + vLine02 + "', line3Area = '" + vLine03 + "', city = '" + vCity + "', zipPostCode = '" + vZipPostal + "', stateProvinceCountry = '" + vStateProvince + "' WHERE addressId = '" + vAddressId + "'";
                SqlCommand com = new SqlCommand(sqlUpdateCom, DatabaseConnection.dbConnection);
                com.ExecuteNonQuery();


                string sqlUpdateCmd = "UPDATE Physicians SET physicianName = '" + vPhysicianName + "' WHERE physicianId = '" + vPhysicianId + "'";
                SqlCommand cmd = new SqlCommand(sqlUpdateCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(updatePhysician, this.GetType(), "SweetAlert", "swal('Success!', 'Physician Updated', 'success').then(function(){window.location='PhysiciansPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void DeletePhysician(PhysiciansPage deletePhysician)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vPhysicianId = deletePhysician.GridViewPhysicians.SelectedRow.Cells[1].Text;
                string sqlDeleteUpdateCmd = "DELETE FROM Physicians WHERE physicianID = '" + vPhysicianId + "'";
                SqlCommand cmd = new SqlCommand(sqlDeleteUpdateCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(deletePhysician, this.GetType(), "SweetAlert", "swal('Success!', 'Physician Deleted', 'success').then(function(){window.location='PhysiciansPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}