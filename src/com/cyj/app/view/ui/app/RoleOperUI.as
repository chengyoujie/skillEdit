/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class RoleOperUI extends View {
		public var imgBg:Image = null;
		public var boxDir:Box = null;
		public var btnUp:Button = null;
		public var btnUpRight:Button = null;
		public var btnRight:Button = null;
		public var btnRightDown:Button = null;
		public var btnDown:Button = null;
		public var btnLeftDown:Button = null;
		public var btnLeft:Button = null;
		public var btnLeftUp:Button = null;
		public var boxEffectOper:Box = null;
		public var btnOwnerDir:Button = null;
		public var btnTargetDir:Button = null;
		public var boxOper:Box = null;
		public var boxEffect:Box = null;
		public var inputLoop:TextInput = null;
		public var comOwner:ComboBox = null;
		public var comLayer:ComboBox = null;
		public var boxRole:Box = null;
		public var comRoleType:ComboBox = null;
		public var comAct:ComboBox = null;
		public var btnHide:Button = null;
		protected static var uiView:XML =
			<View width="200" height="80">
			  <Image skin="png.comp.blank" x="0" y="0" width="201" height="80" var="imgBg"/>
			  <Box x="137" y="2" var="boxDir">
			    <Button label="↑" skin="png.guidecomp.btn_小按钮_1" x="20" width="20" height="22" var="btnUp" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="↗" skin="png.guidecomp.btn_小按钮_1" x="40" width="20" height="22" var="btnUpRight" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="→" skin="png.guidecomp.btn_小按钮_1" x="41" y="23" width="20" height="25" var="btnRight" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="↘" skin="png.guidecomp.btn_小按钮_1" x="40" y="49" width="20" height="22" var="btnRightDown" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="↓" skin="png.guidecomp.btn_小按钮_1" x="20" y="49" var="btnDown" width="20" height="22" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="↙" skin="png.guidecomp.btn_小按钮_1" y="49" var="btnLeftDown" width="20" height="22" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="←" skin="png.guidecomp.btn_小按钮_1" y="23" width="20" height="25" var="btnLeft" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Button label="↖" skin="png.guidecomp.btn_小按钮_1" width="20" height="22" var="btnLeftUp" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			    <Box x="19" y="19" var="boxEffectOper">
			      <Button label="主" skin="png.guidecomp.btn_小按钮_1" width="22" height="17" var="btnOwnerDir" labelColors="0xc79a84,0xe0a98d,0x93827a"/>
			      <Button skin="png.guidecomp.btn_小按钮_1" y="16" width="22" height="17" var="btnTargetDir" labelColors="0xc79a84,0xe0a98d,0x93827a" label="受"/>
			    </Box>
			  </Box>
			  <Box x="10" y="3" var="boxOper">
			    <Box var="boxEffect">
			      <Label text="循环次数" y="2" width="55" height="18" align="center" color="0xffff00" x="0"/>
			      <TextInput text="0" skin="png.comp.textinput" x="57" width="63" height="22" var="inputLoop" y="0"/>
			      <ComboBox labels="无,施法者,受击者" skin="png.comp.combobox" x="57" var="comOwner" width="64" height="23" y="28" selectedIndex="0"/>
			      <Label y="30" width="55" height="18" align="center" color="0xffff00" x="0" text="拥有者"/>
			      <ComboBox labels="角色顶部,角色底部,上层,底部,五方向" skin="png.comp.combobox" x="57" var="comLayer" width="64" height="23" y="54" selectedIndex="0"/>
			      <Label y="56" width="55" height="18" align="center" color="0xffff00" x="0" text="图层"/>
			    </Box>
			    <Box var="boxRole">
			      <ComboBox labels="旁观者,施法者,受击者" skin="png.comp.combobox" x="57" var="comRoleType" width="65" height="23"/>
			      <Label text="角色类型" y="2" width="55" height="18" align="center" color="0xffff00" x="0"/>
			      <ComboBox labels="站立,移动,攻击,攻击0,攻击1,攻击2,攻击3,攻击4" skin="png.comp.combobox" x="57" var="comAct" width="64" height="23" y="28"/>
			      <Label text="动作" y="30" width="55" height="18" align="center" color="0xffff00" x="0"/>
			    </Box>
			  </Box>
			  <Button label="隐" skin="png.comp.button" x="-1" y="0" width="17" height="17" var="btnHide"/>
			</View>;
		public function RoleOperUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}