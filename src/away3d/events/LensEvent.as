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

		public function LensEvent(type : String, lens : LensBase, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type,  bubbles, cancelable);
			_lens = lens;
		}

		public function get lens() : LensBase
		{
			return _lens;
		}

		override public function clone() : Event
		{
			return new LensEvent(type, _lens, bubbles,  cancelable);
		}
	}
}
