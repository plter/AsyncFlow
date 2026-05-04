package cn.com.anyplus.asyncflow
{
    public class Flow
    {

        private var _vars:Object = {};
        private var _runners:Vector.<Runner>;
        private var _index:int = -1;
        private var _exceptionHandler:Function;

        private function Flow(runners:Vector.<Runner>, exceptionHandler:Function = null)
        {
            _runners = runners;
            _exceptionHandler = exceptionHandler;

            step();
        }

        public function get vars():Object
        {
            return _vars;
        }

        public function getVar(name:String):*
        {
            return _vars[name];
        }

        public function setVar(name:String, value:*):void
        {
            _vars[name] = value;
        }

        private function step():void
        {
            _index++;
            if (_index < _runners.length)
            {
                var runner:Runner = _runners[_index];
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
                        if (_exceptionHandler)
                        {
                            _exceptionHandler(exception);
                        }
                        else
                        {
                            throw exception;
                        }
                    });
                }
                else
                {
                    if(runner.name){
                        setVar(runner.name, result);
                    }
                    step();
                }
            }
        }

        public static function run(runners:Vector.<Runner>, exceptionHandler:Function = null):Flow
        {
            return new Flow(runners, exceptionHandler);
        }
    }
}