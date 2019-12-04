/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.EffectStepItem;
	public class RightViewUI extends View {
		public var comOwner:ComboBox = null;
		public var listStep:List = null;
		public var btnAddStep:Button = null;
		public var btnRemoveStep:Button = null;
		public var inputId:TextInput = null;
		public var comLayer:ComboBox = null;
		public var comEndType:ComboBox = null;
		public var comTigglerType:ComboBox = null;
		public var inputOffx:TextInput = null;
		public var inputOffy:TextInput = null;
		public var inputDelay:TextInput = null;
		public var boxDisInfo:Box = null;
		public var inputResName:TextInput = null;
		public var boxLoop:Box = null;
		public var inputLoop:TextInput = null;
		public var comMoveTo:ComboBox = null;
		public var boxMove:Box = null;
		public var inputSpeed:TextInput = null;
		public var inputDistance:TextInput = null;
		public var comAutoRotaion:ComboBox = null;
		public var btnResetMoveDis:Button = null;
		public var btnPlayItem:Button = null;
		public var boxTigglerParam:Box = null;
		public var inputTigglerParam:TextInput = null;
		public var boxEndParam:Box = null;
		public var inputEndParam:TextInput = null;
		public var btnResetOffset:Button = null;
		public var btnPlayAll:Button = null;
		public var boxDir:Box = null;
		public var comDisDir:ComboBox = null;
		protected static var uiView:XML =
			<View width="280" height="800">
			  <Image skin="png.guidecomp.购买类控件底_1" x="0" y="0" width="280" height="801" sizeGrid="10,10,10,10,1"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="114" var="comOwner" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者" selectedIndex="0"/>
			  <Label text="拥有者：" x="16" y="116" color="0xff9900" stroke="0" align="right"/>
			  <Label text="特效组列表" x="53" y="587" width="99" height="18" color="0x990000" align="center"/>
			  <List x="15" y="612" vScrollBarSkin="png.comp.vscroll" width="258" height="177" spaceY="2" var="listStep">
			    <EffectStepItem x="0" y="0" runtime="com.cyj.app.view.app.EffectStepItem" name="render"/>
			  </List>
			  <Button skin="png.guidecomp.btn_加号_1" x="5" y="585" var="btnAddStep"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="28" y="585" var="btnRemoveStep"/>
			  <Label text="id：" x="41" y="17" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="16" color="0x0" var="inputId" width="65" height="22"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="142" var="comLayer" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="角色顶部,角色底部,上层,底部,五方向" selectedIndex="0"/>
			  <Label text="图层：" x="21" y="145" color="0xff9900" stroke="0" width="47" height="18" align="right"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="259.5" var="comEndType" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="特效播放结束,特效移动结束,特效播放时间" selectedIndex="0"/>
			  <Label text="结束条件：" x="4" y="261.5" color="0xff9900" stroke="0"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="199.5" var="comTigglerType" width="124" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="开始,某一特效播放结束" selectedIndex="0"/>
			  <Label text="开始条件：" x="5" y="201.5" color="0xff9900" stroke="0"/>
			  <Label text="偏移X：" x="21" y="470" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="469" color="0x0" width="65" height="22" var="inputOffx"/>
			  <Label text="偏移Y：" x="20" y="505" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="504" color="0x0" width="65" height="22" var="inputOffy"/>
			  <Label text="延迟时间：" x="5" y="546" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="545" color="0x0" width="65" height="22" var="inputDelay"/>
			  <Box x="5" y="49" var="boxDisInfo">
			    <Label text="资源名：" color="0xff9900" stroke="0" x="10" y="2"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="130" height="22" var="inputResName" y="0"/>
			    <Box y="29" var="boxLoop">
			      <Label text="循环次数：" y="1" color="0xff9900" stroke="0" height="18" align="right"/>
			      <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputLoop"/>
			    </Box>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="106" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="-2" y="195" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="1" y="328" width="280"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" var="comMoveTo" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者" selectedIndex="0" y="336.5"/>
			  <Label text="移动到：" x="16" y="338.5" color="0xff9900" stroke="0" height="19"/>
			  <Box x="4" y="370" var="boxMove">
			    <Label text="速度：" x="24" y="1" color="0xff9900" stroke="0" align="right"/>
			    <TextInput text="0" skin="png.comp.textinput" x="64" color="0x0" width="65" height="22" var="inputSpeed" y="0"/>
			    <Label text="移动偏移：" x="1" y="29" color="0xff9900" stroke="0" align="right"/>
			    <TextInput text="0" skin="png.comp.textinput" x="64" y="29" color="0x0" width="65" height="22" var="inputDistance"/>
			    <Label text="自动旋转：" y="58" color="0xff9900" stroke="0" align="right" height="18"/>
			    <ComboBox skin="png.guidecomp.combobox" x="64" y="56" var="comAutoRotaion" width="55" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="否,是" selectedIndex="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetMoveDis" labelStroke="0" width="38" height="28" x="137" label="置零" y="26"/>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="1" y="458" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="3" y="536" width="280"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayItem" labelStroke="0" width="54" height="28" x="159" label="播放当前" y="583"/>
			  <Box x="5" y="232" var="boxTigglerParam">
			    <Label text="开始参数：" y="1" color="0xff9900" stroke="0"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputTigglerParam"/>
			  </Box>
			  <Box x="4" y="290" var="boxEndParam">
			    <Label text="结束参数：" y="1" color="0xff9900" stroke="0"/>
			    <TextInput text="0" skin="png.comp.textinput" x="64" color="0x0" width="65" height="22" var="inputEndParam"/>
			  </Box>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetOffset" labelStroke="0" width="38" height="28" x="142" label="置零" y="466"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayAll" labelStroke="0" width="53" height="28" x="220" label="播放全部" y="582"/>
			  <Box x="29" var="boxDir" y="168">
			    <ComboBox skin="png.guidecomp.combobox" x="39" var="comDisDir" width="64" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="↑上,↗右上,→右,↘右下,↓下,↙左下,←左,↖左上,绑定者方向,受击者方向" selectedIndex="0" y="0"/>
			    <Label text="方向：" y="2" color="0xff9900" stroke="0" x="0" align="right"/>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="44" width="280"/>
			</View>;
		public function RightViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.EffectStepItem"] = EffectStepItem;
			super.createChildren();
			createView(uiView);
		}
	}
}