<%@ Page Title="" Language="C#" MasterPageFile="~/WebForms/PharmacyMaster.Master" AutoEventWireup="true" CodeBehind="DrugCompaniesPage.aspx.cs" Inherits="Pharmacy.WebForms.DrugCompaniesPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentHead" runat="server">
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="contentbody" runat="server">
    <div class="container">
        <div class="row" style="margin-bottom:10px; margin-top:20px">
            <div class="col-sm-6">
                <div class="input-group">
                    <asp:DropDownList CssClass="btn-success" runat="server" ID="ddSearch" Width="100px">
                        <asp:ListItem>ID</asp:ListItem>
                        <asp:ListItem>Name</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txSearch" placeholder="Search Text" BackColor="#eaeaea"></asp:TextBox>
                    <asp:Button runat="server" CssClass="btn-success" Text="   Search   " ID="btnSearch" OnClick="btnSearch_Click" />
                </div>
            </div>
            <div class="col-sm-6 text-right">
                <asp:LinkButton CssClass="btn btn-success" ID="btnAdd" runat="server" Width="110px" data-toggle="modal" data-target="#addCompanyModal"><span class="fa fa-user-plus"></span>&nbsp;&nbsp;Add</asp:LinkButton>&nbsp;&nbsp;                
                <asp:LinkButton CssClass="btn btn-danger" ID="btnDelete" runat="server" Width="110px" data-toggle="modal" data-target="#deleteCompanyModal"><span class="fa fa-trash"></span>&nbsp;&nbsp;Delete</asp:LinkButton>                
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewDrugCompanies" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="companyId" DataSourceID="SqlDataSourceDrugCompanies" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewDrugCompanies_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="companyId" HeaderText="Company Id" ReadOnly="True" SortExpression="companyId" />
                        <asp:BoundField DataField="companyName" HeaderText="Company Name" SortExpression="companyName" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#105b85" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="Gray" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceDrugCompanies" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT * FROM [DrugCompanies]"></asp:SqlDataSource>                
            </div>            
        </div>
    </div>

    <!-- Add New Drug Company Modal-->
    <div class="modal fade" id="addCompanyModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Add New Company</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lbl1" runat="server" Text="Company Id"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox Enabled="false" ID="txCompanyId" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxCompanyId" runat="server" ErrorMessage="" ControlToValidate="txCompanyId" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label1" runat="server" Text="Company Name"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txCompanyName" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxCompanyName" runat="server" ErrorMessage="" ControlToValidate="txCompanyName" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div> 
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Submit" ID="btnAddCompanySubmit" ValidationGroup="groupAdd" OnClick="btnAddCompanySubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Drug Company Modal -->
    <div class="modal fade" id="deleteCompanyModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Delete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete
                    <asp:Label runat="server" ID="lblDeleteCompanyId"></asp:Label>
                    <asp:Label runat="server" ID="lblDeleteCompanyName"></asp:Label>
                    ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button type="submit" runat="server" CssClass="btn btn-danger" Text="Delete" ID="btnDeleteCompanySubmit" OnClick="btnDeleteCompanySubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>    
</asp:Content>
