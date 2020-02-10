<%@ Page Title="Tripsia | F&B Nearby" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FNB_Map.aspx.cs" Inherits="tripsia.FNB_Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #<%=placeDetails.ClientID%> {
            width: 100%;
        }
    </style>

    <script type="text/javascript">
        mapboxgl.accessToken = '<%= System.Configuration.ConfigurationManager.AppSettings["mapboxApi"] %>';
    </script>

    <script src="js/fnb_map.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>

    <main class="container-fluid animated fadeIn faster">
        <div class="row pt-4">
            <div class="col-12 col-md-4 order-2 order-md-1 mt-4 mt-md-0">
                <asp:UpdatePanel ID="placesPanel" runat="server">
                    <ContentTemplate>
                        <div class="input-group mb-4">
                            <div class="md-form md-outline">
                                <asp:TextBox ID="radTxtBox" runat="server" Text="1500" TextMode="Number" CssClass="form-control" CausesValidation="true"></asp:TextBox>
                                <label for="<%=radTxtBox.ClientID %>" class="active">Radius Search</label>
                            </div>

                            <div class="input-group-append">
                                <span class="input-group-text">
                                    meter
                                </span>

                                <asp:Button ID="setRadBtn" runat="server" Text="SET RADIUS" CssClass="btn btn-md btn-primary m-0" OnClick="setRadBtn_Click" ValidationGroup="radSearch" />
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body overflow-auto" style="max-height: calc(100vh - 259px - 1.5rem);">
                                <div id="setRadMsg" runat="server" class="text-center">
                                    <h5 class="card-title">Set Search Radius</h5>
                                </div>

                                <div id="emptyMsg" runat="server" class="text-center" style="display: none !important;">
                                    <h5 class="card-title">No Nearby Outlets</h5>
                                </div>

                                <ul class="list-group-flush pl-0">
                                    <asp:Repeater ID="placesRepeater" runat="server" OnItemDataBound="placesRepeater_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="list-group-item">
                                                <h6 class="font-weight-bold"><%#Eval("name") %></h6>

                                                <div class="row">
                                                    <div class="col-12 col-md-7 d-flex flex-column justify-content-center">
                                                        <p class="grey-text">
                                                            <small>
                                                                <span class="text-warning">
                                                                    <%#Eval("rating") %> <i class="fas fa-star"></i>
                                                                </span> (<%#Eval("user_ratings_total") %>)<br />

                                                                <%#Eval("vicinity") %><br />
                                                                <span class="font-weight-bold <%#Eval("opening_hours.open_now") != null && (bool) Eval("opening_hours.open_now") ? "text-success" : "text-danger" %>">
                                                                    <%#Eval("opening_hours.open_now") != null && (bool) Eval("opening_hours.open_now") ? "Open Now" : "Close Now" %>
                                                                </span>
                                                            </small>
                                                        </p>
                                                    </div>
                                    
                                                    <div class="col-12 col-md-5">
                                                        <button class="btn btn-sm btn-block btn-primary my-1" type="button" data-role="getDirection" data-lat="<%#Eval("geometry.location.lat") %>" data-lng="<%#Eval("geometry.location.lng") %>" onclick="getDirection(this)">SET DESTINATION</button>
                                                        <asp:Button ID="detailsBtn" runat="server" CssClass="btn btn-sm btn-block btn-info my-1" data-toggle="modal" data-target="#detailsModal" data-id='<%# Eval("place_id") %>' Text="MORE DETAILS" OnClick="detailsBtn_Click" />
                                                        <button id="leaveReviewBtn" runat="server" class="btn btn-sm btn-block btn-danger mt-2" type="button" data-id='<%#Eval("place_id") %>' data-toggle="modal" data-target="#reviewModal" data-name='<%#Eval("name") %>' onclick="leaveReviewBtn_OnClick(this)">LEAVE REVIEW</button>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>

                            <div class="card-footer">
                                <asp:Button ID="moreBtn" runat="server" CssClass="btn btn-sm btn-block btn-primary" Text="LOAD MORE" OnClick="moreBtn_Click" />
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="col-12 col-md-8 order-1 order-md-2">
                <asp:TextBox ID="latTxtBox" runat="server" TextMode="SingleLine" Text="1.3" CssClass="d-none"></asp:TextBox>
                <asp:TextBox ID="lngTxtBox" runat="server" TextMode="SingleLine" Text="103.8" CssClass="d-none"></asp:TextBox>

                <div class="card">
                    <div id="map" class="card-body p-0 rounded" style="min-height: calc(100vh - 137px - 6rem);"></div>

                    <div class="card-footer text-right">
                        <button class="btn btn-sm btn-danger d-none" type="button" data-role="zoomDest">
                            Zoom To Destination
                        </button>

                        <button class="btn btn-sm btn-blue" type="button" data-role="zoomCurrLoc">
                            Zoom To Current Location
                        </button>
                        
                        <button class="btn btn-sm btn-info" type="button" data-role="setOriginCurrLoc">
                            Set From Location To Current Location
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <div id="detailsModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <asp:UpdatePanel ID="placeDetails" runat="server">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="fas fa-map-marker-alt mr-1"></i> <asp:Label ID="nameLbl" runat="server" Text="OUTLET DETAILS"></asp:Label>
                            </h5>

                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                        </div>

                        <div class="modal-body">
                            <asp:Image ID="placeMainImg" runat="server" CssClass="mb-4" Width="100%" />

                            <div class="row mb-2">
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
                                                                Tripsia Users Has Not Reviewed This Outlet Yet
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
                            <asp:TextBox ID="ratingTxtBox" runat="server" TextMode="Number" CssClass="form-control" Text="0" step="1" min="0" max="5"></asp:TextBox>
                            <label for="<%=ratingTxtBox.ClientID %>">Rate</label>
                        </div>
                    </div>
                    <small class="text-danger">
                        <asp:RequiredFieldValidator ID="ratingReqValidator" runat="server" ControlToValidate="ratingTxtBox" ValidationGroup="review" ErrorMessage="Rate is required." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="ratingRangeValidator" runat="server" ControlToValidate="ratingTxtBox" ErrorMessage="Rating has be between 0 to 5." Display="Dynamic" Type="Integer" MinimumValue="0" MaximumValue="5"></asp:RangeValidator>
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
                    <asp:Button ID="leaveReviewBtn" runat="server" CssClass="btn btn-md btn-success" Text="LEAVE REVIEW" ValidationGroup="review" OnClick="leaveReviewBtn_Click" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let latClientId = <%=latTxtBox.ClientID %>;
        let lngClientId = <%=lngTxtBox.ClientID %>;
        let setRadClientId = <%=setRadBtn.ClientID %>;
        let idTxtBoxCid = <%=idTxtBox.ClientID%>;
    </script>
</asp:Content>
