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
                Flow.runner(function(flow:IFlow):*{
                    console.log("Hello");
                }),
                Flow.loopRunner(function(flow:IFlow):*{
                    console.log("Loop",flow.index,flow.parent);
                }, 3),
                Flow.sleep(1000),
                Flow.runner(function(flow:IFlow):*{
                    console.log("Async");
                    // runner.flow.terminate();
                }),
                Flow.sleep(1000),
                Flow.runner(function(flow:IFlow):*{
                    console.log("Flow");
                })
            ]);
        }
    }
}