package cn.com.anyplus.asyncflow
{
    internal class PipelineFlow extends AbstractFlow
    {

        
        private var _runners:Vector.<IRunner>;
        private var _index:int = -1;

        public function PipelineFlow(container:IRunner, runners:Vector.<IRunner>, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            _runners = runners;
            super(container, completeHandler, exceptionHandler);
        }

        override public function get total():int
        {
            return _runners.length;
        }

        override internal function getRunner(index:int):IRunner
        {
            return _runners[index];
        }

    }
}