<%@ Page Title="Tripsia | Itinerary" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Itinerary.aspx.cs" Inherits="tripsia.Itinerary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/itinerary.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid">
        <div class="d-flex flex-fill justify-content-end">
            <div class="default-state">
                <button id="editModeBtn" class="btn btn-sm btn-info" type="button">
                    <i class="fas fa-edit mr-1"></i> EDIT
                </button>

                <button data-toggle="modal" data-target="#newModal" type="button" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus mr-1"></i> NEW SCHEDULE
                </button>
            </div>
            
            <div class="edit-state d-none">
                <button id="doneEditBtn" class="btn btn-sm btn-success" type="button">
                    <i class="fas fa-check mr-1"></i> DONE EDITING
                </button>
            </div>
        </div>

        <div class="d-flex flex-fill p-4 overflow-auto">
            <div id="emptyMsg" runat="server" class="col-12 text-center d-flex align-items-center justify-content-center full-height" style="min-height: calc(100vh - 224px);">
                <h1 class="text-muted">Looks like you have not created any schedule yet.</h1>
            </div>

            <asp:Repeater ID="cardRepeater" runat="server" OnItemDataBound="cardRepeater_ItemDataBound">
                <ItemTemplate>
                    <div class="px-4 border-right" style="min-width: 350px;">
                        <h5 class="text-center font-weight-bold mb-0">
                            <%#Eval("dateTime", "{0:dd/MM/yyyy}") %>
                        </h5>
                        <p class="text-center font-weight-bold grey-text">
                            <%#Eval("dateTime", "{0:dddd}") %>
                        </p>

                        <asp:Repeater ID="eventRepeater" runat="server">
                            <ItemTemplate>
                                <div class="card card-cascade my-4">
                                    <div class="view view-cascade gradient-card-header random-gradient">
                                        <p class="card-header-subtitle font-weight-bold mb-0">
                                            <%#Eval("dateTime", "{0:hh:mm tt}") %>
                                        </p>
                                    </div>

                                    <div class="card-body card-body-cascade text-justify">
                                        <h5 class="card-title mb-0">
                                            <%#Eval("title") %>
                                        </h5>
                                        <p class="card-text mt-3 <%# String.IsNullOrEmpty(Eval("description").ToString()) ? "d-none" : "" %>">
                                            <%#Eval("description") %>
                                        </p>
                                    </div>

                                    <div class="card-footer d-none">
                                        <button class="btn btn-md btn-info btn-block" data-toggle="modal" data-target="#editModal" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" data-desc="<%#Eval("description") %>" data-date="<%#Eval("dateTime", "{0:dd/MM/yyyy}") %>" data-time="<%#Eval("dateTime", "{0:hh:mmtt}") %>" type="button">
                                            EDIT
                                        </button>

                                        <button class="btn btn-md btn-danger btn-block mt-2" data-toggle="modal" data-target="#delModal" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" data-desc="<%#Eval("description") %>" data-date="<%#Eval("dateTime", "{0:dd/MM/yyyy}") %>" data-time="<%#Eval("dateTime", "{0:hh:mmtt}") %>" type="button">
                                            DELETE
                                        </button>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </main>

    <div id="newModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fad fa-calendar-plus mr-1"></i> NEW SCHEDULE
                    </h5>

                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>

                <div class="modal-body">
                    <div class="input-group mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fad fa-calendar-day"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="newDateTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control datepicker" CausesValidation="true"></asp:TextBox>
                            <label for="<%=newDateTxtBox.ClientID %>">Date</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="newDateReqValidator" runat="server" ControlToValidate="newDateTxtBox" ValidationGroup="new" ErrorMessage="Date is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="newDateValidator" runat="server" ControlToValidate="newDateTxtBox" OnServerValidate="DateValidate" ValidationGroup="new" Display="Dynamic"></asp:CustomValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-clock"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="newTimeTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control timepicker" CausesValidation="true"></asp:TextBox>
                            <label for="<%=newTimeTxtBox.ClientID %>">Time</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="newTimeReqValidator" runat="server" ControlToValidate="newTimeTxtBox" ValidationGroup="new" ErrorMessage="Time is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="newTimeValidator" runat="server" ControlToValidate="newTimeTxtBox" OnServerValidate="TimeValidate" ValidationGroup="new" Display="Dynamic"></asp:CustomValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-heading"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="newTitleTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                            <label for="<%=newTitleTxtBox.ClientID %>">Schedule Title</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="newTitleReqValidator" runat="server" ControlToValidate="newTitleTxtBox" ValidationGroup="new" ErrorMessage="Schedule Title is required." Display="Dynamic"></asp:RequiredFieldValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-signature"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="newDescTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                            <label for="<%=newDescTxtBox.ClientID %>">Itinerary Description (Optional)</label>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-md btn-danger" type="button" data-dismiss="modal">CANCEL</button>
                    <asp:Button ID="addBtn" runat="server" Text="ADD SCHEDULE" CssClass="btn btn-md btn-success" OnClick="addBtn_Click" ValidationGroup="new" />
                </div>
            </div>
        </div>
    </div>

    <div id="editModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-edit mr-1"></i> EDIT SCHEDULE
                    </h5>

                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>

                <div class="modal-body">
                    <div class="input-group mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fad fa-calendar-day"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="editDateTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control datepicker" CausesValidation="true"></asp:TextBox>
                            <label for="<%=editDateTxtBox.ClientID %>">Date</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="editDateReqValidator" runat="server" ControlToValidate="editDateTxtBox" ValidationGroup="edit" ErrorMessage="Date is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="editDateValidator" runat="server" ControlToValidate="editDateTxtBox" OnServerValidate="DateValidate" ValidationGroup="edit" Display="Dynamic"></asp:CustomValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-clock"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="editTimeTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control timepicker" CausesValidation="true"></asp:TextBox>
                            <label for="<%=editTimeTxtBox.ClientID %>">Time</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="editTimeReqValidator" runat="server" ControlToValidate="editTimeTxtBox" ValidationGroup="edit" ErrorMessage="Time is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="editTimeValidator" runat="server" ControlToValidate="editTimeTxtBox" OnServerValidate="TimeValidate" ValidationGroup="edit" Display="Dynamic"></asp:CustomValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-heading"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="editTitleTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                            <label for="<%=editTitleTxtBox.ClientID %>">Schedule Title</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="editTitleReqValidator" runat="server" ControlToValidate="editTitleTxtBox" ValidationGroup="edit" ErrorMessage="Schedule Title is required." Display="Dynamic"></asp:RequiredFieldValidator>
                    </small>

                    <div class="input-group mt-3 mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-signature"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="editDescTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                            <label for="<%=editDescTxtBox.ClientID %>">Itinerary Description (Optional)</label>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:TextBox ID="editIdTxtBox" runat="server" TextMode="Number" style="display: none;"></asp:TextBox>
                    <button class="btn btn-md btn-danger" type="button" data-dismiss="modal">CANCEL</button>
                    <asp:Button ID="editBtn" runat="server" Text="UPDATE SCHEDULE" CssClass="btn btn-md btn-success" OnClick="editBtn_Click" ValidationGroup="edit" />
                </div>
            </div>
        </div>
    </div>

    <div id="delModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-trash-alt mr-1"></i> DELETE SCHEDULE
                        </h5>

                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>

                    <div class="modal-body">
                        Are you sure you want to delete this itinerary?
                    </div>

                    <div class="modal-footer">
                        <asp:TextBox ID="delIdTxtBox" runat="server" TextMode="Number" style="display: none"></asp:TextBox>
                        <asp:TextBox ID="delTitleTxtBox" runat="server" TextMode="SingleLine" style="display: none"></asp:TextBox>
                        <button class="btn btn-md btn-success" type="button" data-dismiss="modal">CANCEL</button>
                        <asp:Button ID="delBtn" runat="server" Text="DELETE" CssClass="btn btn-md btn-danger" OnClick="delBtn_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let editIdClientId = '#<%= editIdTxtBox.ClientID %>';
        let editDateClientId = '#<%= editDateTxtBox.ClientID %>';
        let editTimeClientId = '#<%= editTimeTxtBox.ClientID %>';
        let editTitleClientId = '#<%= editTitleTxtBox.ClientID %>';
        let editDescClientId = '#<%= editDescTxtBox.ClientID %>';

        let delIdClientId = '#<%= delIdTxtBox.ClientID %>';
        let delTitleClientId = '#<%= delTitleTxtBox.ClientID %>';
    </script>

    <script src="js/itinerary.js" type="text/javascript"></script>
</asp:Content>
