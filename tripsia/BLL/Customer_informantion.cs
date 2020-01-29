using System;
using System.Collections.Generic;
using System.Linq;
using tripsia.DAL;
using System.Web;

namespace tripsia.BLL
{
    public class Customer_information
    {
        public string Id { get; set; }
        public string tdName { get; set; }
        public string tdIc { get; set; }
        public string tdAddress { get; set; }
        public string tdMobile { get; set; }
        public Customer_information()
        {

        }
        public Customer_information(string id, string name, string ic, string address, string mobile)
        {
            Id = id;
            tdName = name;
            tdIc = ic;
            tdAddress = address;
            tdMobile = mobile;

        }
        public Customer_information GetCustomerById(string id)
        {
            customer_informationDAO customer_informationdao = new customer_informationDAO();
            return customer_informationdao.SelectById(id);
        }
    }
}