package cn.com.anyplus.asyncflow
{
    public class Runner
    {
        private var _name:String;
        private var _func:Function;

        private function Runner(func:Function, name:String = null)
        {
            _name = name;
            _func = func;
        }

        public function get name():String
        {
            return _name;
        }

        internal function execute(flow:Flow):*
        {
            return _func(flow);
        }

        public static function sleep(delay:int):Runner
        {
            return new Runner(function(flow:Flow):Future{
                return Future.sleep(delay);
            });
        }

        public static function build(func:Function, name:String = null):Runner
        {
            return new Runner(func, name);
        }
    }
}