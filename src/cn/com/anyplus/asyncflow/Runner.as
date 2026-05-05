package cn.com.anyplus.asyncflow
{
    internal final class Runner implements IRunner
    {
        private var _name:String;
        private var _handler:Function;
        private var _flow:IFlow;

        public function Runner(handler:Function, name:String = null)
        {
            _name = name;
            _handler = handler;
        }

        public function get name():String
        {
            return _name;
        }

        public function get handler():Function
        {
            return _handler;
        }
    }
}