package away3d.errors
{
	/**
	 * COMMENT : todo
	 */
    public class CastError extends Error
    {
		/**
		 * COMMENT : todo
		 * @param	message	An optional message to override the default error message.
		 */
        public function CastError(message:String)
        {
            super(message);
        }
    }
}
