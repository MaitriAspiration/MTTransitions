//
//  MTTransition+Effect.swift
//  MTTransitions
//
//  Created by xushuifeng on 2020/3/22.
//

import Foundation

extension MTTransition {
    
    /// A convenience way to apply transtions.
    /// If you want to configure parameters, you can use following code:
    ///
    /// let transition = MTTransition.Effect.bounce.transition
    /// transition.shadowHeight = 0.02
    public enum Effect: CaseIterable, CustomStringConvertible {
        
        case angular
        case bounce
        case bowTieHorizontal
        case bowTieVertical
        case burn
        case butterflyWaveScrawler
        case cannabisleaf
        case circle
        case circleCrop
        case circleOpen
        case colorPhase
        case colourDistance
        case crazyParametricFun
        case crossHatch
        case crossWarp
        case crossZoom
        case cube
        case directional
        case directionalWarp
        case directionalWipe
        case displacement
        case doomScreen
        case doorway
        case dreamy
        case fadeColor
        case fadegrayscale
        case fade
        case flyeye
        case glitchDisplace
        case glitchMemories
        case gridFlip
        case heart
        case hexagonalize
        case invertedPageCurl
        case kaleidoScope
        case linearBlur
        case luma
        case luminanceMelt
        case morph
        case mosaic
        case multiplyBlend
        case perlin
        case pinwheel
        case pixelize
        case polarFunction
        case polkaDotsCurtain
        case radial
        case randomSquares
        case ripple
        case rotateScaleFade
        case simpleZoom
        case squeeze
        case stereoViewer
        case swap
        case swirl
        case undulatingBurnOut
        case waterDrop
        case windowSlice
        case windowBlinds
        case wind
        case wipeDown
        case wipeLeft
        case wipeRight
        case wipeUp
        case zoomInCircles
        
        public var transition: MTTransition {
            switch self {
            case .angular:
                return MTAngularTransition()
            case .bounce:
                return MTBounceTransition()
            case .bowTieHorizontal:
                return MTBowTieHorizontalTransition()
            case .bowTieVertical:
                return MTBowTieVerticalTransition()
            case .burn:
                return MTBurnTransition()
            case .butterflyWaveScrawler:
                return MTButterflyWaveScrawlerTransition()
            case .cannabisleaf:
                return MTCannabisleafTransition()
            case .circle:
                return MTCircleTransition()
            case .circleCrop:
                return MTCircleCropTransition()
            case .circleOpen:
                return MTCircleOpenTransition()
            case .colorPhase:
                return MTColorPhaseTransition()
            case .colourDistance:
                return MTColourDistanceTransition()
            case .crazyParametricFun:
                return MTCrazyParametricFunTransition()
            case .crossHatch:
                return MTCrossHatchTransition()
            case .crossWarp:
                return MTCrossWarpTransition()
            case .crossZoom:
                return MTCrossZoomTransition()
            case .cube:
                return MTCubeTransition()
            case .directional:
                return MTDirectionalTransition()
            case .directionalWarp:
                return MTDirectionalWarpTransition()
            case .directionalWipe:
                return MTDirectionalWipeTransition()
            case .displacement:
                return MTDisplacementTransition()
            case .doomScreen:
                return MTDoomScreenTransition()
            case .doorway:
                return MTDoorwayTransition()
            case .dreamy:
                return MTDreamyTransition()
            case .fadeColor:
                return MTFadeColorTransition()
            case .fadegrayscale:
                return MTFadegrayscaleTransition()
            case .fade:
                return MTFadeTransition()
            case .flyeye:
                return MTFlyeyeTransition()
            case .glitchDisplace:
                return MTGlitchDisplaceTransition()
            case .glitchMemories:
                return MTGlitchMemoriesTransition()
            case .gridFlip:
                return MTGridFlipTransition()
            case .heart:
                return MTHeartTransition()
            case .hexagonalize:
                return MTHexagonalizeTransition()
            case .invertedPageCurl:
                return MTInvertedPageCurlTransition()
            case .kaleidoScope:
                return MTKaleidoScopeTransition()
            case .linearBlur:
                return MTLinearBlurTransition()
            case .luma:
                return MTLumaTransition()
            case .luminanceMelt:
                return MTLuminanceMeltTransition()
            case .morph:
                return MTMorphTransition()
            case .mosaic:
                return MTMosaicTransition()
            case .multiplyBlend:
                return MTMultiplyBlendTransition()
            case .perlin:
                return MTPerlinTransition()
            case .pinwheel:
                return MTPinwheelTransition()
            case .pixelize:
                return MTPixelizeTransition()
            case .polarFunction:
                return MTPolarFunctionTransition()
            case .polkaDotsCurtain:
                return MTPolkaDotsCurtainTransition()
            case .radial:
                return MTRadialTransition()
            case .randomSquares:
                return MTRandomSquaresTransition()
            case .ripple:
                return MTRippleTransition()
            case .rotateScaleFade:
                return MTRotateScaleFadeTransition()
            case .simpleZoom:
                return MTSimpleZoomTransition()
            case .squeeze:
                return MTSqueezeTransition()
            case .stereoViewer:
                return MTStereoViewerTransition()
            case .swap:
                return MTSwapTransition()
            case .swirl:
                return MTSwirlTransition()
            case .undulatingBurnOut:
                return MTUndulatingBurnOutTransition()
            case .waterDrop:
                return MTWaterDropTransition()
            case .windowSlice:
                return MTWindowSliceTransition()
            case .windowBlinds:
                return MTWindowBlindsTransition()
            case .wind:
                return MTWindTransition()
            case .wipeDown:
                return MTWipeDownTransition()
            case .wipeLeft:
                return MTWipeLeftTransition()
            case .wipeRight:
                return MTWipeRightTransition()
            case .wipeUp:
                return MTWipeUpTransition()
            case .zoomInCircles:
                return MTZoomInCirclesTransition()
            }
        }
        
        var compositor: MTVideoCompositor.Type {
            switch self {
            case .angular:
                return MTVideoTransition.AngularCompositor.self
            case .bounce:
                return MTVideoTransition.BounceCompositor.self
            case .bowTieHorizontal:
                return MTVideoTransition.BowTieHorizontalCompositor.self
            case .bowTieVertical:
                return MTVideoTransition.BowTieVerticalCompositor.self
            case .burn:
                return MTVideoTransition.BurnCompositor.self
            case .butterflyWaveScrawler:
                return MTVideoTransition.ButterflyWaveScrawlerCompositor.self
            case .cannabisleaf:
                return MTVideoTransition.CannabisleafCompositor.self
            case .circle:
                return MTVideoTransition.CircleCompositor.self
            case .circleCrop:
                return MTVideoTransition.CircleCropCompositor.self
            case .circleOpen:
                return MTVideoTransition.CircleOpenCompositor.self
            case .colorPhase:
                return MTVideoTransition.ColorPhaseCompositor.self
            case .colourDistance:
                return MTVideoTransition.ColourDistanceCompositor.self
            case .crazyParametricFun:
                return MTVideoTransition.CrazyParametricFunCompositor.self
            case .crossHatch:
                return MTVideoTransition.CrossHatchCompositor.self
            case .crossWarp:
                return MTVideoTransition.CrossWarpCompositor.self
            case .crossZoom:
                return MTVideoTransition.CrossZoomCompositor.self
            case .cube:
                return MTVideoTransition.CubeCompositor.self
            case .directional:
                return MTVideoTransition.DirectionalCompositor.self
            case .directionalWarp:
                return MTVideoTransition.DirectionalWarpCompositor.self
            case .directionalWipe:
                return MTVideoTransition.DirectionalWipeCompositor.self
            case .displacement:
                return MTVideoTransition.DisplacementCompositor.self
            case .doomScreen:
                return MTVideoTransition.DoomScreenCompositor.self
            case .doorway:
                return MTVideoTransition.DoorwayCompositor.self
            case .dreamy:
                return MTVideoTransition.DreamyCompositor.self
            case .fadeColor:
                return MTVideoTransition.FadeColorCompositor.self
            case .fadegrayscale:
                return MTVideoTransition.FadegrayscaleCompositor.self
            case .fade:
                return MTVideoTransition.FadeCompositor.self
            case .flyeye:
                return MTVideoTransition.FlyeyeCompositor.self
            case .glitchDisplace:
                return MTVideoTransition.GlitchDisplaceCompositor.self
            case .glitchMemories:
                return MTVideoTransition.GlitchMemoriesCompositor.self
            case .gridFlip:
                return MTVideoTransition.GridFlipCompositor.self
            case .heart:
                return MTVideoTransition.HeartCompositor.self
            case .hexagonalize:
                return MTVideoTransition.HexagonalizeCompositor.self
            case .invertedPageCurl:
                return MTVideoTransition.InvertedPageCurlCompositor.self
            case .kaleidoScope:
                return MTVideoTransition.KaleidoScopeCompositor.self
            case .linearBlur:
                return MTVideoTransition.LinearBlurCompositor.self
            case .luma:
                return MTVideoTransition.LumaCompositor.self
            case .luminanceMelt:
                return MTVideoTransition.LuminanceMeltCompositor.self
            case .morph:
                return MTVideoTransition.MorphCompositor.self
            case .mosaic:
                return MTVideoTransition.MosaicCompositor.self
            case .multiplyBlend:
                return MTVideoTransition.MultiplyBlendCompositor.self
            case .perlin:
                return MTVideoTransition.PerlinCompositor.self
            case .pinwheel:
                return MTVideoTransition.PinwheelCompositor.self
            case .pixelize:
                return MTVideoTransition.PixelizeCompositor.self
            case .polarFunction:
                return MTVideoTransition.PolarFunctionCompositor.self
            case .polkaDotsCurtain:
                return MTVideoTransition.PolkaDotsCurtainCompositor.self
            case .radial:
                return MTVideoTransition.RadialCompositor.self
            case .randomSquares:
                return MTVideoTransition.RandomSquaresCompositor.self
            case .ripple:
                return MTVideoTransition.RippleCompositor.self
            case .rotateScaleFade:
                return MTVideoTransition.RotateScaleFadeCompositor.self
            case .simpleZoom:
                return MTVideoTransition.SimpleZoomCompositor.self
            case .squeeze:
                return MTVideoTransition.SqueezeCompositor.self
            case .stereoViewer:
                return MTVideoTransition.StereoViewerCompositor.self
            case .swap:
                return MTVideoTransition.SwapCompositor.self
            case .swirl:
                return MTVideoTransition.SwirlCompositor.self
            case .undulatingBurnOut:
                return MTVideoTransition.UndulatingBurnOutCompositor.self
            case .waterDrop:
                return MTVideoTransition.WaterDropCompositor.self
            case .windowSlice:
                return MTVideoTransition.WindowSliceCompositor.self
            case .windowBlinds:
                return MTVideoTransition.WindowBlindsCompositor.self
            case .wind:
                return MTVideoTransition.WindCompositor.self
            case .wipeDown:
                return MTVideoTransition.WipeDownCompositor.self
            case .wipeLeft:
                return MTVideoTransition.WipeLeftCompositor.self
            case .wipeRight:
                return MTVideoTransition.WipeRightCompositor.self
            case .wipeUp:
                return MTVideoTransition.WipeUpCompositor.self
            case .zoomInCircles:
                return MTVideoTransition.ZoomInCirclesCompositor.self
            }
        }
        
        public var description: String {
            switch self {
            case .angular:
                return "Angular"
            case .bounce:
                return "Bounce"
            case .bowTieHorizontal:
                return "BowTieHorizontal"
            case .bowTieVertical:
                return "BowTieVertical"
            case .burn:
                return "Burn"
            case .butterflyWaveScrawler:
                return "ButterflyWaveScrawler"
            case .cannabisleaf:
                return "Cannabisleaf"
            case .circle:
                return "Circle"
            case .circleCrop:
                return "CircleCrop"
            case .circleOpen:
                return "CircleOpen"
            case .colorPhase:
                return "ColorPhase"
            case .colourDistance:
                return "ColourDistance"
            case .crazyParametricFun:
                return "CrazyParametricFun"
            case .crossHatch:
                return "CrossHatch"
            case .crossWarp:
                return "CrossWarp"
            case .crossZoom:
                return "CrossZoom"
            case .cube:
                return "Cube"
            case .directional:
                return "Directional"
            case .directionalWarp:
                return "DirectionalWarp"
            case .directionalWipe:
                return "DirectionalWipe"
            case .displacement:
                return "Displacement"
            case .doomScreen:
                return "DoomScreen"
            case .doorway:
                return "Doorway"
            case .dreamy:
                return "Dreamy"
            case .fadeColor:
                return "FadeColor"
            case .fadegrayscale:
                return "Fadegrayscale"
            case .fade:
                return "Fade"
            case .flyeye:
                return "Flyeye"
            case .glitchDisplace:
                return "GlitchDisplace"
            case .glitchMemories:
                return "GlitchMemories"
            case .gridFlip:
                return "GridFlip"
            case .heart:
                return "Heart"
            case .hexagonalize:
                return "Hexagonalize"
            case .invertedPageCurl:
                return "InvertedPageCurl"
            case .kaleidoScope:
                return "KaleidoScope"
            case .linearBlur:
                return "LinearBlur"
            case .luma:
                return "Luma"
            case .luminanceMelt:
                return "LuminanceMelt"
            case .morph:
                return "Morph"
            case .mosaic:
                return "Mosaic"
            case .multiplyBlend:
                return "MultiplyBlend"
            case .perlin:
                return "Perlin"
            case .pinwheel:
                return "Pinwheel"
            case .pixelize:
                return "Pixelize"
            case .polarFunction:
                return "PolarFunction"
            case .polkaDotsCurtain:
                return "PolkaDotsCurtain"
            case .radial:
                return "Radial"
            case .randomSquares:
                return "RandomSquares"
            case .ripple:
                return "Ripple"
            case .rotateScaleFade:
                return "RotateScaleFade"
            case .simpleZoom:
                return "SimpleZoom"
            case .squeeze:
                return "Squeeze"
            case .stereoViewer:
                return "StereoViewer"
            case .swap:
                return "Swap"
            case .swirl:
                return "Swirl"
            case .undulatingBurnOut:
                return "UndulatingBurnOut"
            case .waterDrop:
                return "WaterDrop"
            case .windowSlice:
                return "WindowSlice"
            case .windowBlinds:
                return "WindowBlinds"
            case .wind:
                return "Wind"
            case .wipeDown:
                return "WipeDown"
            case .wipeLeft:
                return "WipeLeft"
            case .wipeRight:
                return "WipeRight"
            case .wipeUp:
                return "WipeUp"
            case .zoomInCircles:
                return "ZoomInCircles"
            }
        }
    }
}
