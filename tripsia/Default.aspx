<%@ Page Title="Tripsia" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tripsia.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid animted fadeIn faster">
        <div id="carousel" class="carousel slideInDown carousel-fade">
            <ol class="carousell-indicators">
                <li data-target="#c1" data-slide-to="0" class="active"></li>
                <li data-target="#c2" data-slide-to="1" class="active"></li>
                <li data-target="#c3" data-slide-to="2" class="active"></li>
            </ol>

            <div class="carousel-innter" role="listbox">
                <div class="carousel-item active">
                    <div class="view">

                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
