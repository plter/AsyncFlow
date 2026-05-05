package
{
    import cn.com.anyplus.asyncflow.Flow;
    import cn.com.anyplus.asyncflow.IFlow;
    import cn.com.anyplus.asyncflow.IRunner;

    public class HelloAS
    {
        public function HelloAS()
        {
            Flow.fall(new <IRunner>[
                Flow.runner(function(runner:IFlow):*{
                    console.log("Hello");
                }),
                Flow.loopRunner(function(runner:IFlow):*{
                    console.log("Loop",runner.index);
                }, 3),
                Flow.sleep(1000),
                Flow.runner(function(runner:IFlow):*{
                    console.log("Async");
                    // runner.flow.terminate();
                }),
                Flow.sleep(1000),
                Flow.runner(function(runner:IFlow):*{
                    console.log("Flow");
                })
            ]);
        }
    }
}