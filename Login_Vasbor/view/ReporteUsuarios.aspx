<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/ReporteUsuarios.aspx.cs" Inherits="view_ReporteUsuarios" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <CR:CrystalReportViewer ID="CR_V" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="1202px" ReportSourceID="CR_S" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="1104px" />
    <CR:CrystalReportSource ID="CR_S" runat="server">
        <Report FileName="~\Reportes\ReporteMonetarioUsuario.rpt">
        </Report>
    </CR:CrystalReportSource>
</asp:Content>

