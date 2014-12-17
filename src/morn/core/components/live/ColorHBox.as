package morn.core.components.live
{
	import flash.utils.Dictionary;
	
	import morn.core.components.HBox;
	
	/**
	 * @author 偷心枫贼
	 * @E-mail: 527025965@qq.com
	 * 创建时间：2013-12-23 上午11:13:00
	 * 
	 */
	public class ColorHBox extends HBox implements IColorBox
	{
		public function ColorHBox()
		{
			super();
		}
		private const _colors:Dictionary=new Dictionary(true)
		public function get colors():Dictionary
		{
			return _colors;
		}
	}
}