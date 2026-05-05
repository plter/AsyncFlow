package cn.com.anyplus.asyncflow
{
    public interface IFlow
    {
        function terminate(exception:* = null):void;

        function get vars():*;

        function getVar(name:String):*;

        function setVar(name:String, value:*):void;

        function get isTerminated():Boolean;

        function get currentRunner():IRunner;

        function get total():int;

        function get index():int;

        function get parent():IFlow;

        function get root():IFlow;

        function get container():IRunner;
    }
}