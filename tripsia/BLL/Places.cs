﻿namespace tripsia.BLL
{
    public partial class Places
    {
        public object[] html_attributions { get; set; }
        public string next_page_token { get; set; }
        public Result[] results { get; set; }
        public string status { get; set; }
    }

    public partial class Result
    {
        public string formatted_address { get; set; }
        public Geometry geometry { get; set; }
        public string icon { get; set; }
        public string id { get; set; }
        public string name { get; set; }
        public Opening_Hours opening_hours { get; set; }
        public Photo[] photos { get; set; }
        public string place_id { get; set; }
        public Plus_Code plus_code { get; set; }
        public int price_level { get; set; }
        public float rating { get; set; }
        public string reference { get; set; }
        public string scope { get; set; }
        public string[] types { get; set; }
        public int user_ratings_total { get; set; }
        public string vicinity { get; set; }
    }

    public partial class Geometry
    {
        public Location location { get; set; }
        public Viewport viewport { get; set; }
    }

    public partial class Location
    {
        public float lat { get; set; }
        public float lng { get; set; }
    }

    public partial class Viewport
    {
        public Northeast northeast { get; set; }
        public Southwest southwest { get; set; }
    }

    public partial class Northeast
    {
        public float lat { get; set; }
        public float lng { get; set; }
    }

    public partial class Southwest
    {
        public float lat { get; set; }
        public float lng { get; set; }
    }

    public partial class Opening_Hours
    {
        public bool open_now { get; set; }
    }

    public partial class Plus_Code
    {
        public string compound_code { get; set; }
        public string global_code { get; set; }
    }

    public partial class Photo
    {
        public int height { get; set; }
        public string[] html_attributions { get; set; }
        public string photo_reference { get; set; }
        public int width { get; set; }
    }
}