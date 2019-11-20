package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.view.app.AppEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class MoviePlay
	{
		private var _movies:Vector.<Movie> = new Vector.<Movie>();
		private var _frame:int = 0;
		private var _res:AvaterRes;
		private var _contain:DisplayObjectContainer;
		private var _centerPos:Point = new Point();
		
		
		public function MoviePlay(contain:DisplayObjectContainer, res:AvaterRes=null)
		{
			_contain = contain;
			avaterRes = res;
		}
		
		private function handleResComplete(e:SimpleEvent):void
		{
			if(_res != e.data)return;
			if(_res.isReady)
			{
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
				initMovies();
			}
		}
		
		private function initMovies():void
		{
			if(!_res || !_res.isReady)return;
			var frames:Array = _res.data.frames;
			if(frames)
			{
				for(var i:int=0; i<frames.length; i++)
				{
					addMovie(new Movie(frames[i], _res.subImageInfos));
				}
			}
			gotoAndStop(_frame);
		}
		
		public function gotoAndStop(index:int):void
		{
			if(!_res || !_res.isReady)return; 
//			if(index>=_res.maxFrame)
//				index = 0;
			_frame = index;
			for(var i:int=0; i<_movies.length; i++)
			{
				_movies[i].gotoAndStop(index);
			}
		}
		
		public function setPos(x:int, y:int):void
		{
			_centerPos.x = x;
			_centerPos.y = y;
			refushPos();
		}
		
		public function render():void
		{
			if(!_res || !_res.isReady)return;
			for(var i:int=0; i<_movies.length; i++)
			{
				_movies[i].render();
			}
			_frame ++;
			if(_frame>_res.data.maxFrame)
				_frame = 0;
		}
		 
		public function removeMovieByData(frame:FrameData):void
		{
			for(var i:int=0; i<_movies.length; i++)
			{
				if(_movies[i].frameData == frame)
				{
					removeMovie(_movies[i]);
					break;
				}
			}
		}
		
		public function setMovieVisible():void
		{
			for(var i:int=0; i<_movies.length; i++)
			{
				var movie:Movie = _movies[i];
				movie.visible = movie.frameData.visible;
			}
		}
		
		public function removeMovie(movie:Movie):void
		{
			var index:int = _movies.indexOf(movie);
			if(index ==-1)return;
			if(_contain.contains(movie))
				_contain.removeChild(movie);
			_movies.splice(index, 1);
		}
		
		public function addMovie(movie:Movie, index:int=-1):void
		{
			var idx:int = _movies.indexOf(movie);
			if(idx!=-1)
			{
				return;
			}
			if(!_contain.contains(movie))
			{
				if(index == -1)
					_contain.addChild(movie);
				else{
					_contain.addChildAt(movie, index);
				}
				movie.x = _centerPos.x+movie.ox;
				movie.y = _centerPos.y+movie.oy;
			}
			if(index == -1)
				_movies.push(movie);
			else{
				_movies.splice(index, 0, movie);
			}
		} 
		
		private function refushPos():void
		{
			for(var i:int=0; i<_movies.length; i++)
			{
				var movie:Movie = _movies[i];
				movie.x = _centerPos.x+movie.ox;
				movie.y = _centerPos.y+movie.oy;
			}
		}
		
		public function removeAllMovies():void
		{
			while(_movies.length>0)
			{
				removeMovie(_movies[_movies.length-1]);
			}
		}
		
		public function set avaterRes(value:AvaterRes):void
		{
			_res = value;
			removeAllMovies();
			if(!_res)return;
			if(_res.isReady)
			{
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
				initMovies();
			}else{
				ToolsApp.event.addEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}
		}
		
		public function get avaterRes():AvaterRes
		{
			return _res;
		}
		
		public function dispose():void
		{
			
			ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
		}
	}
}