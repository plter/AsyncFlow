package cn.com.anyplus.asyncflow
{
    internal abstract class AbstractFlow implements IFlow{

        private var _isTerminated:Boolean = false;
        private var _completeHandler:Function;
        private var _exceptionHandler:Function;
        private var _vars:Object = {};
        private var _index:int = -1;
        private var _currentRunner:IRunner;
        private var _container:IRunner;


        public function AbstractFlow(container:IRunner, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            _container = container;
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
            if(vars.hasOwnProperty(name)){
                return _vars[name];
            }

            if(parent){
                return parent.getVar(name);
            }
            
            return undefined;
        }

        public function setVar(name:String, value:*):void
        {
            _vars[name] = value;
        }

        abstract public function get total():int;

        abstract internal function getRunner(index:int):IRunner;

        public function get index():int
        {
            return _index;
        }

        public function get currentRunner():IRunner
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
                var runner:Runner = getRunner(_index) as Runner;
                _currentRunner = runner;
                runner.setFlow(this);
                var result:* = runner.handler(this);
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

        public function get parent():IFlow
        {
            if(container){
                return container.flow;
            }
            return null;
        }

        public function get root():IFlow
        {
            if(parent){
                return parent.root;
            }
            return this;
        }

        internal function setContainer(value:IRunner):void
        {
            _container = value;
        }

        public function get container():IRunner
        {
            return _container;
        }
    }
    
}