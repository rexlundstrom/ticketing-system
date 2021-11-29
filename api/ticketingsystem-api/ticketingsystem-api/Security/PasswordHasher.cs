using ticketingsystem_api.Security.Models;
using System;
using System.Security.Cryptography;

namespace ticketingsystem_api.Security
{
    public class PasswordHasher
    {
        private const int WorkFactor = 10000;

        public PasswordHash ComputeHash (string plainPassword)
        {
            Rfc2898DeriveBytes rfc = new Rfc2898DeriveBytes(plainPassword, 8, WorkFactor);
            byte[] hash = rfc.GetBytes(20);
            string salt = Convert.ToBase64String(rfc.Salt);
            return new PasswordHash(Convert.ToBase64String(hash), salt);
        }

        public bool VerifyHashMatch(string hashedPassword, string plainPassword, string salt)
        {
            byte[] saltArray = Convert.FromBase64String(salt);
            Rfc2898DeriveBytes rfc = new Rfc2898DeriveBytes(plainPassword, saltArray, WorkFactor);
            byte[] hash = rfc.GetBytes(20);
            string newHashedPassword = Convert.ToBase64String(hash);
            return (newHashedPassword == hashedPassword);
        }
    }
}
