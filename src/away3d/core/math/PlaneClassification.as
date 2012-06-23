package away3d.core.math
{
	// Author: David Lenaerts
	
	/**
	 * COMMENT : todo
	 */
	public class PlaneClassification
	{
		// "back" is synonymous with "in", but used for planes (back of plane is "inside" a solid volume walled by a plane)
		/** COMMENT : todo */
		public static const BACK : int = 0;
		/** COMMENT : todo */
		public static const FRONT : int = 1;

		/** COMMENT : todo */
		public static const IN : int = 0;
		/** COMMENT : todo */
		public static const OUT : int = 1;
		/** COMMENT : todo */
		public static const INTERSECT : int = 2;
	}
}
