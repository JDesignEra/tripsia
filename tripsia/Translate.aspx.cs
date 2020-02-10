using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using tripsia.BLL;

namespace tripsia
{
    public partial class translate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Dictionary<string, string> langDict = new Dictionary<string, string>();
                Language[] languages = GetLanguages().data.languages;

                langDict.Add("dl", "Detect Language");

                foreach (Language item in languages)
                {
                    langDict.Add(item.language, item.name);
                }

                fromLangDdl.DataSource = langDict;
                fromLangDdl.DataTextField = "Value";
                fromLangDdl.DataValueField = "Key";
                fromLangDdl.DataBind();
                fromLangDdl.SelectedValue = "dl";

                langDict.Remove("dl");

                toLangDdl.DataSource = langDict;
                toLangDdl.DataTextField = "Value";
                toLangDdl.DataValueField = "Key";
                toLangDdl.DataBind();

                toLangDdl.SelectedValue = "en";
            }
        }

        protected void translateBtn_Click(object sender, EventArgs e)
        {
            string fromLang = fromLangDdl.SelectedValue;
            string toLang = toLangDdl.SelectedValue;

            translatedTxtBox.Text = "";
            string[] translate = fromTxtBox.Text.Split(
                    new Char[] { '\n', '\r' },
                    StringSplitOptions.RemoveEmptyEntries
                );

            Translate translated = Translate(translate, toLang, fromLang != "dl" ? fromLang : null);

            if (translated != null)
            {
                foreach (Translation obj in translated.data.translations)
                {
                    translatedTxtBox.Text += string.Format("{0}{1}", obj.translatedText, Environment.NewLine);
                }
            }
        }

        public TranslateLanguages GetLanguages()
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://translation.googleapis.com/language/translate/v2/languages")
            };

            TranslateLanguages data = null;
            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?target=en&key={0}",
                    System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            if (result.IsSuccessStatusCode)
            {
                var read = result.Content.ReadAsStringAsync();
                read.Wait();

                data = JsonConvert.DeserializeObject<TranslateLanguages>(read.Result);
            }

            return data;
        }

        public Translate Translate(string[] q, string target, string source = null)
        {
            Translate data = null;

            if (q.Length > 0)
            {
                HttpClient client = new HttpClient
                {
                    BaseAddress = new Uri("https://translation.googleapis.com/language/translate/v2")
                };

                Task<HttpResponseMessage> response;

                string sourceParam = "?";
                string textParam = "";

                if (!string.IsNullOrEmpty(source))
                {
                    sourceParam += string.Format("source={0}&", source);
                }

                foreach (string s in q)
                {
                    textParam += string.Format("&q={0}", s);
                }

                response = client.GetAsync(
                    string.Format(
                        sourceParam + "&key={0}&target={1}" + textParam,
                        System.Configuration.ConfigurationManager.AppSettings["googleApi"],
                        target
                    )
                );

                response.Wait();

                var result = response.Result;

                if (result.IsSuccessStatusCode)
                {
                    var read = result.Content.ReadAsStringAsync();
                    read.Wait();

                    data = JsonConvert.DeserializeObject<Translate>(read.Result);
                }
            }

            return data;
        }
    }
}