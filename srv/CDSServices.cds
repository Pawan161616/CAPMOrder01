using {pawan.db.CDSViews } from '../db/CDSViews';
using {pawan.db.master} from '../db/datamodel';
//we will expose our cds views here
service CDSService@(path:'/CDSService') {
    // entity OrderWorklist as projection on CDSViews.OrderWorklist;
    entity OrderItemSrv as projection on CDSViews.OrderItemView;
    entity OrderAggregation as projection on CDSViews.COrderView;
     
// //@EndUserText.label annotation is like we  annotate Employee in datamodel.cds.
// //  it will store label name in diferent languages.
//     define View ProductValueHelp as
//        select from master.Product{ 
//         @EndUserText.label:[ 
//             {
//                 language:'EN',
//                 text: 'Product ID'
//             },{
//                 language:'DE',
//                 text: 'Produkt ID'
//             }
//         ]
//         Product_Id as ![ProductId],
//         @EndUserText.label:[
//             {
//                 language:'EN',
//                 text:'Product Name'
//             },{
//                 language: 'DE',
//                 text: 'Produkt Name'
//             }
//         ]
//         Product_Name as ![ProductName],
//         @EndUserText.label:[
//             {
//                 language:'EN',
//                 text:'Company'
//             },{
//                 language:'DE',
//                 text:'Firma'
//             }
//         ]
//         Company as ![Company],
//         @EndUserText.Label:[{
//             language:'EN',
//             text:'Order Items'
//         },{
//             language:'DE',
//             text:'Auftragspositionen'
//         }]
//         //since orderItems is aggregation if we are including product id of order items table, then 
//         //first name of aggregatin.name of feild of table with which it is aggregated.
//         Order_Items.Order_Id as ![OrderItems]

//        };

//        define view ![OrderItemView] as
//        select from master.Order_Items{
//         Item_Id as ![OrderItemId],
//         Order_Id as ![OrderId],
//         Order_No as ![OrderNo],
//         Item_No as ![ItemNo],
//         Qty as ![Quantity],
//         Product_Id.Product_Id as ![ProductId]
//        }

}

