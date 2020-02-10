<%@ Page Title="Tripsia" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tripsia.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div id="video-carousel-example2" class="carousel slide carousel-fade" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#c1" data-slide-to="0" class="active"></li>
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
                            <li><p class="font-weight-bold text-uppercase pt-4">Your one stop travel needs.</p></li>
                        </ul>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <main class="container-fluid animted fadeIn faster pt-0">
        
    </main>
</asp:Content>
