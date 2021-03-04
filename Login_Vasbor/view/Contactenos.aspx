<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoInvitado.master" AutoEventWireup="true" CodeFile="~/Controller/Contactenos.aspx.cs" Inherits="view_Contactenos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1 class="center">Encuentranos En Redes Sociales Como</h1>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h1> Facebook </h1>
                <asp:Button Text="Facebook" CssClass="btn btn-primary" OnClick="Unnamed_Click" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h1> instagram</h1>
                <asp:Button Text="instagram" CssClass="btn btn-primary" OnClick="Unnamed_Click1" runat="server" />
            </div>
        </div>
           </div>
</asp:Content>

