package cn.com.anyplus.asyncflow
{
    internal class Future implements IFuture
    {

        private var _result:*;
        private var _isResolved:Boolean = false;
        private var _onResolved:Function;
        private var _exception:*;
        private var _exceptionOccurred:Boolean = false;
        private var _onRejected:Function;

        public function Future(callback:Function)
        {
            callback(function(result:*):void{
                _result = result;
                _isResolved = true;
                if (_onResolved != null)
                {
                    _onResolved(_result);
                }
            }, function(exception:*):void{
                _exception = exception;
                _exceptionOccurred = true;
                if (_onRejected != null)
                {
                    _onRejected(_exception);
                }
            });
        }

        public function then(onResolved:Function):Future{
            _onResolved = onResolved;
            if (_isResolved)
            {
                _onResolved(_result);
            }
            return this;
        }

        public function catch(onRejected:Function):Future{
            _onRejected = onRejected;
            if (_exceptionOccurred)
            {
                _onRejected(_exception);
            }
            return this;
        }

        public static function fromPromise(promise:Promise):Future
        {
            return new Future(function(resolve:Function, reject:Function):void{
                promise.then(function(result:*):void{
                    resolve(result);
                }).catch(function(exception:*):void{
                    reject(exception);
                });
            });
        }
    }
}