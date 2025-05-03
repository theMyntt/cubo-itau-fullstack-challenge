using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using CuboFullStackChallenge.App_Data;
using CuboFullStackChallenge.App_Models;
using Newtonsoft.Json;

namespace CuboFullStackChallenge
{
    public partial class Default : System.Web.UI.Page
    {
        protected List<UserModel> Users { get; private set; }

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (var context = new DatabaseContext())
                {
                    Users = await context.Users.ToListAsync();
                    var usersJson = new JavaScriptSerializer().Serialize(Users);
                    ClientScript.RegisterStartupScript(GetType(), "script", $"var users = {usersJson}", true);
                }
                InsightsTable.DataSource = Users;
                InsightsTable.DataBind();
            }
        }

        protected async void Send_Form(object sender, EventArgs e)
        {
            // Validate Entries
            if (FirstNameInput.Text == string.Empty)
            {
                Toastr.Visible = true;
                CreationFormValidator.Text = "First name cant be null";
                return;
            }
            if (LastNameInput.Text == string.Empty)
            {
                Toastr.Visible = true;
                CreationFormValidator.Text = "Last name cant be null";
                return;
            }
            if (ParticipationInput.Text == string.Empty)
            {
                Toastr.Visible = true;
                CreationFormValidator.Text = "Participation cant be null";
                return;
            }

            Toastr.Visible = false;

            // Prepare User
            var user = new UserModel
            {
                FirstName = FirstNameInput.Text,
                LastName = LastNameInput.Text,
                Participation = int.Parse(ParticipationInput.Text)
            };

            // Reset Form
            FirstNameInput.Text = string.Empty;
            LastNameInput.Text = string.Empty;
            ParticipationInput.Text = string.Empty;

            // Persist User
            using (var context = new DatabaseContext())
            {
                context.Users.Add(user);
                await context.SaveChangesAsync();
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void Close_Toastr(object sender, EventArgs e)
        {
            Toastr.Visible = false;
        }
    }
}