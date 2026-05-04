package cn.com.anyplus.asyncflow
{
    public class Flow{

        public static function pipeline(runners:Vector.<Runner>):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                new PipelineFlow(runners, resolve, reject);
            });
        }

        public static function loop(runner:Runner, times:int):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                new LoopFlow(runner, times, resolve, reject);
            });
        }
    }
}