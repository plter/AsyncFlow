package
{
    import cn.com.anyplus.asyncflow.Flow;
    import cn.com.anyplus.asyncflow.IFlow;
    import cn.com.anyplus.asyncflow.Runner;

    public class HelloAS
    {
        public function HelloAS()
        {
            Flow.pipeline(new <Runner>[
                Runner.build(function(flow:IFlow):*{
                    console.log("Hello");
                }),
                Runner.loop(function(flow:IFlow):*{
                    console.log("Loop",flow.index);
                }, 3),
                Runner.sleep(1000),
                Runner.build(function(flow:IFlow):*{
                    console.log("Async");
                    // flow.terminate();
                }),
                Runner.sleep(1000),
                Runner.build(function(flow:IFlow):*{
                    console.log("Flow");
                })
            ]);
        }
    }
}