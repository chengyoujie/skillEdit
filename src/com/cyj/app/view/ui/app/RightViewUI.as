/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.EffectStepItem;
	public class RightViewUI extends View {
		public var bg:Image = null;
		public var listStep:List = null;
		public var btnAddStep:Button = null;
		public var btnRemoveStep:Button = null;
		public var inputId:TextInput = null;
		public var boxDisInfo:Box = null;
		public var inputResName:TextInput = null;
		public var boxLoop:Box = null;
		public var inputLoop:TextInput = null;
		public var btnPlayItem:Button = null;
		public var btnPlayAll:Button = null;
		public var inputName:TextInput = null;
		public var boxEffectCtr:Box = null;
		public var comOwner:ComboBox = null;
		public var comLayer:ComboBox = null;
		public var comEndType:ComboBox = null;
		public var comTigglerType:ComboBox = null;
		public var inputOffx:TextInput = null;
		public var inputOffy:TextInput = null;
		public var inputDelay:TextInput = null;
		public var comMoveTo:ComboBox = null;
		public var boxMove:Box = null;
		public var inputSpeed:TextInput = null;
		public var inputDistance:TextInput = null;
		public var btnResetMoveDis:Button = null;
		public var comMoveEase:ComboBox = null;
		public var inputMoveOffX:TextInput = null;
		public var inputMoveOffY:TextInput = null;
		public var inputMoveRotation:TextInput = null;
		public var comMoveRotation:ComboBox = null;
		public var comMoveOffsetXType:ComboBox = null;
		public var comMoveOffsetYType:ComboBox = null;
		public var comMoveDistanceType:ComboBox = null;
		public var boxTigglerParam:Box = null;
		public var inputTigglerParam:TextInput = null;
		public var boxEndParam:Box = null;
		public var txtEndParamDes:Label = null;
		public var inputEndParam:TextInput = null;
		public var btnResetOffset:Button = null;
		public var boxDir:Box = null;
		public var comDisDir:ComboBox = null;
		public var inputRotation:TextInput = null;
		public var comRotation:ComboBox = null;
		public var inputScaley:TextInput = null;
		public var inputScalex:TextInput = null;
		public var checkScreenPos:CheckBox = null;
		public var checkBindOwner:CheckBox = null;
		public var comDealyTimeType:ComboBox = null;
		public var txtRotationOffsetDes:Label = null;
		public var btnTweenProp:Button = null;
		public var txtTweenProp:Label = null;
		public var btnTweenRefush:Button = null;
		public var comOffsetXType:ComboBox = null;
		public var comOffsetYType:ComboBox = null;
		protected static var uiView:XML =
			<View width="280" height="870">
			  <Image skin="png.guidecomp.购买类控件底_1" x="0" y="0" width="280" height="870" sizeGrid="10,10,10,10,1" var="bg"/>
			  <Label text="特效组列表" x="55" y="649" width="99" height="18" color="0x990000" align="center"/>
			  <List x="13" y="676" vScrollBarSkin="png.comp.vscroll" width="258" height="187" spaceY="2" var="listStep">
			    <EffectStepItem x="0" y="0" runtime="com.cyj.app.view.app.EffectStepItem" name="render"/>
			  </List>
			  <Button skin="png.guidecomp.btn_加号_1" x="7" y="647" var="btnAddStep"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="30" y="647" var="btnRemoveStep"/>
			  <Label text="id：" x="41" y="9" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="68" y="8" color="0x0" var="inputId" width="65" height="22"/>
			  <Box x="5" y="60" var="boxDisInfo">
			    <Label text="资源名：" color="0xff9900" stroke="0" x="10" y="2"/>
			    <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="130" height="22" var="inputResName" y="0"/>
			    <Box y="29" var="boxLoop">
			      <Label text="循环次数：" y="1" color="0xff9900" stroke="0" height="18" align="right"/>
			      <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputLoop"/>
			    </Box>
			  </Box>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="122" width="280"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayItem" labelStroke="0" width="54" height="28" x="161" label="播放当前" y="645"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnPlayAll" labelStroke="0" width="53" height="28" x="222" label="播放全部" y="644"/>
			  <Image skin="png.guidecomp.分割线_2px" x="0" y="58" width="280"/>
			  <Label text="名字：" x="27" y="34" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="67" y="33" color="0x0" var="inputName" width="130" height="22"/>
			  <Box x="-2" y="126" var="boxEffectCtr">
			    <Image skin="png.guidecomp.kuang" x="5" y="357" sizeGrid="10,10,10,10" width="275" height="160"/>
			    <ComboBox skin="png.guidecomp.combobox" x="70" var="comOwner" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者,受击者其中一个,我方全体,圣物,主人" selectedIndex="0"/>
			    <Label text="拥有者：" x="18" y="2" color="0xff9900" stroke="0" align="right"/>
			    <ComboBox skin="png.guidecomp.combobox" x="70" y="28" var="comLayer" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="角色顶部,角色底部,地图上层,地图下层,五方向自动改变层级,上层跟随角色,下层跟随角色,反五方向" selectedIndex="0"/>
			    <Label text="图层：" x="23" y="31" color="0xff9900" stroke="0" width="47" height="18" align="right"/>
			    <ComboBox skin="png.guidecomp.combobox" x="70" y="139" var="comEndType" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="特效播放结束,特效移动结束,特效播放时间,使用插件" selectedIndex="0"/>
			    <Label text="结束条件：" x="6" y="141" color="0xff9900" stroke="0"/>
			    <Image skin="png.guidecomp.kuang" x="6" y="191" sizeGrid="10,10,10,10" width="275" height="162"/>
			    <ComboBox skin="png.guidecomp.combobox" x="70" y="84" var="comTigglerType" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="开始,某一特效播放结束" selectedIndex="0"/>
			    <Label text="开始条件：" x="7" y="86" color="0xff9900" stroke="0"/>
			    <Label text="施法点偏移：" x="3" y="378.5" color="0xff9900" stroke="0" width="70" height="18"/>
			    <TextInput text="0" skin="png.comp.textinput" x="121" y="377" color="0x0" width="38" height="22" var="inputOffx"/>
			    <TextInput text="0" skin="png.comp.textinput" x="214" y="377" color="0x0" width="32" height="22" var="inputOffy"/>
			    <Label text="延迟时间：" x="6" y="437" color="0xff9900" stroke="0"/>
			    <TextInput text="0" skin="png.comp.textinput" x="184" y="436" color="0x0" width="65" height="22" var="inputDelay"/>
			    <Image skin="png.guidecomp.分割线_2px" y="81" width="280"/>
			    <Image skin="png.guidecomp.分割线_2px" y="191" width="280" x="4"/>
			    <ComboBox skin="png.guidecomp.combobox" x="71" var="comMoveTo" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="无,施法者,受击者,受击者其中一个,我方全体,圣物,主人" selectedIndex="0" y="215"/>
			    <Label text="移动到：" x="19" y="217" color="0xff9900" stroke="0" height="19"/>
			    <Box x="5" y="242" var="boxMove">
			      <Label text="速度：" x="26" y="2" color="0xff9900" stroke="0" align="right"/>
			      <TextInput text="0" skin="png.comp.textinput" x="66" color="0x0" width="65" height="22" var="inputSpeed" y="1"/>
			      <Label text="目标点偏移：" y="30" color="0xff9900" stroke="0" align="right" x="3"/>
			      <TextInput text="0" skin="png.comp.textinput" x="149" y="54" color="0x0" width="65" height="22" var="inputDistance"/>
			      <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetMoveDis" labelStroke="0" width="38" height="28" x="217" label="置零" y="51"/>
			      <Label text="缓动类型：" y="2" color="0xff9900" stroke="0" align="right" height="18" x="134"/>
			      <ComboBox skin="png.guidecomp.combobox" x="193" var="comMoveEase" width="84" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="直线,二次方加速,二次方减速,二次方加减速,三次方加速,三次方减速,三次方加减速,四次方加速,四次方减速,四次方加减速,五次方加速,五次方减速,五次方加减速,正弦加速,正弦减速,正弦加减速,超范围加速,超范围减速,超范围加减速,圆形加速,圆形减速,圆形加减速,指数反弹加速,指数反弹减速,指数反弹加减速,指数衰减加速,指数衰减减速,指数衰减加减速" selectedIndex="0" y="0"/>
			      <TextInput text="0" skin="png.comp.textinput" x="128" y="29" color="0x0" width="44" height="22" var="inputMoveOffX"/>
			      <TextInput text="0" skin="png.comp.textinput" x="229" y="27" color="0x0" width="41" height="22" var="inputMoveOffY"/>
			      <Label text="移动固定距离：" y="56" color="0xff9900" stroke="0" align="right" x="3"/>
			      <Label text="移动旋转角度：" y="85" color="0xff9900" stroke="0" x="0"/>
			      <TextInput text="0" skin="png.comp.textinput" x="184" color="0x0" width="65" height="22" var="inputMoveRotation" y="81"/>
			      <ComboBox skin="png.guidecomp.combobox" x="94" var="comMoveRotation" width="86" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="自定义,拥有者方向" selectedIndex="0" y="81"/>
			      <ComboBox skin="png.guidecomp.combobox" x="72" var="comMoveOffsetXType" width="51" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定X,高度百分比X,五方向↑↗.." selectedIndex="0" y="28"/>
			      <ComboBox skin="png.guidecomp.combobox" x="174" var="comMoveOffsetYType" width="51" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定X,高度百分比X,五方向↑↗.." selectedIndex="0" y="26"/>
			      <ComboBox skin="png.guidecomp.combobox" x="83" var="comMoveDistanceType" width="62" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定距离,到目标距离" selectedIndex="0" y="53.5"/>
			    </Box>
			    <Image skin="png.guidecomp.分割线_2px" x="2" y="373" width="280"/>
			    <Image skin="png.guidecomp.分割线_2px" x="4" y="432" width="280"/>
			    <Box x="7" y="112" var="boxTigglerParam">
			      <Label text="开始参数：" y="1" color="0xff9900" stroke="0"/>
			      <TextInput text="0" skin="png.comp.textinput" x="63" color="0x0" width="65" height="22" var="inputTigglerParam"/>
			    </Box>
			    <Box x="6" y="167" var="boxEndParam">
			      <Label text="结束参数：" y="1" color="0xff9900" stroke="0" var="txtEndParamDes"/>
			      <TextInput text="0" skin="png.comp.textinput" x="64" color="0x0" width="65" height="22" var="inputEndParam"/>
			    </Box>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnResetOffset" labelStroke="0" width="35" height="28" x="248" label="置零" y="374"/>
			    <Box x="31" var="boxDir" y="54">
			      <ComboBox skin="png.guidecomp.combobox" x="39" var="comDisDir" width="115" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="↑上,↗右上,→右,↘右下,↓下,↙左下,←左,↖左上,绑定者方向,受击者方向,左右两方向(需右图)" selectedIndex="0" y="0"/>
			      <Label text="方向：" y="2" color="0xff9900" stroke="0" x="0" align="right"/>
			    </Box>
			    <Label text="特效旋转角度：" x="7" y="465" color="0xff9900" stroke="0"/>
			    <TextInput text="0" skin="png.comp.textinput" x="210" y="464" color="0x0" width="65" height="22" var="inputRotation"/>
			    <ComboBox skin="png.guidecomp.combobox" x="93" var="comRotation" width="86" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="自定义,拥有者方向,目标方向,目标中的一个,从施法者到目标,从目标到施法者" selectedIndex="0" y="463"/>
			    <Label text="Y:" x="109" y="408" color="0xff9900" stroke="0" width="19" height="18"/>
			    <TextInput text="0" skin="png.comp.textinput" x="129" y="406" color="0x0" width="30" height="22" var="inputScaley"/>
			    <Label text="特效缩放 X:" x="8" y="407" color="0xff9900" stroke="0" width="65" height="18"/>
			    <TextInput text="0" skin="png.comp.textinput" x="77" y="406" color="0x0" width="29" height="22" var="inputScalex"/>
			    <CheckBox label="偏移使用屏幕坐标" skin="png.guidecomp.checkbox_单选" x="165" y="405" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" var="checkScreenPos"/>
			    <CheckBox label="绑定拥有者" skin="png.guidecomp.checkbox_单选" x="189" y="56" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" var="checkBindOwner"/>
			    <ComboBox skin="png.guidecomp.combobox" x="66" var="comDealyTimeType" width="112" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定,范围内随机,每个目标间隔" selectedIndex="0" y="436"/>
			    <Label text="偏移" x="180" y="465" color="0xff9900" stroke="0" width="27" height="18" var="txtRotationOffsetDes"/>
			    <Label text="特效移动相关" x="25" y="193" color="0x33ccff" stroke="0" height="18" width="238" align="center"/>
			    <Label text="特效属性相关" x="23" y="355" color="0x33ccff" stroke="0" height="18" width="238" align="center"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnTweenProp" labelStroke="0" width="61" height="28" x="11" label="缓动属性" y="489"/>
			    <Label text="缓动属性：" x="73" y="494" color="0xc79a84" stroke="0" width="60" height="18"/>
			    <Label text="无" x="135" y="494" color="0xff9900" stroke="0" width="77" height="18" var="txtTweenProp"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnTweenRefush" labelStroke="0" width="68" height="28" x="212" label="刷新缓动" y="489"/>
			    <ComboBox skin="png.guidecomp.combobox" x="69" var="comOffsetXType" width="51" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定X,高度百分比X,五方向↑↗.." selectedIndex="0" y="376.5"/>
			    <ComboBox skin="png.guidecomp.combobox" x="162" var="comOffsetYType" width="51" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="固定X,高度百分比X,五方向↑↗.." selectedIndex="0" y="376.5"/>
			  </Box>
			</View>;
		public function RightViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.EffectStepItem"] = EffectStepItem;
			super.createChildren();
			createView(uiView);
		}
	}
}