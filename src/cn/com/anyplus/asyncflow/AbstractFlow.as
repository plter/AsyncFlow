package cn.com.anyplus.asyncflow
{
    public abstract class AbstractFlow{

        private var _isTerminated:Boolean = false;
        private var _completeHandler:Function;
        private var _exceptionHandler:Function;
        private var _vars:Object = {};


        public function AbstractFlow(completeHandler:Function = null,exceptionHandler:Function = null)
        {
            _completeHandler = completeHandler;
            _exceptionHandler = exceptionHandler;
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

        internal abstract function step():void;


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