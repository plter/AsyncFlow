package cn.com.anyplus.asyncflow
{
    internal class LoopFlow extends AbstractFlow
    {
        private var _runner:IRunner;
        private var _index:int = -1;
        private var _count:int;

        public function LoopFlow(runner:IRunner, times:int, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            _runner = runner;
            _count = times;
            super(completeHandler, exceptionHandler);
        }

        override public function get total():int
        {
            return _count;
        }

        override internal function getRunner(index:int):IRunner
        {
            return _runner;
        }
    }
}