<%@ Page Title="Tripsia | Translate" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Translate.aspx.cs" Inherits="tripsia.translate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <main class="container-fluid animated fadeIn faster">
        <div class="d-flex flex-column flex-md-row justify-content-center mt-4 mb-2">
            <div class="container-fluid p-0">
                <div class="input-group m-0">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="far fa-language"></i>
                        </span>
                    </div>

                    <div class="md-form md-outline">
                        <asp:DropDownList ID="fromLangDdl" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="px-0 px-md-3 py-2 py-md-0">
                <div class="h-100 d-flex flex-column justify-content-center text-center">
                    <asp:Button ID="translateBtn" runat="server" CssClass="btn btn-sm btn-block btn-primary m-0" Text="TRANSLATE" OnClick="translateBtn_Click" />
                </div>
            </div>

            <div class="container-fluid p-0">
                <div class="input-group m-0">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="far fa-language"></i>
                        </span>
                    </div>

                    <div class="md-form md-outline">
                        <asp:DropDownList ID="toLangDdl" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6 mb-4 mb-md-0">
                <div class="card">
                    <div class="card-body">
                        <div class="input-group mb-0">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="far fa-align-left"></i>
                                </span>
                            </div>

                            <div class="md-form md-outline">
                                <asp:TextBox ID="fromTxtBox" runat="server" TextMode="MultiLine" CssClass="form-control" style="height: calc(100vh - 91px - 10rem);"></asp:TextBox>
                                <label for="<%=fromTxtBox.ClientID %>">Text To Translate</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card" style="height: calc(100vh - 91px - 7.5rem);">
                    <div class="card-body">
                        <asp:TextBox ID="translatedTxtBox" runat="server" TextMode="MultiLine" CssClass="form-control grey-text h-100 h5-responsive" Enabled="false" Text="Translation"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script type="text/javascript">
        $(document).ready(function () {
            let fromTxtClientId = <%=fromTxtBox.ClientID%>;

            if ($(fromTxtClientId).val() !== '') {
                $(`label[for="${fromTxtClientId.id}"]`).addClass('active');
            }
        });
    </script>
</asp:Content>
