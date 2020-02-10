<%@ Page Title="Tripsia | Edit Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Edit_Profile.aspx.cs" Inherits="tripsia.EditProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid animated fadeIn faster">
        <div class="row">
            <div class="col-12 text-right">
                <a href="profile.aspx" class="btn btn-sm btn-danger">CANCEL</a>
                <asp:Button ID="saveBtn" runat="server" CssClass="btn btn-sm btn-success" Text="SAVE" OnClick="saveBtn_Click" />
            </div>
        </div>

        <div class="card testimonial-card mx-auto">
            <div class="card-up winter-neva-gradient"></div>

            <div class="avatar mx-auto white" style="border: 5px solid #09afa5;">
                <div class="rounded-circle mx-auto d-flex flex-column justify-content-center text-center" style="width: 100px; height: 100px;">
                    <div class="w-100 text-primary">
                        <i class="fas fa-user-tie fa-3x"></i>
                    </div>
                </div>
            </div>

            <div class="card-body text-center">
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

                <hr />

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
                    <asp:CustomValidator ID="cfmPassValidator" runat="server" ControlToValidate="cfmPassTxtBox" OnServerValidate="CfmPasswordValidate" Display="Dynamic"></asp:CustomValidator>
                </small>
            </div>
        </div>
    </main>
</asp:Content>