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
    public class ClassDrugCompany
    {
        string vCompanyId, vReadCompanyId, vCompanyName;
        int vNewCompanyId;
        public string GenerateCompanyId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(companyId) FROM DrugCompanies";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadCompanyId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadCompanyId))
                {
                    vCompanyId = "COM001";
                }
                else
                {
                    vNewCompanyId = Convert.ToInt32(vReadCompanyId.Substring(3)) + 1;
                    vCompanyId = "COM" + vNewCompanyId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vCompanyId;
        }

        public void addNewCompany(DrugCompaniesPage addCompany)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vCompanyId = addCompany.txCompanyId.Text;
                vCompanyName = addCompany.txCompanyName.Text;                
                
                string sqlInsertCmd = "INSERT INTO DrugCompanies VALUES('" + vCompanyId + "', '" + vCompanyName + "')";
                SqlCommand cmd = new SqlCommand(sqlInsertCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(addCompany, this.GetType(), "SweetAlert", "swal('Success!', 'New Drug Company Registered', 'success').then(function(){window.location='DrugCompaniesPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void DeleteCompany(DrugCompaniesPage deleteCompany)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vCompanyId = deleteCompany.GridViewDrugCompanies.SelectedRow.Cells[1].Text;

                string sqlSelectCmd = "SELECT COUNT(*) FROM DrugsAndMedication WHERE drugCompanyId = '" + vCompanyId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                int count = Convert.ToInt32(com.ExecuteScalar());
                if (count != 0)
                {
                    ScriptManager.RegisterClientScriptBlock(deleteCompany, this.GetType(), "SweetAlert", "swal('Error!', 'Registered Drugs are available under this Company', 'error').then(function(){window.location='DrugCompaniesPage.aspx';})", true);
                }
                else
                {
                    string sqlDeleteUpdateCmd = "DELETE FROM DrugCompanies WHERE companyID = '" + vCompanyId + "'";
                    SqlCommand cmd = new SqlCommand(sqlDeleteUpdateCmd, DatabaseConnection.dbConnection);
                    cmd.ExecuteNonQuery();
                    DB.closeConnection();
                    ScriptManager.RegisterClientScriptBlock(deleteCompany, this.GetType(), "SweetAlert", "swal('Success!', 'Drug Company Deleted', 'success').then(function(){window.location='DrugCompaniesPage.aspx';})", true);
                }                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}