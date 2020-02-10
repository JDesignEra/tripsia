<%@ Page Title="Tripsia | Register" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="tripsia.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html {
            height: 100vh !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <video class="vid-full-bg" autoplay muted loop>
        <source src="videos/typing_laptop.mp4" type="video/mp4">
    </video>
    <div class="rgba-teal-light vid-full-bg"></div>

    <main class="container-fluid d-flex flex-column justify-content-center animated fadeIn faster">
        <div class="row">
            <div class="col-md-4 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <div class="input-group mb-0">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="nameTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                                <label for="<%=nameTxtBox.ClientID %>">Name</label>
                            </div>
                        </div>
                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="nameReqValidator" runat="server" ControlToValidate="nameTxtBox" ErrorMessage="Name is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        </small>

                        <div class="input-group mb-0 mt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="emailTxtBox" runat="server" TextMode="Email" CssClass="form-control" CausesValidation="true"></asp:TextBox>
                                <label for="<%=emailTxtBox.ClientID %>">Email</label>
                            </div>
                        </div>
                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="emailReqValidator" runat="server" ControlToValidate="emailTxtBox" ErrorMessage="Email is required." Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="emailValidator" ControlToValidate="emailTxtBox" runat="server" OnServerValidate="EmailValidate" Display="Dynamic"></asp:CustomValidator>
                        </small>

                        <div class="input-group mb-0 mt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-key"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="passTxtBox" runat="server" TextMode="Password" CssClass="form-control" CausesValidation="true"></asp:TextBox>
                                <label for="<%=passTxtBox.ClientID %>">Password</label>
                            </div>
                        </div>

                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="passReqValidator" ControlToValidate="passTxtBox" runat="server" ErrorMessage="Password is required." Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="passValidator" ControlToValidate="passTxtBox" runat="server" OnServerValidate="PasswordValidate" Display="Dynamic"></asp:CustomValidator>
                        </small>

                        <div class="input-group mb-0 mt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fad fa-key"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="cfmPassTxtBox" runat="server" TextMode="Password" CssClass="form-control" CausesValidation="true"></asp:TextBox>
                                <label for="<%=cfmPassTxtBox.ClientID %>">Confirm Password</label>
                            </div>
                        </div>
                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="cfmPassReqValidator" runat="server" ControlToValidate="cfmPassTxtBox" ErrorMessage="Confirm Password is required." Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cfmPassValidator" runat="server" ControlToValidate="cfmPassTxtBox" OnServerValidate="CfmPasswordValidate" Display="Dynamic"></asp:CustomValidator>
                        </small>

                        <asp:Button ID="regBtn" runat="server" Text="REGISTER" CssClass="btn btn-md btn-block btn-success mt-3" OnClick="regBtn_Click" />
                            
                        <small>Already have an account with us? <a href="login.aspx">Login</a></small>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
