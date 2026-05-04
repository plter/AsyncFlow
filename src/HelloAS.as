package
{
    import cn.com.anyplus.asyncflow.Flow;
    import cn.com.anyplus.asyncflow.Runner;

    public class HelloAS
    {
        public function HelloAS()
        {
            Flow.run(new <Runner>[
                Runner.build(function(flow:Flow):*{
                    console.log("Hello");
                }),
                Runner.sleep(1000),
                Runner.build(function(flow:Flow):*{
                    console.log("Async");
                    // flow.terminate();
                }),
                Runner.sleep(1000),
                Runner.build(function(flow:Flow):*{
                    console.log("Flow");
                })
            ]);
        }
    }
}