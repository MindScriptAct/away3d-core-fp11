package away3d.filters
{
	import away3d.filters.tasks.Filter3DRadialBlurTask;

	/**
	 * COMMENT : todo
	 */
	public class RadialBlurFilter3D extends Filter3DBase
	{
		private var _blurTask : Filter3DRadialBlurTask;

		/**
		 * Constructor
		 * @param	intensity	COMMENT : todo
		 * @param	glowGamma	COMMENT : todo
		 * @param	blurStart	COMMENT : todo
		 * @param	blurWidth	COMMENT : todo
		 * @param	cx			COMMENT : todo
		 * @param	cy			COMMENT : todo
		 */
		public function RadialBlurFilter3D(intensity:Number = 8.0, glowGamma:Number = 1.6, blurStart:Number = 1.0, blurWidth:Number = -0.3, cx:Number = 0.5, cy:Number = 0.5)
		{
			super();
			_blurTask = new Filter3DRadialBlurTask(intensity, glowGamma, blurStart, blurWidth, cx, cy);
			addTask(_blurTask);
		}

		/**
		 * COMMENT : todo 
		 */
		public function get intensity() : Number
		{
			return _blurTask.intensity;
		}

		public function set intensity(intensity : Number) : void
		{
			_blurTask.intensity = intensity;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get glowGamma() : Number
		{
			return _blurTask.glowGamma;
		}

		public function set glowGamma(glowGamma : Number) : void
		{
			_blurTask.glowGamma = glowGamma;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get blurStart() : Number
		{
			return _blurTask.blurStart;
		}

		public function set blurStart(blurStart : Number) : void
		{
			_blurTask.blurStart = blurStart;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get blurWidth() : Number
		{
			return _blurTask.blurWidth;
		}

		public function set blurWidth(blurWidth : Number) : void
		{
			_blurTask.blurWidth = blurWidth;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get cx() : Number
		{
			return _blurTask.cx;
		}

		public function set cx(cx : Number) : void
		{
			_blurTask.cx = cx;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get cy() : Number
		{
			return _blurTask.cy;
		}

		public function set cy(cy : Number) : void
		{
			_blurTask.cy = cy;
		}
	}
}
