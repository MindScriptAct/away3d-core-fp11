package away3d.events
{
	import away3d.library.assets.IAsset;

	import flash.events.Event;

	/**
	 * COMMENT : todo
	 */
	public class AssetEvent extends Event
	{
		/** COMMENT : todo */
		public static const ASSET_COMPLETE : String = 'assetComplete';
		/** COMMENT : todo */
		public static const ENTITY_COMPLETE : String = 'entityComplete';
		/** COMMENT : todo */
		public static const MESH_COMPLETE : String = 'meshComplete';
		/** COMMENT : todo */
		public static const GEOMETRY_COMPLETE : String = 'geometryComplete';
		/** COMMENT : todo */
		public static const SKELETON_COMPLETE : String = 'skeletonComplete';
		/** COMMENT : todo */
		public static const SKELETON_POSE_COMPLETE : String = 'skeletonPoseComplete';
		/** COMMENT : todo */
		public static const CONTAINER_COMPLETE : String = 'containerComplete';
		/** COMMENT : todo */
		public static const ANIMATION_COMPLETE : String = 'animationComplete';
		/** COMMENT : todo */
		public static const BITMAP_COMPLETE : String = 'bitmapComplete';
		/** COMMENT : todo */
		public static const MATERIAL_COMPLETE : String = 'materialComplete';
		/** COMMENT : todo */
		public static const ANIMATOR_COMPLETE : String = 'animatorComplete';
		
		/** COMMENT : todo */
		public static const ASSET_RENAME : String = 'assetRename';
		/** COMMENT : todo */
		public static const ASSET_CONFLICT_RESOLVED : String = 'assetConflictResolved';
		
		private var _asset : IAsset;
		private var _prevName : String;
		
		public function AssetEvent(type : String, asset : IAsset = null, prevName : String = null)
		{
			super(type);
			
			_asset = asset;
			_prevName = prevName || (_asset? _asset.name : null);
		}
		
		
		public function get asset() : IAsset
		{
			return _asset;
		}
		
		
		public function get assetPrevName() : String
		{
			return _prevName;
		}
		
		
		public override function clone() : Event
		{
			return new AssetEvent(type, asset, assetPrevName);
		}
	}
}