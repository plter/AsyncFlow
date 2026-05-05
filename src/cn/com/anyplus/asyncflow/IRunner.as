package cn.com.anyplus.asyncflow
{
    public interface IRunner
    {
        function get name():String;

        function get handler():Function;

        function get flow():IFlow;
    }
}