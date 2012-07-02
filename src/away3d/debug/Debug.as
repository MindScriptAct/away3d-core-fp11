package COMMENT : todo.debug
{
    /** 
	 * Class for emmiting debuging messages, warnings and errors 
	 */
    public class Debug
    {
        public static var active:Boolean = false;
        public static var warningsAsErrors:Boolean = false;

		/**
		 * COMMENT : todo 
		 */
        public static function clear():void
        {
        }
        
		/**
		 * COMMENT : todo 
		 */
        public static function delimiter():void
        {
        }
        
		/**
		 * COMMENT : todo
		 * @param	message		COMMENT : todo
		 */
        public static function trace(message:Object):void
        {
        	if (active)
           		dotrace(message);
        }
        
		/**
		 * COMMENT : todo
		 * @param	message		COMMENT : todo
		 */
        public static function warning(message:Object):void
        {
            if (warningsAsErrors)
            {
                error(message);
                return;
            }
            trace("WARNING: "+message);
        }
        
		/**
		 * COMMENT : todo
		 * @param	message		COMMENT : todo
		 */
        public static function error(message:Object):void
        {
            trace("ERROR: "+message);
            throw new Error(message);
        }
    }
}

/**
 * @private
 */
function dotrace(message:Object):void
{
    trace(message);
}