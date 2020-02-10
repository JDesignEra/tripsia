using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using tripsia.BLL;

namespace tripsia
{
    public partial class Airlines : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FeatureCollectionFeatureMember[] members = getAirlineCodes().featureMember;
                List<string> airlineCodes = new List<string>();

                foreach (FeatureCollectionFeatureMember m in members)
                {
                    airlineCodes.Add(m.title);
                }

                airlineDdl.DataSource = airlineCodes;
                airlineDdl.DataBind();

                airlineDdl.SelectedValue = "SIA";

                flightsRepeater.DataSource = getFlights(airlineDdl.SelectedValue).features;
                flightsRepeater.DataBind();
            }
        }

        protected void setAirline_Click(object sender, EventArgs e)
        {
            flightsRepeater.DataSource = getFlights(airlineDdl.SelectedValue).features;
            flightsRepeater.DataBind();
        }

        public Flights getFlights(string airlineCode)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri(
                        string.Format("https://api.laminardata.aero/v1/airlines/{0}/flights", airlineCode)
                    )
            };

            Flights data = null;
            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?format=json&user_key={0}",
                    System.Configuration.ConfigurationManager.AppSettings["lamindarDataApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            Debug.WriteLine(result.StatusCode);

            if (result.IsSuccessStatusCode)
            {
                var read = result.Content.ReadAsStringAsync();
                read.Wait();

                data = JsonConvert.DeserializeObject<Flights>(read.Result);
            }

            return data;
        }

        public FeatureCollection getAirlineCodes()
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://api.laminardata.aero/v1/airlines")
            };

            FeatureCollection data = null;
            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?user_key={0}",
                    System.Configuration.ConfigurationManager.AppSettings["lamindarDataApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            if (result.IsSuccessStatusCode)
            {
                var read = result.Content.ReadAsStringAsync();
                read.Wait();

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(read.Result);

                XmlReader reader = new XmlNodeReader(xmlDoc);
                XmlSerializer serializer = new XmlSerializer(typeof(FeatureCollection));
                data = (FeatureCollection)serializer.Deserialize(reader);
            }

            return data;
        }
    }
}