package away3d.filters
{
	import away3d.filters.tasks.Filter3DHSLTask;
	
	/**
	 * COMMENT : todo
	 */
	public class HSLFilter3D extends Filter3DBase
	{
		private var _hslTask:Filter3DHSLTask;
		
		/**
		 * Constructor
		 * @param	saturation	COMMENT : todo
		 * @param	r			COMMENT : todo
		 * @param	g			COMMENT : todo
		 * @param	b			COMMENT : todo
		 */
		public function HSLFilter3D(saturation:Number = 1,r:Number = 1,g:Number = 1,b:Number = 1)
		{
			super();
			
			_hslTask = new Filter3DHSLTask();
			this.saturation = saturation;
			this.r = r;
			this.g = g;
			this.b = b;
			addTask(_hslTask);
		}
		
		/**
		 * COMMENT : todo 
		 */
		public function get saturation():Number
		{
			return _hslTask.saturation;
		}
		
		public function set saturation(value:Number):void
		{
			if (_hslTask.saturation == value) return;
			_hslTask.saturation = value;
		}
		
		/**
		 * COMMENT : todo 
		 */
		public function get r():Number
		{
			return _hslTask.r;
		}
		
		public function set r(value:Number):void
		{
			if (_hslTask.r == value) return;
			_hslTask.r = value;
		}
		
		/**
		 * COMMENT : todo 
		 */
		public function get b():Number
		{
			return _hslTask.b;
		}
		
		public function set b(value:Number):void
		{
			if (_hslTask.b == value) return;
			_hslTask.b = value;
		}
		
		/**
		 * COMMENT : todo 
		 */
		public function get g():Number
		{
			return _hslTask.g;
		}
		
		public function set g(value:Number):void
		{
			if (_hslTask.g == value) return;
			_hslTask.g = value;
		}
	}
}