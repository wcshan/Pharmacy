<%@ Page Title="" Language="C#" MasterPageFile="~/WebForms/PharmacyMaster.Master" AutoEventWireup="true" CodeBehind="DrugsPage.aspx.cs" Inherits="Pharmacy.WebForms.DrugsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentHead" runat="server">    
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="contentbody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12" style="height: 10px"></div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-11 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewDrugs" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="drugId" DataSourceID="SqlDataSourceDrugs" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewDrugs_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="drugId" HeaderText="Drug Id" ReadOnly="True" SortExpression="drugId" />
                        <asp:BoundField DataField="drugCompanyId" HeaderText="Drug Company Id" SortExpression="drugCompanyId" />
                        <asp:BoundField DataField="drugName" HeaderText="Drug Name" SortExpression="drugName" />
                        <asp:BoundField DataField="drugCost" HeaderText="Drug Cost" SortExpression="drugCost" />
                        <asp:BoundField DataField="drugAvailableDate" HeaderText="Drug Available Date" SortExpression="drugAvailableDate" />                        
                        <asp:BoundField DataField="drugDescription" HeaderText="Drug Description" SortExpression="drugDescription" />
                        <asp:BoundField DataField="genericEquivalentDrugId" HeaderText="Generic Equivalent Drug Id" SortExpression="genericEquivalentDrugId" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="Gray" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceDrugs" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT * FROM [DrugsAndMedication]"></asp:SqlDataSource>               
            </div>
            <div class="col-sm-1">
                <asp:LinkButton CssClass="btn btn-success" ID="btnAdd" runat="server" Text="Add" Width="78px" data-toggle="modal" data-target="#addDrugModal" /><br />
                <br />
                <asp:LinkButton CssClass="btn btn-warning" ID="btnUpdate" runat="server" Text="Update" Width="78px" data-toggle="modal" data-target="#updateDrugModal" /><br />
                <br />
                <asp:LinkButton CssClass="btn btn-danger" ID="btnDelete" runat="server" Text="Delete" Width="78px" data-toggle="modal" data-target="#deleteDrugModal" />                
            </div>
        </div>
    </div>

    <!-- Add New Drug Modal-->
    <div class="modal fade" id="addDrugModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#2b2a2a, #5c5b5b); color: white">
                    <h5 class="modal-title">Add New Drug</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lbl1" runat="server" Text="Drug Id"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox Enabled="false" ID="txDrugId" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxDrugId" runat="server" ErrorMessage="" ControlToValidate="txDrugId" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label5" runat="server" Text="Drug Company"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:DropDownList CssClass="btn btn-light" ID="ddDrugCompanyId" Width="200px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourceCompanyList" DataTextField="companyName" DataValueField="companyId">
                                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceCompanyList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [companyId], [companyName] FROM [DrugCompanies]"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvddDrugCompanyId" runat="server" ErrorMessage="" ControlToValidate="ddDrugCompanyId" InitialValue="0" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label1" runat="server" Text="Drug Name"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txDrugName" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxDrugName" runat="server" ErrorMessage="" ControlToValidate="txDrugName" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label6" runat="server" Text="Drug Cost"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txDrugCost" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxDrugCost" runat="server" ErrorMessage="" ControlToValidate="txDrugCost" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label2" runat="server" Text="Drug Available Date"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txDrugAvailableDate" TextMode="Date" runat="server" ValidationGroup="groupAdd" Width="198px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxDrugAvailableDate" runat="server" ErrorMessage="" ControlToValidate="txDrugAvailableDate" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label7" runat="server" Text="Drug Description"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txDrugDescription" runat="server" ValidationGroup="groupAdd" TextMode="MultiLine" Rows="3" Width="198px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxDrugDescription" runat="server" ErrorMessage="" ControlToValidate="txDrugDescription" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label12" runat="server" Text="Equivalent Drug ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:DropDownList CssClass="btn btn-light" ID="ddEquivalentDrugId" Width="200px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourceDrugsList" DataTextField="drugName" DataValueField="drugId">
                                    <asp:ListItem Value="None" Text="-- None --" Selected="True"></asp:ListItem>
                                </asp:DropDownList>                                
                                <asp:SqlDataSource ID="SqlDataSourceDrugsList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [drugId], [drugName] FROM [DrugsAndMedication]"></asp:SqlDataSource>                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Submit" ID="btnAddDrugSubmit" ValidationGroup="groupAdd" OnClick="btnAddDrugSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Drug Modal-->
    <div class="modal fade" id="updateDrugModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#2b2a2a, #5c5b5b); color: white">
                    <h5 class="modal-title">Update Drug</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label3" runat="server" Text="Drug Id"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox Enabled="false" ID="txUpdateDrugId" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateDrugId" runat="server" ErrorMessage="" ControlToValidate="txUpdateDrugId" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label4" runat="server" Text="Drug Company"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:DropDownList CssClass="btn btn-light" ID="ddUpdateDrugCompanyId" Width="200px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupUpdate" DataSourceID="SqlDataSourceUpdateCompanyList" DataTextField="companyName" DataValueField="companyId">
                                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceUpdateCompanyList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [companyId], [companyName] FROM [DrugCompanies]"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvddUpdateDrugCompanyId" runat="server" ErrorMessage="" ControlToValidate="ddUpdateDrugCompanyId" InitialValue="0" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label8" runat="server" Text="Drug Name"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateDrugName" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateDrugName" runat="server" ErrorMessage="" ControlToValidate="txUpdateDrugName" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label9" runat="server" Text="Drug Cost"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateDrugCost" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateDrugCost" runat="server" ErrorMessage="" ControlToValidate="txUpdateDrugCost" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label10" runat="server" Text="Drug Available Date"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateDrugAvailableDate" TextMode="Date" runat="server" ValidationGroup="groupUpdate" Width="198px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateDrugAvailableDate" runat="server" ErrorMessage="" ControlToValidate="txUpdateDrugAvailableDate" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label11" runat="server" Text="Drug Description"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateDrugDescription" runat="server" ValidationGroup="groupUpdate" TextMode="MultiLine" Rows="3" Width="198px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateDrugDescription" runat="server" ErrorMessage="" ControlToValidate="txUpdateDrugDescription" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label13" runat="server" Text="Equivalent Drug ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:DropDownList CssClass="btn btn-light" ID="ddUpdateEquivalentDrugId" Width="200px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupUpdate" DataSourceID="SqlDataSourceUpdateDrugsList" DataTextField="drugName" DataValueField="drugId">
                                    <asp:ListItem Value="None" Text="-- None --" Selected="True"></asp:ListItem>
                                </asp:DropDownList>                                
                                <asp:SqlDataSource ID="SqlDataSourceUpdateDrugsList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [drugId], [drugName] FROM [DrugsAndMedication]"></asp:SqlDataSource>                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Submit" ID="btnUpdateDrugSubmit" ValidationGroup="groupUpdate" OnClick="btnUpdateDrugSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>    

    <!-- Delete Drug Modal -->
    <div class="modal fade" id="deleteDrugModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete
                    <asp:Label runat="server" ID="lblDeleteDrugId"></asp:Label>
                    <asp:Label runat="server" ID="lblDeleteDrugName"></asp:Label>
                    ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button type="submit" runat="server" CssClass="btn btn-danger" Text="Delete" ID="btnDeleteDrugSubmit" OnClick="btnDeleteDrugSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>    
</asp:Content>
