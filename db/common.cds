namespace pawan.common;

using {sap,Currency, temporal, managed} from '@sap/cds/common';

//enumerator - fixed set of values 
type Gender: String(1) enum {
    male = 'M';
    female = 'F';
    nonBinary = 'N';
    nonDisclosure = 'D';
    selfDescribe = 'S';
};
//validations
type PhoneNumber : String(30)@assert.format : '(?:(?:(\s*\(?([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\)?\s*(?:[.-]\s*)?)([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})';
type Email : String(255)@assert.format: '[a-z0-9]+@[a-z]+\.[a-z]{2,3}';

//abstract entity - to use set of fields in different tables
type AmountT: Decimal(15,2)@(
    semantics.amount.currencycode: 'Currency_Code',
    sap.unit:'Currency_code'
);
abstract entity Amount{
    Price: AmountT;
    Currency_Code: String(5);
};