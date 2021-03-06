﻿<%@ Page Title="Tripsia | Hotels" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Hotels.aspx.cs" Inherits="tripsia.Hotels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/hotels.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>

    <main class="container-fluid animated fadeIn faster">
        <div class="row pt-4">
            <div class="col-12 col-md-6 order-1 order-md-0 mt-4 mt-md-0">
                <asp:UpdatePanel ID="hotelsPanel" runat="server">
                    <ContentTemplate>
                        <div class="input-group mb-4">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-flag-alt"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:DropDownList ID="countriesDdl" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>

                            <div class="input-group-append">
                                <asp:Button ID="setCountryBtn" runat="server" Text="SET COUNTRY" CssClass="btn btn-sm btn-primary h-100 m-0" OnClick="setCountryBtn_Click" />
                            </div>
                        </div>

                        <div class="card overflow-auto">
                            <div class="card-body">
                                <ul class="list-group-flush pl-0">
                                    <asp:Repeater ID="hotelsRepeater" runat="server" OnItemDataBound="hotelsRepeater_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="list-group-item">
                                                <h6 class="font-weight-bold"><%#Eval("name")%></h6>

                                                <div class="row">
                                                    <div class="col-12 col-md-8">
                                                        <p class="grey-text">
                                                            <small>
                                                                <span class="text-warning">
                                                                    <%#Eval("rating") %> <i class="fas fa-star"></i>
                                                                </span> (<%#Eval("user_ratings_total") %>)<br />

                                                                <%#Eval("formatted_address") %><br />
                                                                <span class="font-weight-bold <%#Eval("opening_hours.open_now") != null && (bool) Eval("opening_hours.open_now") ? "text-success" : "text-danger" %>">
                                                                    <%#Eval("opening_hours.open_now") != null && (bool) Eval("opening_hours.open_now") ? "Open Now" : "Close Now" %>
                                                                </span>
                                                            </small>
                                                        </p>
                                                    </div>

                                                    <div class="col-12 col-md-4 d-flex flex-column justify-content-center">
                                                        <asp:Button ID="detailsBtn" runat="server" CssClass="btn btn-sm btn-block btn-info" Text="VIEW DETAILS" data-id='<%#Eval("place_id")%>' OnClick="detailsBtn_Click" />
                                                        <button id="leaveReviewBtn" runat="server" class="btn btn-sm btn-block btn-primary mt-2" type="button" data-id='<%#Eval("place_id") %>' data-toggle="modal" data-target="#reviewModal" data-name='<%#Eval("name") %>' onclick="leaveReviewBtn_OnClick(this)">LEAVE REVIEW</button>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="col-12 col-md-6 order-0 order-md-1 mt-0">
                <asp:UpdatePanel ID="detailsPanel" runat="server">
                    <ContentTemplate>
                        <div id="detailsCard" runat="server" class="card overflow-auto animated fadeIn faster" style="display: none !important;">
                            <div class="card-body" style="min-height: calc(100vh - 137px - 1.8rem);">
                                <asp:Image ID="placeMainImg" runat="server" CssClass="mb-4" Width="100%" />

                                <asp:Label ID="nameLbl" runat="server" CssClass="h5"></asp:Label>

                                <div class="row my-2">
                                    <div class="col-1 text-primary">
                                        <i class="fas fa-star mr-1"></i>
                                    </div>

                                    <div class="col-11">
                                        <asp:Label ID="ratingLbl" runat="server" Text="0" CssClass="text-warning"></asp:Label>
                                        <asp:Label ID="rateNoLbl" runat="server" Text="(0)" CssClass="grey-text"></asp:Label>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-1 text-primary">
                                        <i class="fad fa-money-bill-alt"></i>
                                    </div>

                                    <div class="col-11">
                                        <asp:Label ID="priceLbl" runat="server"></asp:Label>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-1 text-primary">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>

                                    <div class="col-11">
                                        <asp:Label ID="addrLbl" runat="server"></asp:Label>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-1 text-primary">
                                        <i class="fas fa-phone"></i>
                                    </div>

                                    <div class="col-11">
                                        <asp:Label ID="phoneLbl" runat="server"></asp:Label>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-1 text-primary">
                                        <i class="fas fa-clock"></i>
                                    </div>

                                    <div class="col-11">
                                        <div id="openHoursAccordion" class="accordion md-accordion" role="tablist">
                                            <div class="card border-0 m-0 p-0">
                                                <div role="tab">
                                                    <a class="collapsed mb-2 d-flex flex-fill" data-toggle="collapse" data-parent="#openHoursAccordion" href="#openingHours">
                                                        <asp:Label ID="openNowLbl" runat="server"></asp:Label> <i class="fas fa-angle-down rotate-icon"></i>
                                                    </a>
                                                </div>

                                                <div id="openingHours" class="collapse mb-2" role="tabpanel" data-parent="openHoursAccordion">
                                                    <small class="grey-text">
                                                        <asp:UpdatePanel ID="openDaysPanel" runat="server">
                                                            <ContentTemplate>
                                                                <asp:Repeater ID="openDaysRepeater" runat="server">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItem %><br />
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr />

                                <div class="row mt-4">
                                    <div class="col-12">
                                        <asp:UpdatePanel ID="reviewsPanel" runat="server">
                                            <ContentTemplate>
                                                <ul class="nav nav-tabs md-tabs nav-justified" id="reviewTab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active show" data-toggle="tab" href="#googleReview" role="tab">
                                                            <small>GOOGLE USER REVIEWS</small>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#tripsiaReview" role="tab">
                                                            <small>TRIPSIA USER REVIEWS</small>
                                                        </a>
                                                    </li>
                                                </ul>

                                                <div class="tab-content pt-5" id="reviewTabContent">
                                                    <div class="tab-pane fade active show" id="googleReview" role="tabpanel">
                                                        <asp:Repeater ID="googleReviewsRepeater" runat="server">
                                                            <ItemTemplate>
                                                                <h6 class="card-title font-weight-bold">
                                                                    <%# Eval("author_name") %>
                                                                </h6>

                                                                <small class="text-warning mb-3">
                                                                    <%#Eval("rating") %> <i class="fas fa-star ml-1"></i>
                                                                </small>

                                                                <p><%# Eval("text") %></p>

                                                                <small class="grey-text">
                                                                    <%#Eval("relative_time_description") %>
                                                                </small>

                                                                <hr />
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </div>

                                                    <div class="tab-pane fade active show" id="tripsiaReview" role="tabpanel">
                                                        <div id="emptyReviews" runat="server">
                                                            <h5 class="card-title grey-text text-center">
                                                                Tripsia Users Has Not Reviewed This Hotel Yet
                                                            </h5>
                                                        </div>

                                                        <div id="tripsiaReviews" runat="server" style="display: none !important;">
                                                            <asp:Repeater ID="tripsiaReviewsRepeater" runat="server">
                                                                <ItemTemplate>
                                                                    <h6 class="card-title font-weight-bold">
                                                                        <%#Eval("name") %>
                                                                    </h6>

                                                                    <small class="text-warning mb-3">
                                                                        <%#Eval("rating") %> <i class="fas fa-star ml-1"></i>
                                                                    </small>

                                                                    <p><%# Eval("review") %></p>

                                                                    <small class="grey-text">
                                                                        <%#Eval("dateTime") %>
                                                                    </small>

                                                                    <hr />
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </main>

    <div id="reviewModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-comments-alt mr-1"></i> REVIEW
                    </h5>

                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>

                <div class="modal-body">
                    <asp:TextBox ID="idTxtBox" runat="server" TextMode="SingleLine" CssClass="form-control d-none"></asp:TextBox>

                    <div class="input-group mb-0">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-star"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="ratingTxtBox" runat="server" TextMode="Number" CssClass="form-control" Text="0" step="0.1" min="0" max="5"></asp:TextBox>
                            <label for="<%=ratingTxtBox.ClientID %>">Rate</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="ratingReqValidator" runat="server" ControlToValidate="ratingTxtBox" ValidationGroup="review" ErrorMessage="Rate is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="ratingRangeValidator" runat="server" ControlToValidate="ratingTxtBox" ErrorMessage="Rating has be between 0 to 5." Display="Dynamic" Type="Double" MinimumValue="0" MaximumValue="5"></asp:RangeValidator>
                    </small>

                    <div class="input-group mb-0 mt-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-edit"></i>
                            </span>
                        </div>

                        <div class="md-form md-outline">
                            <asp:TextBox ID="reviewTxtBox" runat="server" TextMode="MultiLine" CssClass="form-control" style="min-height: 100px;"></asp:TextBox>
                            <label for="<%=reviewTxtBox.ClientID %>">Review</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="reviewReqValidator" runat="server" ControlToValidate="reviewTxtBox" ValidationGroup="review" ErrorMessage="Review is required." Display="Dynamic"></asp:RequiredFieldValidator>
                    </small>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-md btn-danger" type="button" data-dismiss="modal">CANCEL</button>
                    <asp:Button ID="submitBtn" runat="server" CssClass="btn btn-md btn-success" Text="LEAVE REVIEW" ValidationGroup="review" OnClick="submitBtn_Click" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        idTxtBoxCid = <%=idTxtBox.ClientID%>;
        setCountryBtnCid = <%=setCountryBtn.ClientID%>;
    </script>
</asp:Content>
