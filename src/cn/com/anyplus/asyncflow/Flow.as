package cn.com.anyplus.asyncflow
{
    public class Flow{

        public static function fall(runners:Vector.<IRunner>):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                new PipelineFlow(runners, resolve, reject);
            });
        }

        public static function loop(handler:Function, times:int):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                new LoopFlow(runner(handler), times, resolve, reject);
            });
        }

        public static function loopRunner(handler:Function, times:int):IRunner
        {
            return runner(function(flow:IFlow):Future{
                return Flow.loop(handler, times);
            });
        }

        public static function fallRunner(runners:Vector.<IRunner>):IRunner
        {
            return runner(function(flow:IFlow):Future{
                return Flow.fall(runners);
            });
        }

        public static function runner(func:Function, name:String = null):IRunner
        {
            return new Runner(func, name);
        }

        public static function sleep(delay:int):IRunner
        {
            return runner(function(flow:IFlow):IFuture{
                return future(function(resolve:Function, reject:Function):void{
                    setTimeout(resolve, delay);
                });
            });
        }

        public static function future(callback:Function):IFuture
        {
            return new Future(callback);
        }
    }
}