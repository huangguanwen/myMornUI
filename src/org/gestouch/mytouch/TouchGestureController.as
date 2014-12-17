package org.gestouch.mytouch
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.TouchEvent;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import morn.core.components.Component;
    import morn.core.handlers.Handler;
    
    import org.gestouch.events.GestureEvent;
    import org.gestouch.gestures.TransformGesture;
    
    
    /**
    * 
    * 手势控制器
     *@author 偷心枫贼
     *        下午3:04:41
     *
     */
    public class TouchGestureController
    {
        protected var display:Component
        private static const MIN_SCALE:Number=.5
        private static const MAX_SCALE:Number=5
        /**
         * 速度系数 
         */		
        private static const SPEED:Number = .99;
        
        
        //记录运动的坐标
        private var dragStartX:int = 0;
        private var dragStartY:int=0;
        
        private var dragStartMouseX:int = 0;
        private var dragStartMouseY:int = 0;
        
        private var lastX:Number = 0;
        private var lastY:Number = 0;
        
        private var speedX:Number=0;
        private var speedY:Number=0;
        
        
        private var isDraging:Boolean = false;
        
        
        private var _stopTouchGestureHandler:Handler;
        public function get stopTouchGestureHandler():Handler { return _stopTouchGestureHandler; }
        public function set stopTouchGestureHandler(value:Handler):void
        {
            if (_stopTouchGestureHandler == value)
                return;
            _stopTouchGestureHandler = value;
        }
        
        private var _isX:Boolean
        private var _isY:Boolean
        private var _isOpenRotate:Boolean
        private var _isOpenScale:Boolean
        /////////////////////
        
        public function TouchGestureController($display:Component,isX:Boolean=true,isY:Boolean=true,isOpenRotate:Boolean=true,isOpenScale:Boolean=true)
        {
            display=$display
            _isX=isX
            _isY=isY
            _isOpenRotate=isOpenRotate
            _isOpenScale=isOpenScale
                
            listeners()
            display.filters=[new GlowFilter(0xfffffff,.2,50,50)]          
        }
        
        
       
        private function listeners():void{
            var transformGesture:TransformGesture=new TransformGesture( display as DisplayObject)
            transformGesture.addEventListener(GestureEvent.GESTURE_BEGAN, onGesture);
            transformGesture.addEventListener(GestureEvent.GESTURE_CHANGED, onGesture);
            
            
            display.addEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin)
            display.addEventListener(TouchEvent.TOUCH_TAP,onTouchTap)       
        }
        
        
        private function onTouchTap(e:TouchEvent):void{
            isDraging=false//惯性引擎开始运行  
        }
        /**
         * 开始触摸 
         * @param e
         * 
         */        
        private function onTouchBegin(e:TouchEvent):void{
          
            //if(display is ProductView_4scree)
            display.parent.setChildIndex(display,display.parent.numChildren-1)
              //  trace(e.target,e.currentTarget,e.target.name,e.currentTarget.name)
             if(e.target .name=="drop"){
                 var bound:Rectangle=new Rectangle(0,display.y,App.stage.stageWidth-display.width*display.scale)
                 display.startTouchDrag(e.touchPointID,false,bound)
                 start_inertia(e.localX,e.localY)//启动惯性引擎
             }
        }
        
       
        
        private function onGesture(e:GestureEvent):void{
            const gesture:TransformGesture = e.target as TransformGesture;
            //trace(gesture.state.toString())
            var matrix:Matrix = display.transform.matrix;
            
            /*matrix.translate(gesture.offsetX, gesture.offsetY);
            display.transform.matrix = matrix;*/
            
            if (gesture.scale != 1 || gesture.rotation != 0)
            {
                // Scale and rotation.
                var transformPoint:Point = matrix.transformPoint(display.globalToLocal(gesture.location));
                //   trace(gesture.location)
                
                matrix.translate(-transformPoint.x, -transformPoint.y);
                if(_isOpenRotate){
                    matrix.rotate(gesture.rotation);
                }
               
                
                if(_isOpenScale){
                    if(display.scale>MIN_SCALE-gesture.scale&&display.scale<MAX_SCALE-gesture.scale){
                        matrix.scale(gesture.scale, gesture.scale);
                    }
                     
                }
               
                matrix.translate(transformPoint.x, transformPoint.y);
                
                display.transform.matrix = matrix;
            }
        }
        
        
        
        /**
         * 惯性引擎开始 
         * 
         */		
       public function start_inertia($x:Number,
                                         $y:Number):void{
           
           if(_isX){
               dragStartX =display.x  
               dragStartMouseX = $x	
           }
           
           if(_isY){
               dragStartY=display.y
               dragStartMouseY =$y
           }
           
           
           
           
            isDraging = true;
            
            display.removeEventListener(Event.ENTER_FRAME,loop);//注册惯性帧频触发器
            display.addEventListener(Event.ENTER_FRAME,loop);//注册惯性帧频触发器
        }
        
        protected function loop(e:Event):void
        {
            if(isDraging){
                if(_isX){
                    speedX=display.x-lastX	
                    lastX=display.x
                }
                if(_isY){
                    speedY =display.y-lastY                   
                    lastY=display.y
                }
               
               
            }else{
                if(_isX){
                    var afterSpeedX:Number = Math.abs(speedX) -SPEED
                    if (afterSpeedX < 0) afterSpeedX = 0;
                    speedX = speedX >= 0?afterSpeedX: -afterSpeedX;
                    display.x+=speedX
                }
               
                if(_isY){
                    var afterSpeedY:Number = Math.abs(speedY) -SPEED
                    if (afterSpeedY < 0) afterSpeedY = 0;
                    speedY = speedY >= 0?afterSpeedY: -afterSpeedY;
                    display.y+=speedY
                }
                
                
                
                if (afterSpeedX == 0 &&afterSpeedY==0) {
                    display.removeEventListener(Event.ENTER_FRAME,loop);
                    if(stopTouchGestureHandler!=null){
                        stopTouchGestureHandler.executeWith([display])
                    }
                  /*  if(display.x>App.stage.stageWidth||
                        display.x<-display.width*display.scale||
                        display.y<-display.height*display.scale||
                        display.y>App.stage.stageHeight){						
                    //   _touchObject.closeTheTouchObject()
                    }*/
                }
            }
        }
    }
}