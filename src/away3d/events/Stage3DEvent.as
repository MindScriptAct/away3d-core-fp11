package away3d.events
{
	import flash.events.Event;

	/**
	 * COMMENT : todo
	 */
	public class Stage3DEvent extends Event
	{
		/** COMMENT : todo */
		public static const CONTEXT3D_CREATED : String = "Context3DCreated";
		/** COMMENT : todo */
		public static const CONTEXT3D_DISPOSED : String = "Context3DDisposed";
		/** COMMENT : todo */
		public static const CONTEXT3D_RECREATED : String = "Context3DRecreated";

		/**
		 * Constructor
		 * @param	type		The event type.
		 * @param	bubbles		Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param	cancelable	Determines whether the Event object can be canceled.
		 */
		public function Stage3DEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
