package instances
{
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.printing.PrintJob;
    import flash.printing.PrintJobOrientation;
    
    import morn.core.components.Image;
    
    /**
     * 打印照片管理类
     * @author Administrator
     * 
     */	
    public class Instance_printImageManager extends EventDispatcher
    {
        
        private static var instance:Instance_printImageManager;
        
        private var _priImg:Image	
        
        /**
         * 存储打印机 
         */			
        public var prints:Vector.<Print>=new Vector.<Print>();
        
        
        /**
         *单例模式
         *
         **/
        public static function getInstance():Instance_printImageManager{
            if(!instance) instance=new Instance_printImageManager();
            return instance;
        }
        
        
        
        public function Instance_printImageManager()
        {
            
            try
            {
                var print:Print
                for (var i:int=0;i<PrintJob.printers.length;i++){
                 //   trace(PrintJob.printers[i]);
                    var pName:String=PrintJob.printers[i];
                    if(pName!="Microsoft XPS Document Writer"&&pName!="Fax"&&pName!="Adobe PDF"){
                        print=new Print();
                        print.printer=pName
                        
                        print.jobName="照片"
                        print.orientation=PrintJobOrientation.LANDSCAPE
                        prints.push(print);
                    }
                }
                _priImg=new Image()
                _priImg.smoothing=true
                
            } 
            catch(error:Error) 
            {
                
            }
            
            //	trace("单例: "+this)
        }
        
        public var nowPrintName:String="";
        
        
        /**
         * 全部打印机打印 
         * @param bitm
         * @param jobName
         * 
         */        
        public function printBitm2allPrint(bitm:BitmapData,jobName:String="照片"):void{
            trace("打印图片大小: "+bitm.width,bitm.height)	
            for each(var print:Print in prints){
                print.jobName=jobName
                print.printBitm(bitm,jobName);
            }
        }
        /**
         * 打印图片 
         * @param bitm
         * @param jobName
         */		
        public function printBitm(bitm:BitmapData,jobName:String="照片",$print:Print=null):Boolean{
            	
            var print:Print=null
            if($print){
                print=$print                    
            }else{
                if(PrintJob.isSupported){
                    print=getPrint();                 
                }
            }
        //    print.jobName=jobName
            if(print){
                print.printBitm(bitm,jobName);
            }	
            return false
        }
        
        /**
         *  
         * 
         */		
        private function reducePrintNum():void{
            for (var i:int=0;i<prints.length;i++){					
                if(prints[i].hasChoose){
                    if(prints[i].printNum>0)prints[i].printNum-=1
                }				
            }
        }
        
        private function getPrint():Print{			
            var print:Print=null;		
            for (var i:int=0;i<prints.length;i++){					
                if(prints[i].hasChoose){
                    
                    if(!print){
                        print=prints[i]
                    }
                    trace(print.printer,print.printNum,prints[i].printNum);
                    if(print.printNum>prints[i].printNum){
                        print=prints[i]
                    }			
                }				
            }
            return print;
        }
    }
}
import flash.display.BitmapData;
import flash.printing.PrintJob;
import flash.printing.PrintJobOrientation;
import flash.printing.PrintUIOptions;

import morn.core.components.Image;



class Print extends PrintJob{
    public static const S:Number=2.83333;
    /**
     * 是否选择用于打印 
     */		
    public var hasChoose:Boolean=false;
    public var printNum:uint=0;
    //public var paperSize:String="";
    
    
    public static var nowPrintName:String="";
    
    override public function start2(uiOptions:PrintUIOptions=null, showPrintDialog:Boolean=true):Boolean
    {
        // TODO Auto Generated method stub
        printNum+=1;//增加1;
        return super.start2(uiOptions, showPrintDialog);
    }
    
    
    
    public function printBitm(bitm:BitmapData,jobName:String="照片"):Boolean{
        //selectPaperSize(paperSize)
        jobName=jobName;//
        nowPrintName=printer;
        
        var img:Image=new Image();
        
        img.width=bitm.width
        img.height=bitm.height
        
        img.bitmapData=bitm;
        
        
        trace(bitm.width,bitm.height);
        trace("printSize: "+pageWidth,pageHeight)
        trace(paperArea)
        //trace(printableArea)
        
        
        //	img.scale=Math.min(paperWidth/bitm.width,paperHeight/bitm.height)
        
        if(bitm.width>bitm.height){			
            orientation=PrintJobOrientation.LANDSCAPE;//水平
            img.scale=Math.min(paperWidth/bitm.width,paperHeight/bitm.height)*.9			
        }else {
            orientation=PrintJobOrientation.PORTRAIT
            img.scale=Math.max(paperWidth/bitm.width,paperHeight/bitm.height)*.9			
        }
        
        
        //不弹出窗口打印
        if(start2(null,false)){
            try
            {	
                //	var option:PrintJobOptions=new PrintJobOptions();
                //	option.printAsBitmap=true
                addPage(img)
                send()
                return true
            } 
            catch(error:Error) 
            {
                
            }
            
        }
        
        
        
        return false;
    }
    
    
    
}