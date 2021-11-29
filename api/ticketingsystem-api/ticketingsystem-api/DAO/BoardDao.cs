using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ticketingsystem_api.DAO
{
    public class BoardDao
    {
        private readonly string connectionString;

        public BoardDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

    }
}
