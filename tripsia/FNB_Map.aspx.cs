using Newtonsoft.Json;
using System;
using System.Data;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class FNB_Map : System.Web.UI.Page
    {
        private static Places places;

        protected void Page_load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                moreBtn.Enabled = places == null ? false : true;
            }
        }

        protected void setRadBtn_Click(object sender, EventArgs e)
        {
            string lat = latTxtBox.Text;
            string lng = lngTxtBox.Text;

            if (string.IsNullOrEmpty(radTxtBox.Text) || int.Parse(radTxtBox.Text) < 100 || int.Parse(radTxtBox.Text) > 5000)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "toast",
                    "toastDanger('Radius Search value has to be between 100 to 5000.');",
                    true
                );
            }
            else if (!string.IsNullOrEmpty(lat) && !string.IsNullOrEmpty(lng))
            {
                places = GetPlaces(radTxtBox.Text, lat, lng);

                if (places != null)
                {
                    placesRepeater.DataSource = places.results;
                    placesRepeater.DataBind();

                    setRadMsg.Style.Add("display", "none !important");

                    if (places.status != "OK")
                    {
                        emptyMsg.Style.Remove("display");
                    }

                    moreBtn.Enabled = string.IsNullOrEmpty(places.next_page_token) ? false : true;
                }
                else
                {
                    setRadMsg.Style.Add("display", "none !important");
                    emptyMsg.Style.Remove("display");
                }
            }
        }

        protected void moreBtn_Click(object sender, EventArgs e)
        {
            if (places != null)
            {
                places = GetMorePlaces(places);

                placesRepeater.DataSource = places.results;
                placesRepeater.DataBind();

                setRadMsg.Style.Add("display", "none !important");

                if (places.status != "OK")
                {
                    emptyMsg.Style.Remove("display");
                }

                moreBtn.Enabled = string.IsNullOrEmpty(places.next_page_token) ? false : true;
            }
            else
            {
                setRadMsg.Style.Add("display", "none !important");
                emptyMsg.Style.Remove("display");
            }
        }

        protected void detailsBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string pid = btn.Attributes["data-id"];
            DataTable reviews = new FnbReviews(pid: pid).getByPidSortByDate();

            if (reviews != null)
            {
                tripsiaReviewsRepeater.DataSource = reviews;
                tripsiaReviewsRepeater.DataBind();

                emptyReviews.Style.Add("display", "none !important");
                tripsiaReviews.Style.Remove("display");
            }
            else
            {
                emptyReviews.Style.Remove("display");
                tripsiaReviews.Style.Add("display", "none !important");
            }

            // Google Reviews
            Place data = getPlaceDetails(btn.Attributes["data-id"]);

            if (data != null)
            {
                Result result = data.result;
                string priceLvl = "";

                for (int i = 0; i <= result.price_level; i++)
                {
                    priceLvl += "$";
                }

                placeMainImg.ImageUrl = getPlacePhotoAsync(result.photos[0].photo_reference);
                nameLbl.Text = result.name;
                ratingLbl.Text = result.rating.ToString();
                rateNoLbl.Text = string.Format("({0})", result.user_ratings_total.ToString());
                addrLbl.Text = result.adr_address;
                phoneLbl.Text = result.international_phone_number;
                priceLbl.Text = priceLvl;
                openNowLbl.Text = result.opening_hours != null && result.opening_hours.open_now ? "Open Now" : "Close Now";
                openNowLbl.CssClass = result.opening_hours != null && result.opening_hours.open_now ? "text-success w-100" : "text-danger w-100";

                googleReviewsRepeater.DataSource = result.reviews;
                googleReviewsRepeater.DataBind();

                if (result.opening_hours != null)
                {
                    openDaysRepeater.DataSource = result.opening_hours.weekday_text;
                    openDaysRepeater.DataBind();
                }
            }
        }

        protected void leaveReviewBtn_Click(object sender, EventArgs e)
        {
            if (Session["uid"] != null && Page.IsValid)
            {
                FnbReviews hotelReviews = new FnbReviews(
                    review: reviewTxtBox.Text,
                    pid: idTxtBox.Text,
                    uid: int.Parse(Session["uid"].ToString()),
                    rating: float.Parse(ratingTxtBox.Text),
                    dateTime: DateTime.Now
                );

                if (hotelReviews.Create())
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        this.GetType(),
                        "toast",
                        "toastSuccess('Review submitted successfully.');",
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=fnb_map.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        this.GetType(),
                        "toast",
                        "toastDanger('Review failed to submit.');",
                        true
                    );
                }
            }
        }

        protected void placesRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (Session["uid"] == null)
            {
                HtmlButton btn = (HtmlButton)e.Item.FindControl("leaveReviewBtn");
                btn.Style.Add("display", "none !important");
            }
        }

        public Places GetPlaces(string radius, string lat, string lng)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
            };

            Places data = null;
            Result[] results = new Result[0];

            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?location={0},{1}&radius={2}&type=restaurant&key={3}",
                    lat,
                    lng,
                    radius,
                    System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            if (result.IsSuccessStatusCode)
            {
                int resultsOrgLen = results.Length;
                var read = result.Content.ReadAsStringAsync();
                read.Wait();

                data = JsonConvert.DeserializeObject<Places>(read.Result);

                Array.Resize<Result>(ref results, resultsOrgLen + data.results.Length);
                Array.Copy(data.results, 0, results, resultsOrgLen, data.results.Length);

                while (!string.IsNullOrEmpty(data.next_page_token) && results.Length < 60)
                {
                    response = client.GetAsync(
                        string.Format(
                            "?pagetoken={0}&key={1}",
                            data.next_page_token,
                            System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                        )
                    );

                    response.Wait();

                    result = response.Result;

                    if (result.IsSuccessStatusCode)
                    {
                        read = result.Content.ReadAsStringAsync();
                        read.Wait();

                        Places loopData = JsonConvert.DeserializeObject<Places>(read.Result);
                        resultsOrgLen = results.Length;

                        Array.Resize<Result>(ref results, resultsOrgLen + loopData.results.Length);
                        Array.Copy(loopData.results, 0, results, resultsOrgLen, loopData.results.Length); ;
                    }
                }

                data.results = results;
            }

            return data;
        }

        public Places GetMorePlaces(Places places)
        {
            Places data = places;

            if (!string.IsNullOrEmpty(data.next_page_token))
            {
                HttpClient client = new HttpClient
                {
                    BaseAddress = new Uri("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
                };

                Result[] results = new Result[0];
                int resultsOrgLen = results.Length;
                int newLen = data.results.Length + 60;

                Array.Resize<Result>(ref results, resultsOrgLen + data.results.Length);
                Array.Copy(data.results, 0, results, resultsOrgLen, data.results.Length);

                Task<HttpResponseMessage> response;

                while (!string.IsNullOrEmpty(data.next_page_token) && results.Length < newLen)
                {
                    response = client.GetAsync(
                        string.Format(
                            "?pagetoken={0}&key={1}",
                            data.next_page_token,
                            System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                        )
                    );

                    response.Wait();

                    var result = response.Result;

                    if (result.IsSuccessStatusCode)
                    {
                        var read = result.Content.ReadAsStringAsync();
                        read.Wait();

                        Places loopData = JsonConvert.DeserializeObject<Places>(read.Result);
                        resultsOrgLen = results.Length;

                        Array.Resize<Result>(ref results, resultsOrgLen + loopData.results.Length);
                        Array.Copy(loopData.results, 0, results, resultsOrgLen, loopData.results.Length); ;
                    }

                    data.results = results;
                }
            }

            return data;
        }

        public Place getPlaceDetails(string placeId)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://maps.googleapis.com/maps/api/place/details/json")
            };

            Place data = null;
            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?place_id={0}&fields=name,opening_hours,price_level,rating,user_ratings_total,international_phone_number,reviews,adr_address,photos&key={1}",
                    placeId,
                    System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            if (result.IsSuccessStatusCode)
            {
                var read = result.Content.ReadAsStringAsync();
                read.Wait();

                data = JsonConvert.DeserializeObject<Place>(read.Result);
            }

            return data;
        }

        public string getPlacePhotoAsync(string photoRef, int maxWidth = 1600)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://maps.googleapis.com/maps/api/place/photo")
            };

            string data = null;
            Task<HttpResponseMessage> response;

            response = client.GetAsync(
                string.Format(
                    "?maxwidth={0}&photoreference={1}&key={2}",
                    maxWidth,
                    photoRef,
                    System.Configuration.ConfigurationManager.AppSettings["googleApi"]
                )
            );

            response.Wait();

            var result = response.Result;

            if (result.IsSuccessStatusCode)
            {
                var read = result.Content.ReadAsByteArrayAsync();
                read.Wait();

                data = string.Format("data:image/png;base64,{0}", Convert.ToBase64String(read.Result));
            }

            return data;
        }
    }
}