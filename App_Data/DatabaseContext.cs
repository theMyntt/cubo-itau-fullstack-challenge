using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;
using CuboFullStackChallenge.App_Models;

namespace CuboFullStackChallenge.App_Data
{
    public class DatabaseContext : DbContext
    {
        public DbSet<UserModel> Users { get; set; }

        public DatabaseContext()
            : base(ConfigurationManager.ConnectionStrings["SqlServer"].ConnectionString)
        {
        }
    }
}