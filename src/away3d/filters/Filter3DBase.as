package away3d.filters
{
	import away3d.cameras.Camera3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.filters.tasks.Filter3DTaskBase;

	import flash.display3D.textures.Texture;

	/**
	 * COMMENT : todo
	 */
	public class Filter3DBase
	{
		private var _tasks : Vector.<Filter3DTaskBase>;
		private var _requireDepthRender : Boolean;
		private var _textureWidth : int;
		private var _textureHeight : int;

		/**
		 * Constructor
		 */
		public function Filter3DBase()
		{
			_tasks = new Vector.<Filter3DTaskBase>();
		}

		/**
		 * COMMENT : todo 
		 */
		public function get requireDepthRender() : Boolean
		{
			return _requireDepthRender;
		}

		protected function addTask(filter : Filter3DTaskBase) : void
		{
			_tasks.push(filter);
			_requireDepthRender ||= filter.requireDepthRender;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get tasks() : Vector.<Filter3DTaskBase>
		{
			return _tasks;
		}

		/**
		 * COMMENT : todo
		 * @param	stage3DProxy	COMMENT : todo
		 * @return					COMMENT : todo
		 */
		public function getMainInputTexture(stage3DProxy : Stage3DProxy) : Texture
		{
			return _tasks[0].getMainInputTexture(stage3DProxy);
		}

		/**
		 * COMMENT : todo 
		 */
		public function get textureWidth() : int
		{
			return _textureWidth;
		}

		public function set textureWidth(value : int) : void
		{
			_textureWidth = value;

			for (var i : int = 0; i < _tasks.length; ++i)
				_tasks[i].textureWidth = value;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get textureHeight() : int
		{
			return _textureHeight;
		}

		public function set textureHeight(value : int) : void
		{
			_textureHeight = value;
			for (var i : int = 0; i < _tasks.length; ++i)
				_tasks[i].textureHeight = value;
		}

		// link up the filters correctly with the next filter
		/**
		 * COMMENT : todo
		 * @param	target			COMMENT : todo
		 * @param	stage3DProxy	COMMENT : todo
		 */
		public function setRenderTargets(target : Texture, stage3DProxy : Stage3DProxy) : void
		{
			// TODO: not used
			stage3DProxy = stage3DProxy; 
			_tasks[_tasks.length-1].target = target;
		}

		/**
		 * COMMENT : todo 
		 */
		public function dispose() : void
		{
			for (var i : int = 0; i < _tasks.length; ++i)
				_tasks[i].dispose();
		}

		/**
		 * COMMENT : todo
		 * @param	stage	COMMENT : todo
		 * @param	camera	COMMENT : todo
		 */
		public function update(stage : Stage3DProxy, camera : Camera3D) : void
		{

		}
	}
}
