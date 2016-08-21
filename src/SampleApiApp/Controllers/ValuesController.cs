using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace SampleApiApp.Controllers
{
    [Route("api/[controller]")]
    public class ValuesController : Controller
    {
        // GET api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // GET api/values/5
        [HttpGet]
        [Route("{id}/none")]
        public IActionResult GetNone(int id)
        {
            var value = this.Request.Headers["Authorization"].ToString();
            if (!value.Equals("abcdef", StringComparison.CurrentCultureIgnoreCase))
            {
                return new UnauthorizedResult();
            }

            return new JsonResult("{ \"value\": \"value\" }");
        }

        // GET api/values/5
        [HttpGet]
        [Route("{id}/basic")]
        public IActionResult GetBasic(int id)
        {
            var value = this.Request.Headers["Authorization"].ToString();
            if (!value.StartsWith("Basic "))
            {
                return new UnauthorizedResult();
            }

            if (!value.Replace("Basic ", "").Equals("abcdef", StringComparison.CurrentCultureIgnoreCase))
            {
                return new UnauthorizedResult();
            }

            return new JsonResult("{ \"value\": \"value\" }");
        }

        // GET api/values/5
        [HttpGet]
        [Route("{id}/bearer")]
        public IActionResult GetBearer(int id)
        {
            var value = this.Request.Headers["Authorization"].ToString();
            if (!value.StartsWith("Bearer "))
            {
                return new UnauthorizedResult();
            }

            if (!value.Replace("Bearer ", "").Equals("abcdef", StringComparison.CurrentCultureIgnoreCase))
            {
                return new UnauthorizedResult();
            }

            return new JsonResult("{ \"value\": \"value\" }");
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
