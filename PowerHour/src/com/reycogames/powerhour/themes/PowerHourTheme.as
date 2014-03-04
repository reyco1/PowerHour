package com.reycogames.powerhour.themes
{
	import com.reycogames.powerhour.model.AppFonts;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.DisplayObjectContainer;
	
	public class PowerHourTheme extends MetalWorksMobileTheme
	{
		public function PowerHourTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		override protected function baseButtonInitializer(button:Button):void
		{
			button.disabledLabelProperties.textFormat = this.darkUIDisabledTextFormat;
			button.disabledLabelProperties.embedFonts = true;
			
			button.defaultLabelProperties.textFormat = new TextFormat(AppFonts.ARIAL_BLACK, 24 * this.scale, 0xFFFFFF, true);
			button.defaultLabelProperties.embedFonts = true;
			
			button.selectedDisabledLabelProperties.textFormat = new TextFormat(AppFonts.ARIAL_BLACK, 24 * this.scale, 0x000000, true);
			button.selectedDisabledLabelProperties.embedFonts = true;
			
			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}
		
		override protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: 88 * this.scale,
						height: 88 * this.scale,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.textFormat = new TextFormat(AppFonts.ARIAL, 40 * this.scale, 0xFFFFFF);
			renderer.defaultLabelProperties.embedFonts = true;
			
			renderer.downLabelProperties.textFormat = new TextFormat(AppFonts.ARIAL, 40 * this.scale, 0x000000);
			renderer.downLabelProperties.embedFonts = true;
			
			renderer.defaultSelectedLabelProperties.textFormat = new TextFormat(AppFonts.ARIAL, 40 * this.scale, 0x000000);
			renderer.defaultSelectedLabelProperties.embedFonts = true;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}
	}
}