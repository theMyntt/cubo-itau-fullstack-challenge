using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace CuboFullStackChallenge.App_Models
{
    [Table("Users")]
    public class UserModel
    {
        [Key]        
        [Column(nameof(Id))]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Column(nameof(FirstName))]
        public string FirstName { get; set; }

        [Column(nameof(LastName))]
        public string LastName { get; set; }

        [Column(nameof(Participation))]
        public int Participation { get; set; }

        [Column(nameof(Email))]
        public string Email { get; set; }

        [Column(nameof(Password))]
        public string Password { get; set; }
    }
}