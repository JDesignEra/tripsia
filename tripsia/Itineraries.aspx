<%@ Page Title="Triapsia | Itinerary" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Itineraries.aspx.cs" Inherits="tripsia.Itineraries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid">
        <div id="defaultStae" class="d-flex flex-fill justify-content-end">
            <button id="doneEditBtn" type="button" class="btn btn-sm btn-success d-none">
                <i class="fas fa-check mr-1"></i> DONE EDITING
            </button>

            <div id="defaultState">
                <button id="editModeBtn" type="button" class="btn btn-sm btn-info">
                    <i class="fas fa-edit mr-1"></i> EDIT
                </button>

                <button data-toggle="modal" data-target="#newModal" type="button" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus mr-1"></i> NEW
                </button>
            </div>
        </div>

        <div id="itinerariesContent" class="row mt-4">
            <div id="emptyMsg" runat="server" class="col-12 text-center d-flex align-items-center justify-content-center full-height" style="min-height: calc(100vh - 224px);">
                <h1 class="text-muted">Looks like you have not created an itinerary yet.</h1>
            </div>

            <asp:Repeater ID="itinerariesRepeater" runat="server">
                <ItemTemplate>
                    <div class="col-12 col-md-3">
                        <div class="card card-cascade">
                            <div class="view view-cascade gradient-card-header random-gradient">
                                <h5 class="card-header-title">
                                    <%#Eval("title") %>
                                </h5>
                            </div>

                            <div class="card-body card-body-cascade text-justify <%# String.IsNullOrEmpty(Eval("description").ToString()) ? "d-none" : "" %>">
                                <p class="card-text">
                                    <%#Eval("description") %>
                                </p>
                            </div>

                            <div class="card-footer">
                                <div class="default-state">
                                    <a href="itinerary.aspx?id=<%#Eval("id") %>" class="btn btn-md btn-block btn-primary">
                                        VIEW <i class="fas fa-angle-double-right ml-1"></i>
                                    </a>
                                </div>

                                <div class="edit-state">
                                    <button data-toggle="modal" data-target="#editModal" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" data-desc="<%#Eval("description") %>" type="button" class="btn btn-md btn-block btn-info mt-2 d-none">
                                        EDIT
                                    </button>

                                    <button data-toggle="modal" data-target="#delModal" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" type="button" class="btn btn-md btn-block btn-danger mt-2 d-none">
                                        DELETE
                                    </button>
                                </div>
                            </div>
                        </div>
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
                        <i class="fas fa-plus mr-1"></i> NEW ITINERARY
                    </h5>

                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>

                <div class="modal-body">
                    <div class="input-group mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-heading"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="newTitleTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                            <label for="<%=newTitleTxtBox.ClientID %>">Itinerary Name</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="newTitleReqValidator" runat="server" ControlToValidate="newTitleTxtBox" ValidationGroup="new" ErrorMessage="Itinerary Name is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="newTitleValidator" runat="server" ControlToValidate="newTitleTxtBox" ValidationGroup="new" Display="Dynamic"></asp:CustomValidator>
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
                    <asp:Button ID="addBtn" runat="server" Text="ADD ITINERARY" CssClass="btn btn-md btn-success" ValidationGroup="new" OnClick="addBtn_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="editModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-edit mr-1"></i> EDIT ITINERARY
                        </h5>

                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="input-group mb-0">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-heading"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="editTitleTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>
                                <label for="<%=editTitleTxtBox.ClientID %>">Itinerary Name</label>
                            </div>
                        </div>
                        <small class="text-danger">
                            <asp:RequiredFieldValidator ID="editTitleTxtBoxReqValidator" runat="server" ControlToValidate="editTitleTxtBox" ValidationGroup="edit" ErrorMessage="Itinerary Name is required." Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="editTitleTxtBoxValidator" runat="server" ControlToValidate="editTitleTxtBox" ValidationGroup="edit" Display="Dynamic"></asp:CustomValidator>
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
                        <asp:TextBox ID="editIdTxtBox" runat="server" TextMode="Number" style="display: none"></asp:TextBox>
                        <button class="btn btn-md btn-danger" type="button" data-dismiss="modal">CANCEL</button>
                        <asp:Button ID="updateBtn" runat="server" Text="UPDATE" CssClass="btn btn-md btn-info" ValidationGroup="edit" OnClick="updateBtn_Click" />
                    </div>
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
                            <i class="fas fa-trash-alt mr-1"></i> DELETE ITINERARY
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
                        <asp:TextBox ID="delTitleTxtBox" runat="server" style="display: none"></asp:TextBox>
                        <button class="btn btn-md btn-success" type="button" data-dismiss="modal">CANCEL</button>
                        <asp:Button ID="delBtn" runat="server" Text="DELETE" CssClass="btn btn-md btn-danger" OnClick="delBtn_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let delIdClientId = '#<%= delIdTxtBox.ClientID %>';
        let delTitleClientId = '#<%= delTitleTxtBox.ClientID %>';

        let editIdClientId = '#<%= editIdTxtBox.ClientID %>';
        let editTitleClientId = '#<%= editTitleTxtBox.ClientID %>';
        let editDescClientId = '#<%= editDescTxtBox.ClientID %>';
    </script>

    <script src="js/itineraries.js" type="text/javascript"></script>
</asp:Content>
