package
{
    import cn.com.anyplus.asyncflow.Flow;
    import cn.com.anyplus.asyncflow.Runner;

    public class HelloAS
    {
        public function HelloAS()
        {
            Flow.run(new <Runner>[
                Runner.setup(function(flow:Flow):*{
                    console.log("Hello");
                }),
                Runner.sleep(1000),
                Runner.setup(function(flow:Flow):*{
                    console.log("Async");
                }),
                Runner.sleep(1000),
                Runner.setup(function(flow:Flow):*{
                    console.log("Flow");
                })
            ])
        }
    }
}