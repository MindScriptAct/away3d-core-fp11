package away3d.events {
	import away3d.containers.ObjectContainer3D;

	import flash.events.Event;

	/**
	 * COMMENT : todo
	 * @author Paul Tondeur
	 */
	public class Scene3DEvent extends Event {
		/** COMMENT : todo */
		public static const ADDED_TO_SCENE : String = "addedToScene";
		/** COMMENT : todo */
		public static const REMOVED_FROM_SCENE : String = "removedFromScene";
		/** COMMENT : todo */
		public var objectContainer3D : ObjectContainer3D;
		
		/**
		 * COMMENT : todo 
		 */
		override public function get target() : Object {
			return objectContainer3D;
		}
		
		/**
		 * Constructor
		 * @param	type				The event type.
		 * @param	objectContainer		COMMENT : todo
		 */
		public function Scene3DEvent(type : String, objectContainer : ObjectContainer3D) {
			objectContainer3D = objectContainer;
			super(type);
		}
		
		/**
		 * Duplicates an instance
		 * @return	A new Event object that is identical to the original.
		 */
		public override function clone() : Event
		{
			return new Scene3DEvent(type, objectContainer3D);
		}
	}
}