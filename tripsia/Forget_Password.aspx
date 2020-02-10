<%@ Page Title="Tripsia | Forget Password" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Forget_Password.aspx.cs" Inherits="tripsia.Forget_Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <video class="vid-full-bg" autoplay muted loop>
        <source src="videos/forest.mp4" type="video/mp4">
    </video>
    <div class="rgba-teal-light vid-full-bg"></div>

    <main class="container-fluid d-flex flex-column justify-content-center vcenter animated fadeIn faster">
        <div class="row">
            <div class="col-md-4 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <div class="input-group mb-0">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="emailTxtBox" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
                                <label for="<%=emailTxtBox.ClientID %>">Email</label>
                            </div>
                        </div>

                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="emailReqValidator" runat="server" ControlToValidate="emailTxtBox" ErrorMessage="Email is required." Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="emailValidator" runat="server" ControlToValidate="emailTxtBox" OnServerValidate="EmailValidate" Display="Dynamic"></asp:CustomValidator>
                        </small>

                        <asp:Button ID="forgotPassBtn" runat="server" Text="FORGET PASSWORD" CssClass="btn btn-md btn-block btn-primary mt-3" OnClick="forgotPassBtn_Click" />
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
