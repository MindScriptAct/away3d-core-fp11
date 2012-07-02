package away3d.animators.data
{
	/**
	 * COMMENT : todo
	 */
	public class UVAnimationFrame
	{
		public var offsetU : Number;
		public var offsetV : Number;
		public var scaleU : Number;
		public var scaleV : Number;
		public var rotation : Number;
		
		/**
		 * Constructor
		 * @param	offsetU		COMMENT : todo
		 * @param	offsetV		COMMENT : todo
		 * @param	scaleU		COMMENT : todo
		 * @param	scaleV		COMMENT : todo
		 * @param	rotation	COMMENT : todo
		 */
		public function UVAnimationFrame(offsetU : Number = 0, offsetV : Number = 0, scaleU : Number = 1, scaleV : Number = 1, rotation : Number = 0)
		{
			this.offsetU = offsetU;
			this.offsetV = offsetV;
			this.scaleU = scaleU;
			this.scaleV = scaleV;
			this.rotation = rotation;
		}
	}
}