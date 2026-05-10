package
{
    import cn.com.anyplus.asyncflow.Flow;

    import http.ClientRequest;
    import http.ServerResponse;

    public class HelloAS
    {
        public function HelloAS()
        {
            http.createServer(function(req:ClientRequest,res:ServerResponse):void{
                Flow.run(
                    Flow.sleep(1000),
                    function():void{
                        res.end("Hello, AsyncFlow!");
                    }
                );
            }).listen(3000);
        }
    }
}