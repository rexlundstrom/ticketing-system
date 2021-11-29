using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ticketingsystem_api.DAO
{
    public class CardDao
    {
        private readonly string connectionString;

        public CardDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

    }
}
