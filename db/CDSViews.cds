namespace pawan.db;
using{pawan.db.master} from './datamodel';
context CDSViews {
    //we are defining view here
    //writing name inside ![] makes it case sensitive
    define view![OrderWorklist] as 
    select from master.Order{
    key Order_Id as ![OrderId],
        Order_No as ![OrderNumber],
        Date as ![Date],
        Customer_Name as ![CustomerName],
        Total as ![TotalPrice],
        Currency_Code as ![CurrencyCode],
    key Order_Items.Item_Id as ![OrderItemId],
        Order_Items.Item_No as ![OrderItemNo]
        
    };

    //@EndUserText.label annotation is like we  annotate Employee in datamodel.cds.
//  it will store label name in diferent languages.
    define view ProductValueHelp as 
       select from master.Product{
        @EndUserText.label:[
            {
                language:'EN',
                text: 'Product ID'
            },{
                language:'DE',
                text: 'Produkt ID'
            }
        ]
        Product_Id as ![ProductId],
        @EndUserText.label:[
            {
                language:'EN',
                text:'Product Name'
            },{
                language: 'DE',
                text: 'Produkt Name'
            }
        ]
        Product_Name as ![ProductName],
        @EndUserText.label:[
            {
                language:'EN',
                text:'Company'
            },{
                language:'DE',
                text:'Firma'
            }
        ]
        Company as ![Company],
        @EndUserText.Label:[{
            language:'EN',
            text:'Order Items'
        },{
            language:'DE',
            text:'Auftragspositionen'
        }]
        //since orderItems is aggregation if we are including product id of order items table, then 
        //first name of aggregatin.name of feild of table with which it is aggregated.
        Order_Items.Order_Id as ![OrderItems]

       };

    //    define view ![OrderItemView] as
    //    select from master.Order_Items{
    //     Item_Id as ![OrderItemId],
    //     Order_Id as ![OrderId],
    //     Order_No as ![OrderNo],
    //     Item_No as ![ItemNo],
    //     Qty as ![Quantity],
    //     Product_Id.Product_Id as ![ProductId]
    //    }

       define view OrderItemView as 
       select from master.Order_Items as OrderItem{
             Item_Id as ![OrderItemId],
             Order_Id as ![OrderId],
             Order_No as ![OrderNo],
             Item_No as ![ItemNo],
             Qty as ![Quantity],
             (
                select from master.Product as a{
                    Product_Id as ![ProductId]
                }where a.Product_Id = OrderItem.Product_Id.Product_Id
             )as ![ProductId]
       };

//proection view
       define view OrderView as select from master.Order
       //mixin mean I am exposing this association out
       mixin{
          Orders: Association[*] to OrderItemView on
                                     Orders.OrderId = $projection.OrderId
                         
       }into{
        Order_Id as ![OrderId],
        Order_No as ![OrderNumber],
        Customer_Name as ![CustomerName],
        //here Order_Item is association of Order table , Product_Id is of Order item table linking to Product table field product_Name field
        //this is how we navigate from one table to another via associations
        Order_Items.Product_Id.Product_Name as ![ProductName],
        //if we want to use field of orderItemView, then find with what name it's associated to orderView i.e, "Orders"
        //then use it as normal association <association>.<field name of associated view>
        sum(Orders.Quantity) as ![TotalQuantity],
        Orders.OrderItemId as ![OrderItemId]    
       }

       //consumption view
       define view COrderView as 
       select from OrderView{
        OrderId,
        OrderNumber,
        ProductName
       }
       group by OrderId,OrderNumber
}

