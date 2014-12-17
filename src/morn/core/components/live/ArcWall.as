package morn.core.components.live
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import morn.core.components.Component;
	
	public class ArcWall extends Component
	{
		private var rows:Array;
		private var V:Vector.<Vector3D>;
		private var cubeMat3D:Matrix3D;
		private var num:int;
		
		public static const PicWidth:int = 180 ;
		public static const PicHeight:int = 135;
		public static const Radius:int = 125;
		
		public static const ROW:int = 2; //两行
		public static const COLUMN:int = 18;//每行18个图片
		public static const totalNum:int = ROW * COLUMN ;
		public static const Radian:Number = 360/COLUMN*Math.PI / 180;
		public function ArcWall()
		{
			super();
			
			V = new Vector.<Vector3D>();
			V[0] = new Vector3D(0, 0, 0);
			V[1] = new Vector3D(0, 0, 0);
			V[2] = new Vector3D(1, 1, 1);
			
			rows = [];
			
			this.z = 0;
			this.rotationY = 0;
			cubeMat3D = transform.matrix3D;
			
		}
		
		//载入缩览图后将其压入模型中
		public function pushThumb(source:DisplayObject):void
		{
			var i:int = num / COLUMN;
			var j:Number = Radian *(num % COLUMN -COLUMN / 2 + .5);
			var p:Row = new Row();
			//if (num < 10) trace(j, totalNum);
			
			p.con.rotationY =  j*180/Math.PI ;
			p.con.z =  -5.0 * Radius *( Math.cos(j));
			p.con.x =  -5.0 * Radius * Math.sin(j) ;
			p.con.y = (i-1.5) * (PicHeight + 20);
			p.con.name = String(num);
			
			source.x = -PicWidth / 2;
			source.y = -PicHeight / 2;
			p.con.addChild(source);
			rows[num] = p;
			num++;
		}
		
		public function getThumb(Index:int):Sprite
		{
			return rows[Index].con;
		}
		
		public function get _rotationY():Number
		{
			return V[1].y ;
		}
		
		public function set _rotationY(value:Number):void
		{
			V[1].y = value ;
		}
		
		public function reSort():void
		{
			cubeMat3D.recompose(V);
			
			for (var i:int = 0; i < totalNum; i++)
			{
				rows[i].z = rows[i].con.transform.getRelativeMatrix3D(root).position.z;
				
			}
			
			rows.sortOn("z", Array.NUMERIC | Array.DESCENDING);
			
			for (i = 0; i < totalNum; i++)
			{
				this.addChild(rows[i].con);
			}
			
		}
	}
}

import flash.display.Sprite;
class Row
{
	public var z:Number;
	public var con:Sprite;
	
	function Row()
	{
		z = 0 ;
		con = new Sprite();
		con.buttonMode = true;
	}
}