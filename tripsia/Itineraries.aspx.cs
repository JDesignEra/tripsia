using System;
using System.Data;

namespace tripsia
{
    public partial class Itineraries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                BLL.Itinerary itinerary = new BLL.Itinerary(uid: int.Parse(Session["uid"].ToString()));
                DataTable itineraries = itinerary.GetByUid();

                if (itineraries != null)
                {
                    itinerariesRepeater.DataSource = itineraries;
                    itinerariesRepeater.DataBind();

                    emptyMsg.Style.Add("display", "none !important");
                }
                else
                {
                    emptyMsg.Style.Remove("display");
                }
            }
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            if (Session["uid"] != null && Page.IsValid)
            {
                BLL.Itinerary itinerary = new BLL.Itinerary(
                    title: newTitleTxtBox.Text.ToString(),
                    description: newDescTxtBox.Text.ToString(),
                    uid: int.Parse(Session["uid"].ToString())
                );

                if (itinerary.Create())
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        string.Format("toastSuccess('<strong>{0}</strong> itinerary created.');", itinerary.title),
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=itineraries.aspx");
                }
                else
                {
                    newTitleValidator.ErrorMessage = "There is already an itinerary with that Title, please enter a diffferent title.";
                    newTitleValidator.IsValid = false;

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "modal", string.Format("showModal('#newModal');"), true);
                }
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                BLL.Itinerary itinerary = new BLL.Itinerary(
                    id: int.Parse(editIdTxtBox.Text.ToString()),
                    title: editTitleTxtBox.Text.ToString(),
                    description: editDescTxtBox.Text.ToString(),
                    uid: int.Parse(Session["uid"].ToString())
                );

                if (itinerary.Update())
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        string.Format("toastSuccess('<strong>{0}</strong> itinerary updated.');", itinerary.title),
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=itineraries.aspx");
                }
                else
                {
                    editTitleTxtBoxValidator.ErrorMessage = "There is already an itinerary with that Title, please enter a diffferent title.";
                    editTitleTxtBoxValidator.IsValid = false;

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "modal", string.Format("showModal('#editModal');"), true);
                }
            }
        }

        protected void delBtn_Click(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                BLL.Itinerary itinerary = new BLL.Itinerary(id: int.Parse(delIdTxtBox.Text.ToString()), uid: int.Parse(Session["uid"].ToString()));

                if (itinerary.DeleteById())
                {
                    Page.ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "toast",
                        string.Format("toastSuccess('<strong>{0}</strong> itinerary deleted.');", delTitleTxtBox.Text.ToString()),
                        true
                    );

                    Response.AddHeader("REFRESH", "1;URL=itineraries.aspx");
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "toast",
                    string.Format("toastDanger('Fail to delete <strong>{0}</strong> itinerary.');", delTitleTxtBox.Text.ToString()),
                    true
                );

                Page.ClientScript.RegisterStartupScript(this.GetType(), "modal", "showModal('#delModal');", true);
            }
        }
    }
}