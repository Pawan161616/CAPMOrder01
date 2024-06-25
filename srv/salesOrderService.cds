using {pawan.db.master } from '../db/datamodel';
//service name will be till next upper case letter. here it would be till "sales"
//with annotation @(path:''), you can use full service name i.e. 'salesOrderService'
service salesOrderService @(path:'/salesOrderService') {
   entity OrderSet as projection on master.Order;
   entity OrderItemSet as projection on master.Order_Items;
   entity ProductSet as projection on master.Product;
   entity EmployeeSet as projection on master.Employee;
   
//this code for association not needed. if association is configured directly while defining table
//it works automatically.
//    entity order @(
//       title: '{i18n>orderHeader}'
//    ) as projection on master.Order{
//       *,
//       Order_Items: redirected to master.Order_Items
//    }

//   entity orderItems @(
//    title: '{i18n>orderItems}')
//    as projection on master.Order_Items{
//       *,
//       Order_Id: redirected to order,
//       Product_Id: redirected to ProductSet
//    }
    
}