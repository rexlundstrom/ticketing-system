using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ticketingsystem_api.Security.Models
{
    public class PasswordHash
    {
        public string Password { get; }
        public string Salt { get; }

        public PasswordHash(string password, string salt)
        {
            Password = password;
            Salt = salt;
        }
    }
}
