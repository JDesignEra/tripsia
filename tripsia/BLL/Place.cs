namespace tripsia.BLL
{
    public partial class Place
    {
        public object[] html_attributions { get; set; }
        public Result result { get; set; }
        public string status { get; set; }
    }

    public partial class Result
    {
        public string adr_address { get; set; }
        public string international_phone_number { get; set; }
        public Review[] reviews { get; set; }
    }

    public partial class Opening_Hours
    {
        public Period[] periods { get; set; }
        public string[] weekday_text { get; set; }
    }

    public partial class Period
    {
        public Close close { get; set; }
        public Open open { get; set; }
    }

    public partial class Close
    {
        public int day { get; set; }
        public string time { get; set; }
    }

    public partial class Open
    {
        public int day { get; set; }
        public string time { get; set; }
    }

    public partial class Review
    {
        public string author_name { get; set; }
        public string author_url { get; set; }
        public string language { get; set; }
        public string profile_photo_url { get; set; }
        public int rating { get; set; }
        public string relative_time_description { get; set; }
        public string text { get; set; }
        public int time { get; set; }
    }
}