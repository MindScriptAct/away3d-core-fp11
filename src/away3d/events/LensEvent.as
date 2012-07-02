package away3d.events
{
	import away3d.cameras.lenses.LensBase;

	import flash.events.Event;

	/**
	 * COMMENT : todo
	 */
	public class LensEvent extends Event
	{
		public static const MATRIX_CHANGED : String = "matrixChanged";

		private var _lens : LensBase;

		/**
		 * Constructor
		 * @param	type		The event type.
		 * @param	lens		COMMENT : todo
		 * @param	bubbles		Determines whether the Event object participates in the bubbling stage of the event flow.
		 * @param	cancelable	Determines whether the Event object can be canceled.
		 */
		public function LensEvent(type : String, lens : LensBase, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type,  bubbles, cancelable);
			_lens = lens;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get lens() : LensBase
		{
			return _lens;
		}

		/**
		 * Duplicates an instance
		 * @return		A new object that is identical to the original.
		 */
		override public function clone() : Event
		{
			return new LensEvent(type, _lens, bubbles,  cancelable);
		}
	}
}
