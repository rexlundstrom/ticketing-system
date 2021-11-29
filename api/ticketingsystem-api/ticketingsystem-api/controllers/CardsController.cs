using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ticketingsystem_api.DAO;

namespace ticketingsystem_api.controllers
{
    public class CardsController : Controller
    {
        private readonly CardDao cardDao;

        public CardsController(CardDao _cardDao)
        {
            cardDao = _cardDao;
        }
    }
}
