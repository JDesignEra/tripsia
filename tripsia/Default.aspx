<%@ Page Title="Tripsia" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tripsia.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html,
        body,
        .view {
            height: 100%;
        }

        .carousel,
        .carousel-item,
        .carousel-item.active {
            height: calc(100vh - 53px);
            }

        .carousel-inner {
            height: calc(100vh - 53px);
        }

        .carousel .carousel-item video {
            min-width: 200%;
            min-height: 100%;
            width: auto;
            height: auto;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div id="carousel" class="carousel slide carousel-fade" data-ride="carousel" data-interval="6000">
        <ol class="carousel-indicators">
            <li data-target="#carousel" data-slide-to="0" class="active"></li>
            <li data-target="#carousel" data-slide-to="1"></li>
            <li data-target="#carousel" data-slide-to="2"></li>
            <li data-target="#carousel" data-slide-to="3"></li>
            <li data-target="#carousel" data-slide-to="4"></li>
            <li data-target="#carousel" data-slide-to="5"></li>
        </ol>

        <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/tropical.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled">
                            <li><h1 class="font-weight-bold text-uppercase">Welcome to Tripsia</h1></li>
                            <li><p class="font-weight-bold text-uppercase pt-4">Your one stop travel needs</p></li>
                            <li><a href="login.aspx" class="btn btn-md btn-info btn-rounded">LOGIN</a></li>
                            <li>
                                <small class="rgba-black-strong p-2 rounded">
                                    Don't have an account? <a href="Register.aspx">Register Here</a>
                                </small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="carousel-item">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/restaurant.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled mx-auto" style="max-width: 600px;">
                            <div class="rgba-black-light p-4">
                                <li><h1 class="font-weight-bold text-uppercase">Find Resturant Nearyby</h1></li>
                                <li><p class="font-weight-bold text-uppercase pt-4">Find F&B outlets near you on Tripsia</p></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="carousel-item">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/writing.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled mx-auto" style="max-width: 600px;">
                            <div class="rgba-black-light p-4">
                                <li><h1 class="font-weight-bold text-uppercase">Itinerary Planner</h1></li>
                                <li><p class="font-weight-bold text-uppercase pt-4">Plan your itinerary on Tripsia</p></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="carousel-item">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/resort.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled mx-auto" style="max-width: 600px;">
                            <div class="rgba-black-light p-4">
                                <li><h1 class="font-weight-bold text-uppercase">Find Hotels</h1></li>
                                <li><p class="font-weight-bold text-uppercase pt-4">Find hotels that suit your needs on Tripsia</p></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="carousel-item">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/sky.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled mx-auto" style="max-width: 600px;">
                            <div class="rgba-black-light p-4">
                                <li><h1 class="font-weight-bold text-uppercase">Check Flights</h1></li>
                                <li><p class="font-weight-bold text-uppercase pt-4">Check for flights information on Tripsia</p></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="carousel-item">
                <div class="view">
                    <video class="video-fluid" autoplay loop muted>
                        <source src="videos/book.mp4" type="video/mp4" />
                    </video>

                    <div class="full-bg-img flex-center mask rgba-teal-light white-text">
                        <ul class="animated fadeInUp col-md-12 list-unstyled mx-auto" style="max-width: 600px;">
                            <div class="rgba-black-light p-4">
                                <li><h1 class="font-weight-bold text-uppercase">Trranslation Tool</h1></li>
                                <li><p class="font-weight-bold text-uppercase pt-4">Translate unfamilar words on Tripsia</p></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
