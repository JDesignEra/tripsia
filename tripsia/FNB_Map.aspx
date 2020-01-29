<%@ Page Title="Tripsia | F&B Nearby" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FNB_Map.aspx.cs" Inherits="tripsia.FNB_Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/fnb_map.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid">
        <div class="row pt-4">
            <div class="col-4">
                <!-- Locations List -->
            </div>

            <div class="col-8">
                <div class="input-group mb-4">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fad fa-location"></i>
                        </span>
                    </div>

                    <div class="md-form md-outline">
                        <asp:TextBox ID="locTxtBox" runat="server" Text="Current Location" TextMode="SingleLine" CssClass="form-control" CausesValidation="true"></asp:TextBox>
                        <label for="<%=locTxtBox.ClientID %>">From Location</label>
                    </div>

                    <div class="input-group-append">
                        <button class="btn btn-md btn-primary m-0" type="button">Set Location</button>
                    </div>
                </div>

                <div class="card">
                    <div id="map" class="card-body p-0 rounded" style="min-height: calc(100vh - 219px - 4.75rem);"></div>

                    <div class="card-footer text-right">
                        <button class="btn btn-sm btn-primary" type="button" data-role="zoomCurrLoc">
                            Zoom To Current Location
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        let locClientId = <%= locTxtBox.ClientID %>;
    </script>
</asp:Content>
