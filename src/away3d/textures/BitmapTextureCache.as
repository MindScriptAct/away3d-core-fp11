package away3d.textures
{
	import away3d.textures.BitmapTexture;

	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	/**
	 * DEPRECRATED along with BitmapMaterial. Will be removed along with BitmapMaterial
	 */
	public class BitmapTextureCache
	{
		private static var _instance : BitmapTextureCache;

		private var _textures : Dictionary;
		private var _usages : Dictionary;

		/**
		 * COMMENT : todo
		 * @param	singletonEnforcer	COMMENT : todo
		 */
		public function BitmapTextureCache(singletonEnforcer : SingletonEnforcer)
		{
			if (!singletonEnforcer) throw new Error("Cannot instantiate a singleton class. Use static getInstance instead.");

			_textures = new Dictionary();
			_usages = new Dictionary();
		}

		/**
		 * COMMENT : todo
		 * @return	COMMENT : todo
		 */
		public static function getInstance() : BitmapTextureCache
		{
			return _instance ||= new BitmapTextureCache(new SingletonEnforcer());
		}

		/**
		 * COMMENT : todo
		 * @param	bitmapData	COMMENT : todo
		 * @return	COMMENT : todo
		 */
		public function getTexture(bitmapData : BitmapData) : BitmapTexture
		{
			var texture : BitmapTexture;
			if (!_textures[bitmapData]) {
				texture = new BitmapTexture(bitmapData);
				_textures[bitmapData] = texture;
				_usages[texture] = 0;
			}
			_usages[texture]++;
			return _textures[bitmapData];
		}

		/**
		 * COMMENT : todo
		 * @param	texture	COMMENT : todo
		 */
		public function freeTexture(texture : BitmapTexture) : void
		{
			_usages[texture]--;
			if (_usages[texture] == 0) {
				_textures[BitmapTexture(texture).bitmapData] = null;
				texture.dispose();
			}
		}
	}
}

class SingletonEnforcer {}