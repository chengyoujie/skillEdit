package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.app.view.common.TipMsg;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	public class Avatar extends Sprite
	{
		protected var _res:AvaterRes;
//		private var bmp:Bitmap;
		protected var _path:String;
		protected var _act:String;
		protected var _dir:int=-1;
		protected var _isDirRes:Boolean = false;
		/**有资源的  【动作】= [方向1, 方向2, ... ]**/
		protected var _canUseRes:Object = {};
		/**可以显示的（会把有资源的进行镜像以及加上target, owner这两个特殊方向）  【动作】= [方向1, 方向2, ... ]**/
		protected var _showUseRes:Object = {};
//		private var _w:Number;
//		private var _h:Number;
//		private var _sx:Number=1;
//		private var _sy:Number=1;
//		private var _frame:int = 0;
		protected var _moviePlay:MoviePlay;
		public var downLayer:Sprite;
		public var bodyLayer:Sprite;
		public var upLayer:Sprite;
		protected var _isRun:Boolean = false;
		
		protected var _loop:int = 0;
		protected var _loopEndFun:Function;
		protected var _isDispose:Boolean = false;
		protected var _data:AvaterData;
		protected var _bodyHeight:Number = -1;//角色的身高   -1表示没有获取
		
		public function Avatar($data:AvaterData)//$path:String, isDirRes:Boolean = false, dir:int=-1, act:String=null)
		{
			super();
//			this.addEventListener(Event.ADDED_TO_STAGE, handleAddStage);
//			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemoveStage);
			_data = $data;
			_isDirRes = _data.isDirRes;
			_dir = _data.dir;
			_act = _data.act;
			_bodyHeight = _data.getBodyHeight();
			if(!_data.id)
				_data.id = ComUtill.getOnlyId();
			downLayer = new Sprite();
			addChild(downLayer);
			
			bodyLayer = new Sprite();
			addChild(bodyLayer);
			
			_moviePlay = new MoviePlay(bodyLayer);
			upLayer = new Sprite();
			addChild(upLayer);
			
			path = _data.path;//$path;
			start();
		} 
		
		
		protected function drawBg(color:int):void
		{
			var hw:int = 5;
			var w:int = 60;
			var h:int = 45;
			this.graphics.clear();
			this.graphics.beginFill(color, 0.3);
//			this.graphics.drawCircle(0, 0, hw);
			this.graphics.drawEllipse(-w/2, -h/2, w, h);
			this.graphics.lineStyle(1, 0xdfff06);
			this.graphics.moveTo(-hw, 0);
			this.graphics.lineTo(hw, 0);
			this.graphics.moveTo(0, -hw);
			this.graphics.lineTo(0, hw);
			this.graphics.endFill();
		}
		
		public function get onlyId():int
		{
			return _data.id;
		}
		
		public function stop():void
		{
			_isRun = false;
			App.timer.clearTimer( handleRender);
		}
		
		override public function set scaleX(value:Number):void
		{
			bodyLayer.scaleX = value;
		}
		override public function get scaleX():Number
		{
			return bodyLayer.scaleX;
		}
		
		public function start():void
		{
			_isRun = true;
			App.timer.doFrameLoop(1,  handleRender, null, true);
		}
		
		public function doLoop(loop:int, endFun:Function):void
		{
			_loop = loop;
			_loopEndFun = endFun;
			_curFrame = 0;
		}
		
		public function set path(value:String):void
		{
			if(_path == value)return;
			_path = value;
			data.path = _path;
			checkCanUseRes();
			refushRes();
		}
		
		public function get isDirRes():Boolean
		{
			return this._isDirRes;
		}
		
		private function checkCanUseRes():void
		{
			_canUseRes = {};
			if(!_path)return;
			var file:File = new File(_path);
			if(!file.exists || !file.isDirectory)return;
			var arr:Array = file.getDirectoryListing();
			var dir:int=-1;
			var act:String;
			for(var i:int=0; i<arr.length; i++)
			{
				var f:File = arr[i];
				var info:Array = f.name.substring(0, f.name.lastIndexOf(".")).split("_");
				if(info.length>=3)
				{
					if(_dir==-1)
					{
						if(dir != Direction.BOTTOM)
							dir = int(info[2]);
					}
					if(!_act)
					{
						if(act != Action.ACTION_TYPE_STAND)
							act = info[1];
					}
					var infoAct:String = info[1];
					var infoDir:int = int(info[2]);
					if(!_canUseRes[infoAct])
						_canUseRes[infoAct] = [];
					if(_canUseRes[infoAct].indexOf(infoDir) == -1)
						_canUseRes[infoAct].push(infoDir);
				}
			}
			if(dir!=-1)
				_dir = dir;
			if(act)
				_act = act;
		}
		
		/**
		 * 获取某一个动作下面有哪些方向
		 * */
		public function getActHaveDirs(act:String):Array
		{
			if(!_showUseRes[act])
			{
				_showUseRes[act] = [];
				var arr:Array = _canUseRes[act];
				if(arr)
				{
					if(arr.length>1)//多方向的会进行五方向镜像及加上特殊方向
					{
						var hasRight:Boolean = false;
						for(var i:int=0; i<arr.length; i++)
						{
							_showUseRes[act].push(arr[i]);
							if(!hasRight && arr[i] == Direction.RIGHT)
									hasRight = true;
							var newDir:int = Direction.getReverseFiveDir(arr[i]);
							if(newDir != arr[i])
								_showUseRes[act].push(newDir);
						}
						_showUseRes[act].push(Direction.OWNER_DIR);
						_showUseRes[act].push(Direction.TO_TARGET_DIR);
						_showUseRes[act].push(Direction.TO_TARGET_ONE_DIR);
						if(hasRight)
							_showUseRes[act].push(Direction.RIGHT_LEFT);
					}else if(arr.length == 1){
						_showUseRes[act].push(arr[0]);
					}	
				}else{
					_showUseRes[act].push(Direction.TOP);//默认给个向上的
				}
				
			}
			return _showUseRes[act];
		}
		
		public function set isDirRes(value:Boolean):void
		{
//			if(_isDirRes == value)return;
			_isDirRes = value;
			data.isDirRes = _isDirRes;
			refushRes();
		}
		
		public function refushRes():void
		{
			if(!_path)return;
			var path:String = _path;
			if(_isDirRes)
			{
				var d:int = Direction.getHaveResDir(_dir);
				var pscaleX:int = getParentScaleX();
				if(_dir != d)
				{
					this.scaleX = -1*_scalex;// pscaleX>0?-1:1;
				}else{
					this.scaleX = 1*_scalex;//pscaleX>0?1:-1;
				}
				this.scaleY = 1*_scaley;// pscaleX>0?-1:1;
				App.timer.doOnce(500, checkHasDir, null, true);
				path = _path+"/"+_path.substr(_path.lastIndexOf("/"))+"_"+_act+"_"+d;
				path = path.replace(/\/\//gi, "/");
			}else{
				this.scaleX = _scalex;
				this.scaleY = _scaley;
			}
			_res = AvaterRes.get(path);
			_moviePlay.avaterRes = _res;
		}
		
		private var _scalex:Number = 1;
		public function set  scalex(value:Number):void{
			_scalex = value;
			refushRes();
		}
		private var _scaley:Number = 1;
		public function set  scaley(value:Number):void{
			_scaley = value;
			refushRes();
		}
		
		private function checkHasDir():void
		{
			App.timer.clearTimer(checkHasDir);
			if(!_isDirRes)return; 
			var hasDirs:Array = getActHaveDirs(_act);
			if(hasDirs.indexOf(_dir) == -1)
			{
				TipMsg.show("没有对应的方向  "+Direction.getDirName(_dir));
			}
		}
		
		private function getParentScaleX():int
		{
			var sx:int = 1;
			var p:DisplayObject = this.parent;
			while(p)
			{
				if(p is Stage)break;
				if(p.scaleX<0)
					sx *= -1;
				p = p.parent;
			}
			return sx;
		}
		
		public function get trueScaleX():int
		{
//			return scaleX;
			return getParentScaleX()*this.scaleX;
		}
		
		public function set dir(value:int):void
		{
			_dir = value;
			data.dir = dir;
			refushRes();
		}
		public function get dir():int
		{
			return _dir;
		}
		public function set act(value:String):void
		{
			_act = value;
			data.act = value;
			refushRes();
		}
		public function get act():String
		{
			return _act;
		}
		
		public function get data():AvaterData
		{
			return _data;
		}
		
		private var _curFrame:int = 0;
		private var _renderTime:int = 0;
		private function handleRender():void
		{
			if(!_res || !_res.isReady)return;
			if(_moviePlay)
			{
				if(getTimer()<_renderTime)return;
				var isEnd:Boolean = false;
				if(_curFrame>=_res.data.maxFrame)//播放完成
				{
					_curFrame = 0;
					isEnd = true;
				}
				_renderTime = getTimer() + 1000/_res.data.speed;
				_moviePlay.gotoAndStop(_curFrame);
				_curFrame ++;
				if(isEnd)
				{
					if(_loop>0)
					{
						_loop --;
						if(_loop<=0)
						{
							stop();
							if(_loopEndFun!=null)
								_loopEndFun();	
							_loop = 0;
							_loopEndFun = null;
						}
					}
				}
			}
		}
		
		private var _boundRect:Rectangle = new Rectangle();
		public function get boundRect():Rectangle
		{
			_boundRect.x = x + ox;
			_boundRect.y = y + oy;
			_boundRect.width = width;
			_boundRect.height = height;
			return _boundRect;
		}
		
		public function get ox():int
		{
			if(!_res || !_res.isReady)return 0;
//			return _res.ox;
			if(bodyLayer.scaleX>0)
				return _res.ox;
			else
				return -_res.width-_res.ox;
		}
		public function get oy():int
		{
			if(!_res || !_res.isReady)return 0;
			return _res.oy;
		} 
		override public function get width():Number
		{
			if(!_res || !_res.isReady)return super.width;
			return _res.width;
		}
		
		override public function get height():Number
		{
			if(_bodyHeight<0)
			{
				_bodyHeight = _data.getBodyHeight();
				if(_bodyHeight>0)
					return _bodyHeight;
			}
			if(!_res ||!_res.isReady)return super.height;
			return _res.height;
		}
		
		public function get path():String
		{
			return _path;
		}

		public function get avaterRes():AvaterRes
		{
			return _res;
		}
		
		public function get isDispose():Boolean
		{
			return _isDispose;
		}
		
		override public function set x(value:Number):void
		{
			_data.x = value;
			super.x = value;
		}
		override public function set y(value:Number):void
		{
			_data.y = value;
			super.y = value;
		}
		
		public  function dispose():void
		{
			stop();
			_isDispose = true;
			if(this.parent)
				this.parent.removeChild(this);
			_loopEndFun = null;
			_loop = 0;
			_bodyHeight = -1;
			_moviePlay.dispose();
			_moviePlay = null;
			
		}
	}
}