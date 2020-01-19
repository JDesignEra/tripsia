﻿using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using tripsia.BLL;

namespace tripsia
{
    public partial class Itinerary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                if (Request["id"] != null)
                {
                    DataTable dates = new ItineraryEvent(iid: int.Parse(Request["id"])).getDateNoDupeByIid();

                    if (dates != null)
                    {
                        emptyMsg.Style.Add("display", "none !important");
                        cardRepeater.DataSource = dates;
                        cardRepeater.DataBind();
                    }
                    else
                    {
                        emptyMsg.Style.Remove("display");
                    }
                }
            }
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            DateTime dateTime = DateTime.ParseExact(string.Format("{0} {1}", newDateTxtBox.Text.ToString(), newTimeTxtBox.Text.ToString()), "dd/MM/yyyy hh:mmtt", null);
            ItineraryEvent itineraryEvent = new ItineraryEvent(iid: int.Parse(Request["id"]), title: newTitleTxtBox.Text.ToString(), description: newDescTxtBox.Text.ToString(), dateTime: dateTime);

            if (itineraryEvent.Create())
            {
                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    string.Format("toastSuccess('{0} added successfully.');", itineraryEvent.title),
                    true
                );

                Response.AddHeader("REFRESH", string.Format("1;URL=itinerary.aspx?id={0}", Request["id"]));
            }
            else
            {
                newDateValidator.ErrorMessage = "A schedule with that date and time already exist.";
                newDateValidator.IsValid = false;

                newTimeValidator.ErrorMessage = "A schedule with that date and time already exist.";
                newTimeValidator.IsValid = false;

                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    "toastDanger('A schedule with that date and time already exist.');",
                    true
                );

                Page.ClientScript.RegisterStartupScript(this.GetType(), "modal", "showModal('#newModal');", true);
            }
        }

        protected void editBtn_Click(object sender, EventArgs e)
        {
            DateTime dateTime = DateTime.ParseExact(string.Format("{0} {1}", editDateTxtBox.Text.ToString(), editTimeTxtBox.Text.ToString()), "dd/MM/yyyy hh:mmtt", null);
            
        }

        public void cardRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataRowView row = (DataRowView)e.Item.DataItem;
            DateTime date = Convert.ToDateTime(row["dateTime"].ToString());

            ItineraryEvent itineraryEvent = new ItineraryEvent(iid: int.Parse(Request["id"].ToString()), dateTime: date);
            DataTable events = itineraryEvent.getByDate();

            Repeater eventRepeater  = (Repeater) e.Item.FindControl("eventRepeater");
            eventRepeater.DataSource = events;
            eventRepeater.DataBind();
        }

        protected void TimeValidate(object sender, ServerValidateEventArgs e)
        {
            Regex regex = new Regex(@"^(0[1-9]|1[0-2]):[0-5][0-9](am|pm|AM|PM)$");

            if(!regex.IsMatch(e.Value.ToString()))
            {
                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    "toastDanger('Time format is invalid.');",
                    true
                );
            }
        }

        protected void DateValidate(object sender, ServerValidateEventArgs e)
        {
            Regex regex = new Regex(@"(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$");

            if (!regex.IsMatch(e.Value.ToString()))
            {
                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    "toastDanger('Date format is invalid.');",
                    true
                );
            }
        }
    }
}