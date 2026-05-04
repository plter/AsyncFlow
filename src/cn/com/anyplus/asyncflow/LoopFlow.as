package cn.com.anyplus.asyncflow
{
    internal class LoopFlow extends AbstractFlow
    {
        private var _runner:Runner;
        private var _index:int = -1;
        private var _count:int;

        public function LoopFlow(runner:Runner, times:int, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            _runner = runner;
            _count = times;
            super(completeHandler, exceptionHandler);
        }

        override public function get total():int
        {
            return _count;
        }

        override internal function getRunner(index:int):Runner
        {
            return _runner;
        }
    }
}