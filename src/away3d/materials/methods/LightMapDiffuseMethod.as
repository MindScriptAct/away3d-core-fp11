package away3d.materials.methods
{
	import away3d.arcane;
	import away3d.core.managers.Stage3DProxy;
	import away3d.materials.utils.ShaderRegisterCache;
	import away3d.materials.utils.ShaderRegisterElement;
	import away3d.textures.Texture2DBase;
	
	use namespace arcane;

	/**
	 * COMMENT : todo
	 */
	public class LightMapDiffuseMethod extends CompositeDiffuseMethod
	{
		public static const MULTIPLY : String = "multiply";
		public static const ADD : String = "add";

		private var _texture : Texture2DBase;
		private var _blendMode : String;
		private var _useSecondaryUV : Boolean;

		/**
		 * COMMENT : todo
		 * @param	lightMap		COMMENT : todo
		 * @param	blendMode		COMMENT : todo
		 * @param	useSecondaryUV	COMMENT : todo
		 * @param	baseMethod		COMMENT : todo
		 */
		public function LightMapDiffuseMethod(lightMap : Texture2DBase, blendMode : String = "multiply", useSecondaryUV : Boolean = false, baseMethod : BasicDiffuseMethod = null)
		{
			super(null, baseMethod);
			_useSecondaryUV = useSecondaryUV;
			_texture = lightMap;
			this.blendMode = blendMode;
		}
		override arcane function initVO(vo : MethodVO) : void
		{
			vo.needsSecondaryUV = _useSecondaryUV;
			vo.needsUV = !_useSecondaryUV;
		}

		/**
		 * COMMENT : todo 
		 */
		public function get blendMode() : String
		{
			return _blendMode;
		}

		public function set blendMode(value : String) : void
		{
			if (value != ADD && value != MULTIPLY) throw new Error("Unknown blendmode!");
			if (_blendMode == value) return;
			_blendMode = value;
			invalidateShaderProgram();
		}

		/**
		 * COMMENT : todo 
		 */
		public function get lightMapTexture() : Texture2DBase
		{
			return _texture;
		}

		public function set lightMapTexture(value : Texture2DBase) : void
		{
			_texture = value;
		}

		arcane override function activate(vo : MethodVO, stage3DProxy : Stage3DProxy) : void
		{
			stage3DProxy.setTextureAt(vo.secondaryTexturesIndex, _texture.getTextureForStage3D(stage3DProxy));
			super.activate(vo, stage3DProxy);
		}

		arcane override function getFragmentPostLightingCode(vo : MethodVO, regCache : ShaderRegisterCache, targetReg : ShaderRegisterElement) : String
		{
			var code : String;
			var lightMapReg : ShaderRegisterElement = regCache.getFreeTextureReg();
			var temp : ShaderRegisterElement = regCache.getFreeFragmentVectorTemp();
			vo.secondaryTexturesIndex = lightMapReg.index;

			code = getTexSampleCode(vo, temp, lightMapReg, _secondaryUVFragmentReg);

			switch (_blendMode) {
				case MULTIPLY:
					code += "mul " + _totalLightColorReg + ", " + _totalLightColorReg + ", " + temp + "\n";
					break;
				case ADD:
					code += "add " + _totalLightColorReg + ", " + _totalLightColorReg + ", " + temp + "\n";
					break;
			}

			code += super.getFragmentPostLightingCode(vo, regCache, targetReg);

			return code;
		}
	}
}
