/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.SetTweenPropItem;
	public class SetTweenItemUI extends View {
		public var boxTween:Box = null;
		public var inputTime:TextInput = null;
		public var comType:ComboBox = null;
		public var listProp:List = null;
		public var btnAddTween:Button = null;
		public var btnRemoveTween:Button = null;
		protected static var uiView:XML =
			<View width="450" height="55">
			  <Clip skin="png.guidecomp.clip_格子选中" x="0" y="0" width="212" height="28" sizeGrid="5,5,5,5,1" name="selectBox"/>
			  <Box x="2" y="3" var="boxTween">
			    <Label text="时间" y="2" color="0xff9900" stroke="0" width="29" height="18"/>
			    <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="32" y="1" width="50" height="22" color="0xff6600" var="inputTime" margin="3,2,2,2"/>
			    <ComboBox skin="png.guidecomp.combobox" x="114" var="comType" width="93" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="直线,二次方加速,二次方减速,二次方加减速,三次方加速,三次方减速,三次方加减速,四次方加速,四次方减速,四次方加减速,五次方加速,五次方减速,五次方加减速,正弦加速,正弦减速,正弦加减速,超范围加速,超范围减速,超范围加减速,圆形加速,圆形减速,圆形加减速,指数反弹加速,指数反弹减速,指数反弹加减速,指数衰减加速,指数衰减减速,指数衰减加减速" selectedIndex="0" y="0"/>
			    <Label text="类型" x="82" y="3" color="0xff9900" stroke="0" width="29" height="18"/>
			  </Box>
			  <List x="256" y="1" repeatY="2" var="listProp" width="193" height="53" vScrollBarSkin="png.comp.vscroll">
			    <SetTweenPropItem x="0" y="0" name="render" runtime="com.cyj.app.view.app.SetTweenPropItem"/>
			  </List>
			  <Button skin="png.guidecomp.btn_加号_1" x="212" y="2" var="btnAddTween" width="23" height="23"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="235" y="2" var="btnRemoveTween"/>
			</View>;
		public function SetTweenItemUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.SetTweenPropItem"] = SetTweenPropItem;
			super.createChildren();
			createView(uiView);
		}
	}
}