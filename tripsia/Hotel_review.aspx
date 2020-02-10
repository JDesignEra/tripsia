<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Hotel_review.aspx.cs" Inherits="project_181406s.ViewProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    
        <div class="row">
            <div class="col-sm-8">

            <!-- Refer to http://getbootstrap.com/components/#panels on using Panel -->
            <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Review:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            
                            <asp:TextBox ID="tbCustId" runat="server" CssClass="form-control" placeholder="Input your review"></asp:TextBox>
                        </div>
                        <asp:Button ID="BtnPost" runat="server" CssClass="btn btn-default" Text="Post" OnClick="BtnPost_Click" />
                        <asp:Panel ID="PanelCust" Visible="false" runat="server">
                    <div class="panel panel-info">
                        <div class="panel-heading">Review:</div>
                        <div class="panel-body">

                            <div class="row">
                                
                                <div class="col-sm-2">
                                    <asp:Label ID="Lbl_custname" runat="server"></asp:Label>
                                </div>
                                
                                <div class="col-sm-10">
                                    <asp:Label ID="Lbl_Review" runat="server"></asp:Label>
                                </div>
                            </div>
                            

                        </div>
                    </div>
                </asp:Panel>
                    </div>
                </div>

            </div>
        </div>
    
</asp:Content>