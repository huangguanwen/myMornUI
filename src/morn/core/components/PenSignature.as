package morn.core.components
{
	import flash.utils.Dictionary;

	/**
	 * 签字版 
	 * @author goven225
	 * 
	 */	
	public class PenSignature extends Component
	{
        
		private var _tempPen:Dictionary=null;
		public function PenSignature()
		{
			super();
		}
		
		/**预初始化，在此可以修改属性默认值*/
		override protected function preinitialize():void {
			super.preinitialize();
			
			
			
		}
		
		/**在此创建组件子对象*/
		override protected function createChildren():void {
			super.createChildren();
		}
		
		/**初始化，在此子对象已被创建，可以对子对象进行修改*/
		override protected function initialize():void {
			super.initialize();
		}
		
	}
}