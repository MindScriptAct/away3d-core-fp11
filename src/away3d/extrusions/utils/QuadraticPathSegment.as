package away3d.extrusions.utils
{
	import flash.geom.Vector3D;

	/**
    * Creates a curved line segment definition required for the Path class.
    */ 
	public class QuadraticPathSegment implements IPathSegment
	{
		/**
		* Defines the first vector3d of the PathSegment
		*/
		public var pStart:Vector3D;
		
		/**
		* Defines the control vector3d of the PathSegment
		*/
		public var pControl:Vector3D;
		
		/**
		* Defines the end vector3d of the PathSegment
		*/
		public var pEnd:Vector3D;
		 
		/**
		 * Constructor
		 * @param	pStart		first vector3d point
		 * @param	pControl	control vector3d point
		 * @param	pEnd		end vector3d point
		 */
		public function QuadraticPathSegment(pStart:Vector3D, pControl:Vector3D, pEnd:Vector3D)
		{
			this.pStart = pStart;
			this.pControl = pControl;
			this.pEnd = pEnd;
		}
		
		/**
		 * COMMENT : todo 
		 */
		public function toString():String
		{
			return pStart + ", " + pControl + ", " + pEnd;
		}
		
		/**
		* nulls the 3 vectors
		*/
		public function dispose():void
		{
			pStart = pControl = pEnd = null;
		}
	}
}