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
    public class ClassDrug
    {
        string vDrugId, vReadDrugId, vDrugName, vDrugCompanyId, vDrugAvailableDate, vDrugDescription, vEquivalentDrugId;
        int vNewDrugId;
        double vDrugCost;
        public string GenerateDrugId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(drugId) FROM DrugsAndMedication";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadDrugId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadDrugId))
                {
                    vDrugId = "DRG001";
                }
                else
                {
                    vNewDrugId = Convert.ToInt32(vReadDrugId.Substring(3)) + 1;
                    vDrugId = "DRG" + vNewDrugId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vDrugId;
        }

        public void addNewDrug(DrugsPage addDrug)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vDrugId = addDrug.txDrugId.Text;
                vDrugCompanyId = addDrug.ddDrugCompanyId.SelectedValue;
                vDrugName = addDrug.txDrugName.Text;
                vDrugCost = Convert.ToDouble(addDrug.txDrugCost.Text);
                vDrugAvailableDate = addDrug.txDrugAvailableDate.Text;
                vDrugDescription = addDrug.txDrugDescription.Text;
                vEquivalentDrugId = addDrug.ddEquivalentDrugId.Text;

                string sqlInsertCmd = "INSERT INTO DrugsAndMedication VALUES('" + vDrugId + "', '" + vDrugCompanyId + "', '" + vDrugName + "','" + vDrugCost + "','" + vDrugAvailableDate + "','" + vDrugDescription + "','" + vEquivalentDrugId + "')";
                SqlCommand cmd = new SqlCommand(sqlInsertCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(addDrug, this.GetType(), "SweetAlert", "swal('Success!', 'New Drug Registered', 'success').then(function(){window.location='DrugsPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void LoadDrugUpdateData(DrugsPage loadDrug)
        {
            try
            {
                loadDrug.txUpdateDrugId.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[1].Text;
                loadDrug.ddUpdateDrugCompanyId.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[2].Text;
                loadDrug.txUpdateDrugName.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[3].Text;
                loadDrug.txUpdateDrugCost.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[4].Text;
                loadDrug.txUpdateDrugAvailableDate.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[5].Text;
                loadDrug.txUpdateDrugDescription.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[6].Text;
                loadDrug.ddUpdateEquivalentDrugId.Text = loadDrug.GridViewDrugs.SelectedRow.Cells[7].Text;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void UpdateDrug(DrugsPage updateDrug)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vDrugId = updateDrug.txUpdateDrugId.Text;
                vDrugCompanyId = updateDrug.ddUpdateDrugCompanyId.SelectedValue;
                vDrugName = updateDrug.txUpdateDrugName.Text;
                vDrugCost = Convert.ToDouble(updateDrug.txUpdateDrugCost.Text);
                vDrugAvailableDate = updateDrug.txUpdateDrugAvailableDate.Text;
                vDrugDescription = updateDrug.txUpdateDrugDescription.Text;
                vEquivalentDrugId = updateDrug.ddUpdateEquivalentDrugId.Text;

                if (vEquivalentDrugId == vDrugId)
                {
                    ScriptManager.RegisterClientScriptBlock(updateDrug, this.GetType(), "SweetAlert", "swal('Error!', 'Generic Equivalent Drug cannot be the same', 'error').then(function(){window.location='DrugsPage.aspx';})", true);
                }
                else
                {
                    string sqlUpdateCom = "UPDATE DrugsAndMedication SET drugCompanyId = '" + vDrugCompanyId + "', drugName = '" + vDrugName + "', drugCost = '" + vDrugCost + "', drugAvailableDate = '" + vDrugAvailableDate + "', drugDescription = '" + vDrugDescription + "', genericEquivalentDrugId = '" + vEquivalentDrugId + "' WHERE drugId = '" + vDrugId + "'";
                    SqlCommand com = new SqlCommand(sqlUpdateCom, DatabaseConnection.dbConnection);
                    com.ExecuteNonQuery();
                    ScriptManager.RegisterClientScriptBlock(updateDrug, this.GetType(), "SweetAlert", "swal('Success!', 'Drug details Updated', 'success').then(function(){window.location='DrugsPage.aspx';})", true);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void DeleteDrug(DrugsPage deleteDrug)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vDrugId = deleteDrug.GridViewDrugs.SelectedRow.Cells[1].Text;

                string sqlSelectCmd = "SELECT COUNT(*) FROM DrugsAndMedication WHERE genericEquivalentDrugId = '" + vDrugId + "'";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                int count = Convert.ToInt32(com.ExecuteScalar());
                if(count != 0)
                {
                    ScriptManager.RegisterClientScriptBlock(deleteDrug, this.GetType(), "SweetAlert", "swal('Error!', 'Referenced Generic Drugs are available', 'error').then(function(){window.location='DrugsPage.aspx';})", true);
                }
                else
                {
                    string sqlDeleteCmd = "DELETE FROM DrugsAndMedication WHERE drugID = '" + vDrugId + "'";
                    SqlCommand cmd = new SqlCommand(sqlDeleteCmd, DatabaseConnection.dbConnection);
                    cmd.ExecuteNonQuery();
                    DB.closeConnection();
                    ScriptManager.RegisterClientScriptBlock(deleteDrug, this.GetType(), "SweetAlert", "swal('Success!', 'Drug details Deleted', 'success').then(function(){window.location='DrugsPage.aspx';})", true);
                } 
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}