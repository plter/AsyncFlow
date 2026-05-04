package cn.com.anyplus.asyncflow
{
    internal class PipelineFlow extends AbstractFlow
    {

        
        private var _runners:Vector.<Runner>;
        private var _index:int = -1;

        public function PipelineFlow(runners:Vector.<Runner>, completeHandler:Function = null, exceptionHandler:Function = null)
        {
            _runners = runners;
            super(completeHandler, exceptionHandler);
        }

        override public function get total():int
        {
            return _runners.length;
        }

        override internal function getRunner(index:int):Runner
        {
            return _runners[index];
        }

    }
}