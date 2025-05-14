package com.cyj.app.utils
{
	import com.cyj.app.view.common.TipMsg;
	
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class SoundUtils
	{
		public function SoundUtils()
		{
		}
		
		public static function play(name:String):void{
			var soundPath:String = ComUtill.getSoundPath(name);
			//trace("播放音效"+soundPath);
			var file:File = new File(soundPath);
			if(!file.exists){
				TipMsg.show("声音 "+soundPath+"不存在");
				return;
			}
			var sound:Sound = new Sound(new URLRequest(soundPath));
			sound.play(0, 1);
		}
	}
}