<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CuboFullStackChallenge.Default" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        #Container {
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: 20px;
        }

        #BrandingMessage {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        #Insights {
            display: flex;
            gap: 20px;
            
        }

        #PizzaChart {
            height: 300px !important;
            width: 300px !important;
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

        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
            display: block;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px 20px;
            min-width: 200px;
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
            <div id="Container">
                <div id="BrandingMessage">
                    <h1>DATA</h1>
                    <p>Lorem ipsum dolor sit amet, consecteur adipiscing olit.</p>
                </div>
                <div id="Insights">
                    <table>
                        <thead>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>Participation</th>
                        </thead>
                        <tbody>
                            <asp:Repeater runat="server" ID="InsightsTable">
                                <ItemTemplate>
                                    <tr>
                                        <td> <%# Eval("FirstName") %> </td>
                                        <td> <%# Eval("LastName") %> </td>
                                        <td> <%# Eval("Participation") %>% </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>

                    <!-- ChartJS -->
                    <canvas id="PizzaChart"></canvas>
                </div>
            </div>
        </main>
    </form>
    <script>
        // users are injected on Page_Load
        const firstNames = users.map(user => user.FirstName)
        const lastNames = users.map(user => user.LastName)
        const participation = users.map(user => user.Participation)

        const chartElement = document.getElementById("PizzaChart");

        new Chart(chartElement, {
            type: 'doughnut',
            data: {
                labels: firstNames,
                datasets: [{
                    label: 'Participation',
                    data: participation,
                    backgroundColor: [
                        'red',
                        'blue',
                        'yellow',
                        'green',
                        'limegreen'
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                animation: false
            }
        });
    </script>
</body>
</html>
