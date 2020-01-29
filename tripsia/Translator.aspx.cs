using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;

namespace EADP_Project.Pages
{
    public partial class Translator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string from = tbFrom.Text;
            string lang = ddlFrom.SelectedValue + "-" + ddlTo.SelectedValue;
            tbTo.Text = GetTranslation(lang, from).ToString();
        }
        public List<Translator> GetTranslation(string lang, string from)
        {
            HttpClient client = new HttpClient
            {
                // state the URI address that hosted the web API
                BaseAddress = new Uri("https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20200114T131011Z.dac6da0100e514f4.4c059157f898586c984e8cd5adea7a31718a40e9")
            };
            List<Translator> data = new List<Translator>();
            Task<HttpResponseMessage> responseTask;
            responseTask = client.GetAsync("&text=" + from + "&lang=" + lang);
            responseTask.Wait();
            var result = responseTask.Result;
            if (result.IsSuccessStatusCode)
            {
                var readTask = result.Content.ReadAsAsync<List<Translator>>();
                readTask.Wait();
                data = readTask.Result;
            }
            //else
            //{
                //data = null;
            //}

            return data;
        }

    }
    

}