<%@ Page Title="Tripsia | Profile" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="tripsia.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid animated fadeIn faster">
        <div class="row">
            <div class="col-12 text-right">
                <a href="edit_profile.aspx" class="btn btn-sm btn-primary">EDIT PROFILE</a>
            </div>
        </div>

        <div class="card testimonial-card mx-auto" style="max-width: 800px;">
            <div class="card-up winter-neva-gradient"></div>

            <div class="avatar mx-auto white" style="border: 5px solid #09afa5;">
                <div class="rounded-circle mx-auto d-flex flex-column justify-content-center text-center" style="width: 100px; height: 100px;">
                    <div class="w-100 text-primary">
                        <i class="fas fa-user-tie fa-3x"></i>
                    </div>
                </div>
            </div>

            <div class="card-body text-center">
                <h5 class="card-title font-weight-bold m-0">
                    <%=Session["name"] %>
                </h5>
                <small class="grey-text">
                    <%=Session["email"] %>
                </small>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12 col-md-6">
                <div class="card card-cascade">
                    <div class="view view-cascade gradient-card-header blue-gradient">
                        <h5 class="card-header-title mb-0">
                            YOUR HOTEL REVIEWS
                        </h5>
                    </div>

                    <div class="card-body card-body-cascade text-center">
                        <div id="emptyHotelReview" runat="server">
                            <h5  class="card-title grey-text text-center">
                                You Have Not Reviewed Any Hotels Yet
                            </h5>
                        </div>

                        <div id="hotelsReview" runat="server" style="display: none !important;">
                            <asp:Repeater ID="hotelReviewsRepeater" runat="server">
                                <ItemTemplate>
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
            </div>

            <div class="col-12 col-md-6 mt-4 mt-md-0">
                <div class="card card-cascade">
                    <div class="view view-cascade gradient-card-header peach-gradient">
                        <h5 class="card-header-title mb-0">
                            YOUR FNB REVIEWS
                        </h5>
                    </div>

                    <div class="card-body card-body-cascade text-center">
                        <div id="emptyFnbReview" runat="server">
                            <h5  class="card-title grey-text text-center">
                                You Have Not Reviewed Any FNB Outlets Yet
                            </h5>
                        </div>

                        <div id="fnbReview" runat="server" style="display: none !important;">
                            <asp:Repeater ID="fnbReviewsRepeater" runat="server">
                                <ItemTemplate>
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
            </div>
        </div>
    </main>
</asp:Content>
