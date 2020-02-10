<%@ Page Title="Tripsia | Login" Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tripsia.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html {
            height: 100vh !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <video class="vid-full-bg" autoplay muted loop>
        <source src="videos/typing.mp4" type="video/mp4">
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

                        <div class="input-group mb-0 mt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-key"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="passTxtBox" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                <label for="<%=passTxtBox.ClientID %>">Password</label>
                            </div>
                        </div>

                        <small class="text-danger d-block">
                            <asp:RequiredFieldValidator ID="passReqValidator" runat="server" ControlToValidate="passTxtBox" ErrorMessage="Password is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        </small>
                        
                        <small class="d-block text-right">
                            <a href="Forget_Password.aspx">Forgot Password?</a>
                        </small>

                        <asp:Button ID="loginBtn" runat="server" Text="LOGIN" CssClass="btn btn-md btn-block btn-primary mt-3" OnClick="loginBtn_Click" />
                        <small>Don't have an account? <a href="Register.aspx">Register</a></small>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
