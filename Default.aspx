<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CuboFullStackChallenge.Default" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }

        button {
            cursor: pointer;
        }

        #CreationForm {
            display: flex;
            gap: 20px;
            background-color: skyblue;
            justify-content: center;
            padding: 40px 0;
        }

        #Toastr {
            position: fixed;
            right: 20px;
            bottom: 20px;
            min-width: 300px;
        }

            #Toastr div {
                padding: 20px;
            }

        #ToastrHeader {
            background-color: skyblue;
            color: white;
            display: flex;
            justify-content: space-between;
        }

        #ToastrBody {
            background-color: lightgray;
        }

        .FormInput {
            background-color: white;
            padding: 15px;
            border: 0;
        }

        .FormButton {
            background-color: skyblue;
            border: 2px solid white;
            color: white;
            font-weight: 900;
            padding: 0 20px
        }
    </style>
</head>
<body>
    <form runat="server">
        <header id="CreationForm">
            <asp:TextBox runat="server" ID="FirstNameInput" placeholder="First name" CssClass="FormInput" />
            <asp:TextBox runat="server" ID="LastNameInput" placeholder="Last name" CssClass="FormInput" />
            <asp:TextBox runat="server" ID="ParticipationInput" placeholder="Participation" CssClass="FormInput" TextMode="Number" />
            <asp:Button runat="server" type="submit" OnClick="Send_Form" Text="SEND" CssClass="FormButton" />
        </header>
        <main>
            <div id="Toastr" runat="server" visible="false">
                <div id="ToastrHeader">
                    <h2>Attention</h2>
                    <asp:Button runat="server" ID="CloseBtn" OnClick="Close_Toastr" Text="X" CssClass="FormButton" />
                </div>
                <div id="ToastrBody">
                    <asp:Label runat="server" ID="CreationFormValidator" />
                </div>
            </div>
        </main>
    </form>
</body>
</html>
