namespace pawan.db;
//below we are using standard aspects from @sap/cds/commons
//aspects are structures which can be standard or custom and can be used in any table
using { cuid , managed, Currency, temporal} from '@sap/cds/common';
using {pawan.common} from './common';
context master {
     entity Order {
        key Order_Id: String(20);
        Order_No: Int64;
        Date: Date;
        Customer_Name: String(20);
        Total: Int16;
        Currency_Code:String(5);
        Order_Items: Association to one Order_Items on Order_Items.Order_Id = $self;
        //association created between order and order_items tables using join.
        //$self means order_ID of table Order_items will be checked with primary key of order table
         //this feature is like check table in se11 for Order_Items column
    }

    entity Order_Items {
        key Item_Id: String(20);
        //as Order_Id of this table is linked with Order_Items of Order table,
        //in service it will take this feild as concatinate of both fileds (Order_Id_Order_ID) so
        //change the column name to Order_Id_Order_ID in csv table.
        Order_Id: Association to Order;
        Order_No: Int64;
        Item_No: Int64;
        Qty: Int64;
        Product_Id: Association to Product;
        //Association created betweeb order_items and product table
        //here product_id of order_items will be checked against primary key of product table.
        //this feature is like check table in se11 for product_id column
    }
    entity Product: common.Amount {
       key Product_Id: String(20);
       //system will create a table automatically with <tablename_text> Product_text
       //in csv folder we have set product names in de and es language in Product_text file
       //in browser for product names are not given in either of language, it will fetch the name from Product.csv
       //else if browser lang is set to es or de , it will fetch product name in same language from Product_text.csv
        Product_Name: localized String(200);
        Company: String(200);
        Order_Items: Association to one Order_Items on Order_Items.Product_Id = $self;
    }
    //cuid is standard aspect used for uuid ,hence we are not making id column for table explicitely.
    entity Employee:cuid  {
        First_Name: String(40);	
        Last_Name: String(40);	
        Email: common.Email;			
        gender:	common.Gender;
        Language: String(40);
        Phone_Number: common.PhoneNumber;
        // Currency_Code: Currency;
        Currency_Code: String(10);
        Account_Number: String(160);
    }
    //Below we are creating i18n text for First_name and Last_Name column of employee table
    annotate Employee with {
        First_Name @title : '{i18n>FirstName}';
        Last_Name @title : '{i18n>LastName}';
        Email @title: '{i18n>Email}';
        gender @title: '{i18n>gender}';
        Language @title: '{i18n>Language}';
        Phone_Number @title: '{i18n>Phone_Number}';
        Currency_Code @title: '{i18n>Currency_Code}';
        Account_Number @title: '{i18n>Account_Number}';
        
    }
}

