package cn.com.anyplus.asyncflow
{
    public class Flow extends AbstractFlow
    {

        
        private var _runners:Vector.<Runner>;
        private var _index:int = -1;
        private var _currentRunner:Runner;

        private function Flow(runners:Vector.<Runner>, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            super(completeHandler, exceptionHandler);
            _runners = runners;

            step();
        }

        public function get currentRunner():Runner
        {
            return _currentRunner;
        }

        override internal function step():void
        {

            if(isTerminated){
                return;
            }
            
            _index++;
            if (_index < _runners.length)
            {
                var runner:Runner = _runners[_index];
                _currentRunner = runner;
                var result:* = runner.execute(this);
                if (result is Future)
                {
                    var future:Future = result as Future;
                    future.then(function(res:*):void{
                        if(runner.name){
                            setVar(runner.name, res);
                        }
                        step();
                    }).catch(function(exception:*):void{
                        terminate(exception);
                    });
                }
                else
                {
                    if(runner.name){
                        setVar(runner.name, result);
                    }
                    step();
                }
            }else{
                terminate();
            }
        }

        public static function run(runners:Vector.<Runner>):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                new Flow(runners, resolve, reject);
            });
        }
    }
}