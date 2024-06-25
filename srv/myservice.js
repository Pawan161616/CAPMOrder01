const mysrvdemo = function(srv){
    srv.on("myfunction",(req,res)=>{
        return "hello " + req.data.msg;
    });
}
module.exports = mysrvdemo;