package away3d.events
{
	import flash.events.Event;

	public class ShadingMethodEvent extends  Event
	{
		/** COMMENT : todo */
		public static const SHADER_INVALIDATED : String = "ShaderInvalidated";

		/**
		 * Constructor
		 * @param	type		The event type.
		 * @param	bubbles		Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param	cancelable	Determines whether the Event object can be canceled.
		 */
		public function ShadingMethodEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
