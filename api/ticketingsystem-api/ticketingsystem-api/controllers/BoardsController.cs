
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ticketingsystem_api.DAO;

namespace ticketingsystem_api.controllers
{
    [Route("[controller]")]
    [ApiController]
    public class BoardsController : ControllerBase
    {
        private readonly BoardDao boardDao;

        public BoardsController(BoardDao _boardDao)
        {
            boardDao = _boardDao;
        }

        [HttpGet]
        public IActionResult Test()
        {
            return Ok("oof");
        }
    }
}
