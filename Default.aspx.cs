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

namespace CuboFullStackChallenge
{
    public partial class Default : System.Web.UI.Page
    {
        protected List<UserModel> Users { get; private set; }

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ErrorMessage"] != null)
                {
                    Toastr.Visible = true;
                    CreationFormValidator.Text = Session["ErrorMessage"].ToString();
                    Session.Remove("ErrorMessage");
                }
            }

            using (var context = new DatabaseContext())
            {
                Users = await context.Users.ToListAsync();
                var usersJson = new JavaScriptSerializer().Serialize(Users);
                ClientScript.RegisterStartupScript(GetType(), "script", $"var users = {usersJson};", true);

                InsightsTable.DataSource = Users;
                InsightsTable.DataBind();
            }
        }

        protected async void Send_Form(object sender, EventArgs e)
        {
            // Validate Entries
            if (string.IsNullOrWhiteSpace(FirstNameInput.Text))
            {
                Session["ErrorMessage"] = "First name can't be null";
                Response.Redirect(Request.RawUrl, false);
                return;
            }
            if (string.IsNullOrWhiteSpace(LastNameInput.Text))
            {
                Session["ErrorMessage"] = "Last name can't be null";
                Response.Redirect(Request.RawUrl, false);
                return;
            }
            if (string.IsNullOrWhiteSpace(ParticipationInput.Text))
            {
                Session["ErrorMessage"] = "Participation can't be null";
                Response.Redirect(Request.RawUrl, false);
                return;
            }

            // Prepare User
            var user = new UserModel
            {
                FirstName = FirstNameInput.Text,
                LastName = LastNameInput.Text,
                Participation = int.Parse(ParticipationInput.Text)
            };

            // Validate user and persis them
            using (var context = new DatabaseContext())
            {
                var list = await context.Users.ToListAsync();
                var totalParticipation = list.Sum(u => u.Participation);

                if (totalParticipation >= 100)
                {
                    Session["ErrorMessage"] = "Participation is already 100%";
                    Response.Redirect(Request.RawUrl, false);
                    return;
                }
                if (totalParticipation + user.Participation > 100)
                {
                    Session["ErrorMessage"] = "Invalid participation: total will exceed 100%";
                    Response.Redirect(Request.RawUrl, false);
                    return;
                }

                context.Users.Add(user);
                await context.SaveChangesAsync();
            }

            Response.Redirect(Request.RawUrl, false);
        }

        protected void Close_Toastr(object sender, EventArgs e)
        {
            Toastr.Visible = false;
        }
    }
}
