package away3d.filters
{
	import away3d.filters.tasks.Filter3DBlurTask;

	/**
	 * COMMENT : todo
	 */
	public class BlurFilter3D extends Filter3DBase
	{
		private var _blurTask : Filter3DBlurTask;

		/**
		 * Constructor
		 * @param	blurX	COMMENT : todo
		 * @param	blurY	COMMENT : todo
		 */
		public function BlurFilter3D(blurX : uint = 3, blurY : uint = 3)
		{
			super();
			_blurTask = new Filter3DBlurTask(blurX, blurY);
			addTask(_blurTask);
		}

		/**
		 * COMMENT : todo 
		 */
		public function get blurX() : uint
		{
			return _blurTask.blurX;
		}

		public function set blurX(value : uint) : void
		{
			_blurTask.blurX = value;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get blurY() : uint
		{
			return _blurTask.blurY;
		}

		public function set blurY(value : uint) : void
		{
			_blurTask.blurY = value;
		}
	}
}
