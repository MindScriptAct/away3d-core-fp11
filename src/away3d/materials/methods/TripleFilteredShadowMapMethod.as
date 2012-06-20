package away3d.materials.methods
{
	import away3d.arcane;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.utils.ShaderRegisterCache;
	import away3d.materials.utils.ShaderRegisterElement;

	use namespace arcane;

	public class TripleFilteredShadowMapMethod extends ShadowMapMethodBase
	{
		/**
		 * Creates a new BasicDiffuseMethod object.
		 *
		 * @param castingLight The light casting the shadow
		 */
		public function TripleFilteredShadowMapMethod(castingLight : DirectionalLight)
		{
			super(castingLight);
			if (castingLight is PointLight) throw new Error("FilteredShadowMapMethod not supported for Point Lights");
			_fragmentData[8] = 1/3;
			_fragmentData[9] = castingLight.shadowMapper.depthMapSize;
			_fragmentData[10] = 1/castingLight.shadowMapper.depthMapSize;
		}

		/**
		 * @inheritDoc
		 */
		override protected function getPlanarFragmentCode(regCache : ShaderRegisterCache, targetReg : ShaderRegisterElement) : String
		{
			var depthMapRegister : ShaderRegisterElement = regCache.getFreeTextureReg();
			var decReg : ShaderRegisterElement = regCache.getFreeFragmentConstant();
			var dataReg : ShaderRegisterElement = regCache.getFreeFragmentConstant();
			var customDataReg : ShaderRegisterElement = regCache.getFreeFragmentConstant();
			var depthCol : ShaderRegisterElement = regCache.getFreeFragmentVectorTemp();
			var uvReg : ShaderRegisterElement;
			var code : String;
            _fragmentDataIndex = decReg.index;

			regCache.addFragmentTempUsages(depthCol, 1);

			uvReg = regCache.getFreeFragmentVectorTemp();
			regCache.addFragmentTempUsages(uvReg, 1);

			code = 	"mov " + uvReg + ", " + _depthMapCoordReg + "\n" +
//					"sub " + uvReg+".x, " + _depthMapVar+".x, " + dataReg+".w	\n" +
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol+".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol+".z, " + depthCol+".z, " + dataReg + ".x		\n" +	// offset by epsilon
					"slt " + uvReg+".z, " + _depthMapCoordReg+".z, " + depthCol + ".z	\n" +    // 0 if in shadow

					"add " + uvReg+".x, " + uvReg+".x, " + customDataReg+".z		\n" + // (1, 0)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol+".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol+".z, " + depthCol+".z, " + dataReg+".x		\n" + 	// offset by epsilon
					"slt " + uvReg+".w, " + _depthMapCoordReg+".z, " + depthCol+".z		\n" +    // 0 if in shadow

					"div " + depthCol+".x, " + _depthMapCoordReg+".x, " + customDataReg+".z		\n" +
					"frc " + depthCol+".x, " + depthCol+".x		\n" +
					"sub " + uvReg+".w, " + uvReg+".w, " + uvReg+".z		\n" +
					"mul " + uvReg+".w, " + uvReg+".w, " + depthCol+".x		\n" +
					"add " + _viewDirFragmentReg+".w, " + uvReg+".z, " + uvReg+".w		\n" +

					"sub " + uvReg+".x, " + _depthMapCoordReg+".x, " + customDataReg+".z	\n" +
					"add " + uvReg+".y, " + _depthMapCoordReg+".y, " + customDataReg+".z	\n" +	// (0, 1)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol + ".z, " + depthCol+".z, " + dataReg+".x		\n" + 	// offset by epsilon
					"slt " + uvReg + ".z, " + _depthMapCoordReg+".z, " + depthCol+".z		\n" +   // 0 if in shadow

					"add " + uvReg + ".x, " + uvReg+".x, " + customDataReg+".z						\n" +	// (1, 1)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol + ".z, " + depthCol+".z, " + dataReg+".x				\n" +	// offset by epsilon
					"slt " + uvReg + ".w, " + _depthMapCoordReg+".z, " + depthCol+".z			\n" +   // 0 if in shadow

					// recalculate fraction, since we ran out of registers :(
					"mul " + depthCol + ".x, " + _depthMapCoordReg+".x, " + customDataReg+".y			\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x								\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + uvReg + ".z					\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x				\n" +
					"add " + uvReg + ".w, " + uvReg + ".z, " + uvReg + ".w					\n" +

					"mul " + depthCol + ".x, " + _depthMapCoordReg + ".y, " + customDataReg+".y		\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x								\n" +
					"sub " + uvReg + ".w, " + uvReg+".w, " + _viewDirFragmentReg+".w		\n" +
					"mul " + uvReg + ".w, " + uvReg+".w, " + depthCol + ".x					\n" +
					"add " + targetReg + ".w, " + _viewDirFragmentReg+".w, " + uvReg+".w	\n" +



//					"mov " + uvReg + ".x, " + _depthMapVar+".x						\n" +
					"sub " + uvReg + ".xy, " + _depthMapCoordReg+".xy, " + customDataReg+".zz		\n" +
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol + ".z, " + depthCol + ".z, " + dataReg+".x	\n" +	// offset by epsilon
					"slt " + uvReg + ".z, " + _depthMapCoordReg + ".z, " + depthCol+".z	\n" +   // 0 if in shadow

					"add " + uvReg + ".x, " + uvReg+".x, " + customDataReg+".z			\n" +	// (1, 0)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol + ".z, " + depthCol + ".z, " + dataReg + ".x				\n" +	// offset by epsilon
					"slt " + uvReg+".w, " + _depthMapCoordReg+".z, " + depthCol+".z					\n" +   // 0 if in shadow

					"div " + depthCol+".x, " + _depthMapCoordReg+".x, " + customDataReg+".z		\n" +
					"frc " + depthCol+".x, " + depthCol+".x								\n" +
					"sub " + uvReg+".w, " + uvReg+".w, " + uvReg+".z					\n" +
					"mul " + uvReg+".w, " + uvReg+".w, " + depthCol+".x					\n" +
					"add " + _viewDirFragmentReg + ".w, " + uvReg+".z, " + uvReg + ".w	\n" +

					"mov " + uvReg+".x, " + _depthMapCoordReg + ".x							\n" +
					"add " + uvReg+".y, " + uvReg+".y, " + customDataReg + ".z				\n" +	// (0, 1)
					"tex " + depthCol + ", " + uvReg+ ", " + depthMapRegister+ " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol+".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol+".z, " + depthCol + ".z, " + dataReg + ".x		\n" +	// offset by epsilon
					"slt " + uvReg+".z, " + _depthMapCoordReg + ".z, " + depthCol + ".z		\n" +   // 0 if in shadow

					"add " + uvReg+".x, " + uvReg+".x, " + customDataReg + ".z				\n" +	// (1, 1)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol+".z, " + depthCol + ", " + decReg + "\n" +
					"sub " + depthCol+".z, " + depthCol+".z, " + dataReg + ".x			\n" +	// offset by epsilon
					"slt " + uvReg+".w, " + _depthMapCoordReg + ".z, " + depthCol + ".z		\n" +   // 0 if in shadow

					// recalculate fraction, since we ran out of registers :(
					"mul " + depthCol + ".x, " + _depthMapCoordReg + ".x, " + customDataReg + ".y		\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x								\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + uvReg + ".z					\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x				\n" +
					"add " + uvReg + ".w, " + uvReg + ".z, " + uvReg + ".w					\n" +

					"mul " + depthCol + ".x, " + _depthMapCoordReg + ".y, " + customDataReg + ".y					\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x											\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + _viewDirFragmentReg + ".w				\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x							\n" +
					"add " + _viewDirFragmentReg + ".w, " + _viewDirFragmentReg + ".w, " + uvReg + ".w	\n" +
					"add " + targetReg + ".w, " + targetReg + ".w, " + _viewDirFragmentReg + ".w		\n";


			code +=	"add " + uvReg + ".xy, " + _depthMapCoordReg + ".xy, " + customDataReg + ".zz						\n" +	// (1, 0)
//					"mov " + uvReg + ".y, " + _depthMapVar + ".y										\n" +	// (1, 0)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg + 		"\n" +
					"sub " + depthCol + ".z, " + depthCol + ".z, " + dataReg + ".x						\n" +	// offset by epsilon
					"slt " + uvReg + ".z, " + _depthMapCoordReg + ".z, " + depthCol + ".z					\n" +   // 0 if in shadow

					"add " + uvReg + ".x, " + uvReg + ".x, " + customDataReg + ".z							\n" +	// (2, 0)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg +		"\n" +
					"sub " + depthCol + ".z, " + depthCol + ".z, " + dataReg + ".x						\n" +	// offset by epsilon
					"slt " + uvReg + ".w, " + _depthMapCoordReg + ".z, " + depthCol + ".z					\n" +   // 0 if in shadow

					"div " + depthCol + ".x, " + _depthMapCoordReg + ".x, " + customDataReg + ".z					\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x											\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + uvReg + ".z								\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x							\n" +
					"add " + _viewDirFragmentReg + ".w, " + uvReg + ".z, " + uvReg + ".w				\n" +

					"add " + uvReg+".xy, " + _depthMapCoordReg+".xy, " + customDataReg+".zz				\n" +	// (0, 1)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol + ".z, " + depthCol + ", " + decReg +		"\n" +
					"sub " + depthCol + ".z, " + depthCol+".z, " + dataReg + ".x						\n" +	// offset by epsilon
					"slt " + uvReg + ".z, " + _depthMapCoordReg+".z, " + depthCol + ".z					\n" +   // 0 if in shadow

					"add " + uvReg+".x, " + uvReg+".x, " + customDataReg+".z							\n" +	// (1, 1)
					"tex " + depthCol + ", " + uvReg + ", " + depthMapRegister + " <2d, nearest, clamp>\n" +
					"dp4 " + depthCol+".z, " + depthCol + ", " + decReg + 		"\n" +
					"sub " + depthCol+".z, " + depthCol+".z, " + dataReg+".x							\n" +	// offset by epsilon
					"slt " + uvReg+".w, " + _depthMapCoordReg+".z, " + depthCol+".z						\n" +   // 0 if in shadow

					// recalculate fraction, since we ran out of registers :(
					"mul " + depthCol + ".x, " + _depthMapCoordReg + ".x, " + customDataReg + ".y		\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x											\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + uvReg + ".z								\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x							\n" +
					"add " + uvReg + ".w, " + uvReg + ".z, " + uvReg + ".w								\n" +

					"mul " + depthCol + ".x, " + _depthMapCoordReg+".y, " + customDataReg + ".y			\n" +
					"frc " + depthCol + ".x, " + depthCol + ".x											\n" +
					"sub " + uvReg + ".w, " + uvReg + ".w, " + _viewDirFragmentReg + ".w				\n" +
					"mul " + uvReg + ".w, " + uvReg + ".w, " + depthCol + ".x							\n" +
					"add " + _viewDirFragmentReg + ".w, " + _viewDirFragmentReg + ".w, " + uvReg + ".w	\n" +
					"add " + targetReg + ".w, " + targetReg + ".w, " + _viewDirFragmentReg + ".w		\n" +


					"mul " + targetReg+".w, " + targetReg+".w, " + customDataReg + ".x					\n";


			regCache.removeFragmentTempUsage(depthCol);
			regCache.removeFragmentTempUsage(uvReg);

			_depthMapIndex = depthMapRegister.index;

			return code;
		}

	}
}