package com.book.yao.components.flipbook 
{
	
	
	
	
	
	
	
	
	/**
	 * ...
	 * @author yaoguozhen
	 */
	public class FlipPage extends Flip_page_Action
	{
		
		
		/**
		 * 构造函数
		 * @param	pageWidth 页面宽度
		 * @param	pageHeight 页面高度
		 * @param	hotWidth 热区宽度
		 */
		public function FlipPage(pageWidth:Number=1920,pageHeight:Number=1080,hotWidth:Number=50) :void
		{
			super(pageWidth, pageHeight, hotWidth);			
		}
		
		
		public function addPage(link:String):void{
			_page.addPage(link)
		}
		
	}

}