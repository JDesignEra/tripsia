<%@ Page Title="Tripsia | F&B Nearby" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FNB_Map.aspx.cs" Inherits="tripsia.FNB_Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/fnb_map.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid">
        <div class="flex-fill">
            <div class="input-group mb-0">
                <div class="input-group-prepend">
                    <span class="input-group-text">
                        <i class="fad fa-location"></i>
                    </span>
                </div>

                <div class="md-form md-outline">
                    <asp:TextBox ID="locTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control datepicker" CausesValidation="true"></asp:TextBox>
                    <label for="<%=locTxtBox.ClientID %>">Enter Location Manually</label>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-4">
                <!-- Locations List -->
            </div>

            <div class="col-8">
                <div class="card">
                    <div id="map" class="card-body p-0 rounded" style="min-height: calc(100vh - 125px);"></div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
