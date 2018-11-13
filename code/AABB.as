package code {
	import flash.geom.Point;

	public class AABB {

		/** Half of the width of this box. Used to calc edges. */
		private var halfWidth: Number;
		/** Half of the height of this box. Used to calc edges. */
		private var halfHeight: Number;
		/** The poisition on the x axis of the left edge of this box. */
		public var xmin: Number;
		/** The poisition on the x axis of the right edge of this box. */
		public var xmax: Number;
		/** The poisition on the y axis of the bottom edge of this box. */
		public var ymin: Number;
		/** The poisition on the y axis of the top edge of this box. */
		public var ymax: Number;

		/** 
		 * The set up code for this AABB object.
		 * @param halfWidth Half the width of this AABB
		 * @param halfHeight Half the height of this AABB
		 */
		public function AABB(halfWidth: Number, halfHeight: Number) {
			// constructor code
			setSize(halfWidth, halfHeight);
		}

		/**
		 * This sets the size of the AABB based on the actual objects dimentions.
		 * @param halfWidth Half the width of this AABB
		 * @param halfHeight Half the height of this AABB
		 */
		public function setSize(halfWidth: Number, halfHeight: Number): void {
			this.halfWidth = halfWidth;
			this.halfHeight = halfHeight;
			// recalculate edges
			calcEdges((xmin + xmax) / 2, (ymin + ymax) / 2);
		}
		/**
		 * Calculate the position of the 4 edges from the center (x,y) position.
		 * @param x The horizontal position of the boxes center/origin.
		 * @param y The vertical position of the boxes center/origin.
		 */
		public function calcEdges(x: Number, y: Number): void {
			xmin = x - halfWidth;
			xmax = x + halfWidth;
			ymin = y - halfHeight;
			ymax = y + halfHeight;
		}
		/**
		 * This function checks to see if this AABB
		 * is overlapping another AABB
		 * @param other The other AABB to check this AABB against.
		 * @return Whether or not they are overlapping. If true, they are overlapping.
		 */
		public function checkOverlap(other: AABB): Boolean {

			if (this.xmax < other.xmin) return false; // gap to the right of the player
			if (this.xmin > other.xmax) return false; // gap to the left
			if (this.ymin > other.ymax) return false; // gap below
			if (this.ymax < other.ymin) return false; // gap above

			return true;
		}

		/**
		 * This function calculates how far to move this AABB so it no longer
		 * overlaps another AABB.
		 * @param other The other AABB
		 * @return The "fix" vector or how far to move this AABB.
		 */
		public function findOverlapFix(other: AABB): Point {

			var moveL: Number = other.xmin - this.xmax;
			var moveR: Number = other.xmax - this.xmin;
			var moveU: Number = other.ymin - this.ymax;
			var moveD: Number = other.ymax - this.ymin;

			var fix: Point = new Point();

			fix.x = (Math.abs(moveL) < Math.abs(moveR)) ? moveL : moveR;
			fix.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD;

			if (Math.abs(fix.x) < Math.abs(fix.y)) fix.y = 0;
			else fix.x = 0;

			return fix;

		}

	}

}