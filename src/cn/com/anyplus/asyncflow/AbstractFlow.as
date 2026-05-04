package cn.com.anyplus.asyncflow
{
    public abstract class AbstractFlow implements IFlow{

        private var _isTerminated:Boolean = false;
        private var _completeHandler:Function;
        private var _exceptionHandler:Function;
        private var _vars:Object = {};
        private var _index:int = -1;
        private var _currentRunner:Runner;


        public function AbstractFlow(completeHandler:Function = null,exceptionHandler:Function = null)
        {
            _completeHandler = completeHandler;
            _exceptionHandler = exceptionHandler;

            step();
        }

        public function get vars():*
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

        abstract public function get total():int;

        abstract internal function getRunner(index:int):Runner;

        public function get index():int
        {
            return _index;
        }

        public function get currentRunner():Runner
        {
            return _currentRunner;
        }

        private function step():void{
            if(isTerminated){
                return;
            }
            
            _index++;
            if (_index < total)
            {
                var runner:Runner = getRunner(_index);
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


        /**
         * Exception is null means normal termination, otherwise means abnormal termination with exception.
         */
        public function terminate(exception:*=null):void
        {
            _isTerminated = true;

            if (exception != null){
                if (exceptionHandler != null){
                    exceptionHandler(exception);
                }else{
                    throw exception;
                }
            } else if (_completeHandler){
                _completeHandler();
            }
        }

        public function get isTerminated():Boolean
        {
            return _isTerminated;
        }

        internal function get exceptionHandler():Function
        {
            return _exceptionHandler;
        }

        internal function get completeHandler():Function
        {
            return _completeHandler;
        }
    }
    
}