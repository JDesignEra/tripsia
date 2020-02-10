<%@ Page Title="Tripsia | Airlines" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Flights.aspx.cs" Inherits="tripsia.Airlines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/vendors/datatables.min.css" rel="stylesheet" />

    <script src="js/vendors/datatables.min.js" type="text/javascript"></script>
    <script src="js/flights.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid animated fadeIn faster">
        <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="updatePanel" runat="server">
            <ContentTemplate>
                <div class="input-group my-4">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fad fa-plane"></i>
                        </span>
                    </div>

                    <div class="md-form md-outline">
                        <asp:DropDownList ID="airlineDdl" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="input-group-append">
                        <asp:Button ID="setAirline" runat="server" Text="SET AIRLINE" CssClass="btn btn-sm btn-primary h-100 m-0" OnClick="setAirline_Click" />
                    </div>
                </div>

                <div class="card">
                    <div class="card-body table-responsive">
                        <table id="flightsTable" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th class="th-sm">Flight Number</th>
                                    <th class="th-sm">Aircraft Code</th>
                                    <th class="th-sm">Callsign</th>
                                    <th class="th-sm">Arrival Time</th>
                                    <th class="th-sm">Departure Time</th>
                                    <th class="th-sm">Flight Status</th>
                                    <th class="th-sm">Airline</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="flightsRepeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%#Eval("properties.iataFlightNumber") != null ? Eval("properties.iataFlightNumber") : "--" %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.aircraftDescription") != null && Eval("properties.aircraftDescription.aircraftCode") != null ? Eval("properties.aircraftDescription.aircraftCode") : "--" %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.callsign") != null ? Eval("properties.callsign") : "--" %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.arrival.runwayTime.initial") %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.departure.runwayTime.initial") %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.flightStatus") %>
                                            </td>

                                            <td>
                                                <%#Eval("properties.airline") %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </main>
</asp:Content>
