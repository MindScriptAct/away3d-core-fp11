package away3d.animators
{
	import away3d.animators.data.SkeletonAnimationState;
	import away3d.animators.skeleton.SkeletonTreeNode;
	import away3d.errors.AbstractMethodError;

	import flash.geom.Vector3D;

	/**
	 * COMMENT : todo
	 */
	public class SkeletonAnimatorBase extends AnimatorBase
	{
		private var _updateRootPosition : Boolean = true;
		protected var _target : SkeletonAnimationState;

		/**
		 * Constructor
		 * @param	target	COMMENT : todo
		 */
		public function SkeletonAnimatorBase(target : SkeletonAnimationState)
		{
			_target = target;
			_target.blendTree = createBlendTree();
		}

		protected function createBlendTree() : SkeletonTreeNode
		{
			throw new AbstractMethodError();
		}

		/**
		 * COMMENT : todo 
		 */
		public function get rootDelta() : Vector3D
		{
			return _target.blendTree.rootDelta;
		}

		override protected function updateAnimation(realDT : Number, scaledDT : Number) : void
		{
			_target.invalidateState();

			_target.blendTree.updatePositionData();

			if (_updateRootPosition)
				_target.applyRootDelta();
		}

		/**
		 * COMMENT : todo 
		 */
		public function get updateRootPosition() : Boolean
		{
			return _updateRootPosition;
		}

		public function set updateRootPosition(value : Boolean) : void
		{
			_updateRootPosition = value;
		}
	}
}
