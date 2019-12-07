/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.EffectStepItem;
	public class RightViewUI extends View {
		public var bg:Image = null;
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
		public var btnResetMoveDis:Button = null;
		public var comMoveEase:ComboBox = null;
		public var btnPlayItem:Button = null;
		public var boxTigglerParam:Box = null;
		public var inputTigglerParam:TextInput = null;
		public var boxEndParam:Box = null;
		public var txtEndParamDes:Label = null;
		public var inputEndParam:TextInput = null;
		public var btnResetOffset:Button = null;
		public var btnPlayAll:Button = null;
		public var boxDir:Box = null;
		public var comDisDir:ComboBox = null;
		public var inputName:TextInput = null;
		public var inputRotation:TextInput = null;
		public var comRotation:ComboBox = null;
		protected static var uiView:XML =
			<View width="280" height="800">
			  <Image skin="png.guidecomp.购买类控件底_1" x="0" y="0" width="280" height="801" sizeGrid="10,10,10,10,1" var="bg"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="123" var="comOwner" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者" selectedIndex="0"/>
			  <Label text="拥有者：" x="16" y="125" color="0xff9900" stroke="0" align="right"/>
			  <Label text="特效组列表" x="53" y="581" width="99" height="18" color="0x990000" align="center"/>
			  <List x="11" y="608" vScrollBarSkin="png.comp.vscroll" width="258" height="187" spaceY="2" var="listStep">
			    <EffectStepItem x="0" y="0" runtime="com.cyj.app.view.app.EffectStepItem" name="render"/>
			  </List>
			  <Button skin="png.guidecomp.btn_加号_1" x="5" y="579" var="btnAddStep"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="28" y="579" var="btnRemoveStep"/>
			  <Label text="id：" x="41" y="9" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="8" color="0x0" var="inputId" width="65" height="22"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="151" var="comLayer" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="角色顶部,角色底部,上层,底部,五方向" selectedIndex="0"/>
			  <Label text="图层：" x="21" y="154" color="0xff9900" stroke="0" width="47" height="18" align="right"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="267.5" var="comEndType" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="特效播放结束,特效移动结束,特效播放时间,使用插件" selectedIndex="0"/>
			  <Label text="结束条件：" x="4" y="269.5" color="0xff9900" stroke="0"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" y="207.5" var="comTigglerType" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="开始,某一特效播放结束" selectedIndex="0"/>
			  <Label text="开始条件：" x="5" y="209.5" color="0xff9900" stroke="0"/>
			  <Label text="偏移X：" x="21" y="456" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="455" color="0x0" width="65" height="22" var="inputOffx"/>
			  <Label text="偏移Y：" x="20" y="486" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="485" color="0x0" width="65" height="22" var="inputOffy"/>
			  <Label text="延迟时间：" x="5" y="518" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="517" color="0x0" width="65" height="22" var="inputDelay"/>
			  <Box x="5" y="62" var="boxDisInfo">
			    <Label text="资源名：" color="0xff9900" stroke="0" x="10" y="2"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="130" height="22" var="inputResName" y="0"/>
			    <Box y="29" var="boxLoop">
			      <Label text="循环次数：" y="1" color="0xff9900" stroke="0" height="18" align="right"/>
			      <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputLoop"/>
			    </Box>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="119" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="-2" y="203" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="1" y="324" width="280"/>
			  <ComboBox skin="png.guidecomp.combobox" x="68" var="comMoveTo" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者" selectedIndex="0" y="328.5"/>
			  <Label text="移动到：" x="16" y="330.5" color="0xff9900" stroke="0" height="19"/>
			  <Box x="5" y="362" var="boxMove">
			    <Label text="速度：" x="23" y="1" color="0xff9900" stroke="0" align="right"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputSpeed"/>
			    <Label text="移动偏移：" y="29" color="0xff9900" stroke="0" align="right"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" y="29" color="0x0" width="65" height="22" var="inputDistance"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetMoveDis" labelStroke="0" width="38" height="28" x="136" label="置零" y="26"/>
			    <Label text="移动类型：" y="59" color="0xff9900" stroke="0" align="right" height="18" x="1"/>
			    <ComboBox skin="png.guidecomp.combobox" x="65" y="57" var="comMoveEase" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="直线,二次方加速,二次方减速,二次方加减速,三次方加速,三次方减速,三次方加减速,四次方加速,四次方减速,四次方加减速,五次方加速,五次方减速,五次方加减速,正弦加速,正弦减速,正弦加减速,超范围加速,超范围减速,超范围加减速,圆形加速,圆形减速,圆形加减速,指数反弹加速,指数反弹减速,指数反弹加减速,指数衰减加速,指数衰减减速,指数衰减加减速" selectedIndex="0"/>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="1" y="449" width="280"/>
			  <Image skin="png.guidecomp.分割线_2px" x="3" y="511" width="280"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayItem" labelStroke="0" width="54" height="28" x="159" label="播放当前" y="577"/>
			  <Box x="5" y="240" var="boxTigglerParam">
			    <Label text="开始参数：" y="1" color="0xff9900" stroke="0"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputTigglerParam"/>
			  </Box>
			  <Box x="4" y="298" var="boxEndParam">
			    <Label text="结束参数：" y="1" color="0xff9900" stroke="0" var="txtEndParamDes"/>
			    <TextInput text="0" skin="png.comp.textinput" x="64" color="0x0" width="65" height="22" var="inputEndParam"/>
			  </Box>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetOffset" labelStroke="0" width="38" height="28" x="142" label="置零" y="452"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayAll" labelStroke="0" width="53" height="28" x="220" label="播放全部" y="576"/>
			  <Box x="29" var="boxDir" y="177">
			    <ComboBox skin="png.guidecomp.combobox" x="39" var="comDisDir" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="↑上,↗右上,→右,↘右下,↓下,↙左下,←左,↖左上,绑定者方向,受击者方向" selectedIndex="0" y="0"/>
			    <Label text="方向：" y="2" color="0xff9900" stroke="0" x="0" align="right"/>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="59" width="280"/>
			  <Label text="名字：" x="27" y="34" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="67" y="33" color="0x0" var="inputName" width="130" height="22"/>
			  <Label text="旋转角度：" x="6" y="544" color="0xff9900" stroke="0"/>
			  <TextInput text="0" skin="png.comp.textinput" x="155" y="544" color="0x0" width="65" height="22" var="inputRotation"/>
			  <ComboBox skin="png.guidecomp.combobox" x="66" var="comRotation" width="86" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="自定义,拥有者方向,目标方向" selectedIndex="0" y="543"/>
			</View>;
		public function RightViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.EffectStepItem"] = EffectStepItem;
			super.createChildren();
			createView(uiView);
		}
	}
}