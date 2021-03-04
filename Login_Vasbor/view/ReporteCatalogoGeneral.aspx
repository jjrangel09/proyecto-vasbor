<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/ReporteCatalogoGeneral.aspx.cs" Inherits="view_ReporteCatalogoGeneral" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
    <CR:CrystalReportViewer ID="Report_CatalogoV" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="1202px" ReportSourceID="Report_CatalogoS" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="1104px" />
    <CR:CrystalReportSource ID="Report_CatalogoS" runat="server">
        <Report FileName="~\Reportes\ReporteCatalogo.rpt">
        </Report>
    </CR:CrystalReportSource>
        </div>
</asp:Content>

