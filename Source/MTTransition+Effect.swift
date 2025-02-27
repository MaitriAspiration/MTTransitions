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
        /// none transition applied
        case none
        case angular
        case bounce
        case bowTieHorizontal
        case bowTieVertical
        case burn
        case butterflyWaveScrawler
        case BiLinear
        case coordFormIn
        case ConicalAsym
        case ConicalSym
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
        case directionalEasing
        case directionalWarp
        case directionalWipe
        case displacement
        case doomScreen
        case doorway
        case dreamy
        case dreamyZoom
        case fadeColor
        case fadegrayscale
        case flyeye
        case glitchDisplace
        case glitchMemories
        case gridFlip
        case heart
        case hexagonalize
        case invertedPageCurl
        case kaleidoScope
        case leftRight
        case linearBlur
        case luminanceMelt
        case LinearAawtoothLateral
        case morph
        case mosaic
        case multiplyBlend
        case perlin
        case pinwheel
        case pixelize
        case polarFunction
        case polkaDotsCurtain
        case powerKaleido
        case radial
        case randomNoisex
        case randomSquares
        case ripple
        case rotate
        case rotateScaleFade
        case RadialTriLateral
        case RadialTriLateralReverse
        case RotateFade
        case simpleZoom
        case squaresWire
        case squeeze
        case stereoViewer
        case swap
        case swirl
        case scaleIn
        case ScaleFade
        case Spiral1
        case Spiral2
        case Spiral3
        case Square
        case swipeLeft
        case tangentMotionBlur
        case topBottom
        case tvStatic
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
        case ZoomLeftWipe
        case zoomRightWipe

        public var transition: MTTransition {
            switch self {
            case .none: return MTFadeTransition()
            case .angular: return MTAngularTransition()
            case .bounce: return MTBounceTransition()
            case .bowTieHorizontal: return MTBowTieHorizontalTransition()
            case .bowTieVertical: return MTBowTieVerticalTransition()
            case .burn: return MTBurnTransition()
            case .butterflyWaveScrawler: return MTButterflyWaveScrawlerTransition()
            case .BiLinear: return MTLumaTransition()
            case .coordFormIn: return MTCoordFormInTransition()
            case .ConicalAsym: return MTLumaTransition()
            case .ConicalSym: return MTLumaTransition()
            case .cannabisleaf: return MTCannabisleafTransition()
            case .circle: return MTCircleTransition()
            case .circleCrop: return MTCircleCropTransition()
            case .circleOpen: return MTCircleOpenTransition()
            case .colorPhase: return MTColorPhaseTransition()
            case .colourDistance: return MTColourDistanceTransition()
            case .crazyParametricFun: return MTCrazyParametricFunTransition()
            case .crossHatch: return MTCrossHatchTransition()
            case .crossWarp: return MTCrossWarpTransition()
            case .crossZoom: return MTCrossZoomTransition()
            case .cube: return MTCubeTransition()
            case .directional: return MTDirectionalTransition()
            case .directionalEasing: return MTDirectionalEasingTransition()
            case .directionalWarp: return MTDirectionalWarpTransition()
            case .directionalWipe: return MTDirectionalWipeTransition()
            case .displacement: return MTDisplacementTransition()
            case .doomScreen: return MTDoomScreenTransition()
            case .doorway: return MTDoorwayTransition()
            case .dreamy: return MTDreamyTransition()
            case .dreamyZoom: return MTDreamyZoomTransition()
            case .fadeColor: return MTFadeColorTransition()
            case .fadegrayscale: return MTFadegrayscaleTransition()
            case .flyeye: return MTFlyeyeTransition()
            case .glitchDisplace: return MTGlitchDisplaceTransition()
            case .glitchMemories: return MTGlitchMemoriesTransition()
            case .gridFlip: return MTGridFlipTransition()
            case .heart: return MTHeartTransition()
            case .hexagonalize: return MTHexagonalizeTransition()
            case .invertedPageCurl: return MTInvertedPageCurlTransition()
            case .kaleidoScope: return MTKaleidoScopeTransition()
            case .leftRight: return MTLeftRightTransition()
            case .linearBlur: return MTLinearBlurTransition()
            case .luminanceMelt: return MTLuminanceMeltTransition()
            case .morph: return MTMorphTransition()
            case .mosaic: return MTMosaicTransition()
            case .multiplyBlend: return MTMultiplyBlendTransition()
            case .perlin: return MTPerlinTransition()
            case .pinwheel: return MTPinwheelTransition()
            case .pixelize: return MTPixelizeTransition()
            case .polarFunction: return MTPolarFunctionTransition()
            case .polkaDotsCurtain: return MTPolkaDotsCurtainTransition()
            case .powerKaleido: return MTPowerKaleidoTransition()
            case .radial: return MTRadialTransition()
            case .randomNoisex: return MTRandomNoisexTransition()
            case .randomSquares: return MTRandomSquaresTransition()
            case .ripple: return MTRippleTransition()
            case .rotate: return MTRotateTransition()
            case .rotateScaleFade: return MTRotateScaleFadeTransition()
            case .simpleZoom: return MTSimpleZoomTransition()
            case .squaresWire: return MTSquaresWireTransition()
            case .squeeze: return MTSqueezeTransition()
            case .stereoViewer: return MTStereoViewerTransition()
            case .swap: return MTSwapTransition()
            case .swirl: return MTSwirlTransition()
            case .tangentMotionBlur: return MTTangentMotionBlurTransition()
            case .topBottom: return MTTopBottomTransition()
            case .tvStatic: return MTTVStaticTransition()
            case .undulatingBurnOut: return MTUndulatingBurnOutTransition()
            case .waterDrop: return MTWaterDropTransition()
            case .windowSlice: return MTWindowSliceTransition()
            case .windowBlinds: return MTWindowBlindsTransition()
            case .wind: return MTWindTransition()
            case .wipeDown: return MTWipeDownTransition()
            case .wipeLeft: return MTWipeLeftTransition()
            case .wipeRight: return MTWipeRightTransition()
            case .wipeUp: return MTWipeUpTransition()
            case .zoomInCircles: return MTZoomInCirclesTransition()
            case .swipeLeft : return MTSwipeLeftTransition()
            case .ZoomLeftWipe: return MTZoomLeftWipeTransition()
            case .zoomRightWipe: return MTZoomRightWipeTransition()
            case .scaleIn: return MTScaleTransition()
            case .ScaleFade: return MTScaleFadeTransition()
            case .LinearAawtoothLateral: return MTLumaTransition()
            case .RadialTriLateral: return  MTLumaTransition()
            case .RadialTriLateralReverse: return MTLumaTransition()
            case .Spiral1: return MTLumaTransition()
            case .Spiral2: return MTLumaTransition()
            case .Spiral3: return MTLumaTransition()
            case .Square: return MTLumaTransition()
            case .RotateFade: return MTRotateFadeTransition()
            }
        }
        
        public var description: String {
            switch self {
            case .none: return "None"
            case .angular: return "Angular"
            case .bounce: return "Bounce"
            case .bowTieHorizontal: return "BowTieHorizontal"
            case .bowTieVertical: return "BowTieVertical"
            case .burn: return "Burn"
            case .butterflyWaveScrawler: return "ButterflyWaveScrawler"
            case .cannabisleaf: return "Cannabisleaf"
            case .circle: return "Circle"
            case .circleCrop: return "CircleCrop"
            case .circleOpen: return "CircleOpen"
            case .colorPhase: return "ColorPhase"
            case .colourDistance: return "ColourDistance"
            case .crazyParametricFun: return "CrazyParametricFun"
            case .crossHatch: return "CrossHatch"
            case .crossWarp: return "CrossWarp"
            case .crossZoom: return "CrossZoom"
            case .cube: return "Cube"
            case .directional: return "Directional"
            case .directionalEasing: return "DirectionalEasing"
            case .directionalWarp: return "DirectionalWarp"
            case .directionalWipe: return "DirectionalWipe"
            case .displacement: return "Displacement"
            case .doomScreen: return "DoomScreen"
            case .doorway: return "Doorway"
            case .dreamy: return "Dreamy"
            case .dreamyZoom: return "DreamyZoom"
            case .fadeColor: return "FadeColor"
            case .fadegrayscale: return "Fadegrayscale"
            case .flyeye: return "Flyeye"
            case .glitchDisplace: return "GlitchDisplace"
            case .glitchMemories: return "GlitchMemories"
            case .gridFlip: return "GridFlip"
            case .heart: return "Heart"
            case .hexagonalize: return "Hexagonalize"
            case .invertedPageCurl: return "InvertedPageCurl"
            case .kaleidoScope: return "KaleidoScope"
            case .leftRight: return "LeftRight"
            case .linearBlur: return "LinearBlur"
            case .luminanceMelt: return "LuminanceMelt"
            case .morph: return "Morph"
            case .mosaic: return "Mosaic"
            case .multiplyBlend: return "MultiplyBlend"
            case .perlin: return "Perlin"
            case .pinwheel: return "Pinwheel"
            case .pixelize: return "Pixelize"
            case .polarFunction: return "PolarFunction"
            case .polkaDotsCurtain: return "PolkaDotsCurtain"
            case .powerKaleido: return "PowerKaleido"
            case .radial: return "Radial"
            case .randomNoisex: return "RandomNoisex"
            case .randomSquares: return "RandomSquares"
            case .ripple: return "Ripple"
            case .rotate: return "Rotate"
            case .rotateScaleFade: return "RotateScaleFade"
            case .simpleZoom: return "SimpleZoom"
            case .squaresWire: return "SquaresWire"
            case .squeeze: return "Squeeze"
            case .stereoViewer: return "StereoViewer"
            case .swap: return "Swap"
            case .swirl: return "Swirl"
            case .tangentMotionBlur: return "TangentMotionBlur"
            case .topBottom: return "TopBottom"
            case .tvStatic: return "TVStatic"
            case .undulatingBurnOut: return "UndulatingBurnOut"
            case .waterDrop: return "WaterDrop"
            case .windowSlice: return "WindowSlice"
            case .windowBlinds: return "WindowBlinds"
            case .wind: return "Wind"
            case .wipeDown: return "WipeDown"
            case .wipeLeft: return "WipeLeft"
            case .wipeRight: return "WipeRight"
            case .wipeUp: return "WipeUp"
            case .zoomInCircles: return "ZoomInCircles"
            case .swipeLeft: return "SwipeLeft"
            case .ZoomLeftWipe: return "ZoomLeftWipe"
            case .zoomRightWipe: return "ZoomRightWipe"
            case .coordFormIn: return "CoordFormIn"
            case .scaleIn: return "ScaleIn"
            case .ScaleFade: return "ScaleFade"
            case .BiLinear: return "BiLinear"
            case .ConicalAsym: return "ConicalAsym"
            case .ConicalSym: return "ConicalSym"
            case .LinearAawtoothLateral: return "LinearLine"
            case .RadialTriLateral: return  "RadialCurv"
            case .RadialTriLateralReverse: return "RadialReverse"
            case .Spiral1: return "SingleSpiral"
            case .Spiral2: return "SmallSpiral"
            case .Spiral3: return "BigSpiral"
            case .Square: return "Square"
            case .RotateFade: return "RotateFade"
            }
        }
        
        public var image: String {
            switch self {
            case .none: return "ic_fade"
            case .angular: return "ic_angular"
            case .bounce: return "ic_bounce"
            case .bowTieHorizontal: return "ic_bow_horizontal"
            case .bowTieVertical: return "ic_bowvertical"
            case .burn: return "ic_burn"
            case .butterflyWaveScrawler: return "ic_but...scrawler"
            case .cannabisleaf: return "ic_cannabisleaf"
            case .circle: return "ic_circle"
            case .circleCrop: return "ic_circlecrop"
            case .circleOpen: return "ic_circleopen"
            case .colorPhase: return "ic_colorphase"
            case .colourDistance: return "ic_colourdistance"
            case .crazyParametricFun: return "ic_crazy..tricfun"
            case .crossHatch: return "ic_crosshatch"
            case .crossWarp: return "ic_crosswarp"
            case .crossZoom: return "ic_crosszoom"
            case .cube: return "ic_cube"
            case .directional: return "ic_directional"
            case .directionalEasing: return "ic_direc...easing"
            case .directionalWarp: return "ic_directi..warp"
            case .directionalWipe: return "ic_directi..wipe"
            case .displacement: return "ic_displacement"
            case .doomScreen: return "ic_doomScreen"
            case .doorway: return "ic_doorway"
            case .dreamy: return "ic_dreamy"
            case .dreamyZoom: return "ic_dreamyzoom"
            case .fadeColor: return "ic_fadecolor"
            case .fadegrayscale: return "ic_fadegrayscale"
            case .flyeye: return "ic_flyeye"
            case .glitchDisplace: return "ic_glitchdisplace"
            case .glitchMemories: return "ic_glitchmemories"
            case .gridFlip: return "ic_gridflip"
            case .heart: return "ic_heart"
            case .hexagonalize: return "ic_hexagonalize"
            case .invertedPageCurl: return "ic_invertedpage_curl"
            case .kaleidoScope: return "ic_kaleidoscope"
            case .leftRight: return "ic_leftright"
            case .linearBlur: return "ic_linearblur"
            case .luminanceMelt: return "ic_luminancemelt"
            case .morph: return "ic_morph"
            case .mosaic: return "ic_mosaic"
            case .multiplyBlend: return "ic_multiply_blend"
            case .perlin: return "ic_perlin"
            case .pinwheel: return "ic_pinwheel"
            case .pixelize: return "ic_pixelize"
            case .polarFunction: return "ic_polar_function"
            case .polkaDotsCurtain: return "ic_polka..curtain"
            case .powerKaleido: return "powerKaleido"
            case .radial: return "ic_radial_2"
            case .randomNoisex: return "ic_random_noisex"
            case .randomSquares: return "ic_random_squares"
            case .ripple: return "ic_ripple"
            case .rotate: return "ic_rotate"
            case .rotateScaleFade: return "ic_rotatescalefade"
            case .simpleZoom: return "ic_simplezoom"
            case .squaresWire: return "ic_squareswire"
            case .squeeze: return "ic_squeeze"
            case .stereoViewer: return "ic_stereoviewer"
            case .swap: return "ic_swap"
            case .swirl: return "ic_swirl"
            case .tangentMotionBlur: return "ic_tang..motionblur"
            case .topBottom: return "ic_topbottom"
            case .tvStatic: return "ic_tvstatic"
            case .undulatingBurnOut: return "ic_undu.._burn_out"
            case .waterDrop: return "ic_water_drop"
            case .windowSlice: return "ic_window_slice"
            case .windowBlinds: return "ic_window_blinds"
            case .wind: return "ic_wind"
            case .wipeDown: return "ic_wipe_down"
            case .wipeLeft: return "ic_wipe_left"
            case .wipeRight: return "ic_wipe_right"
            case .wipeUp: return "ic_wipe_up"
            case .zoomInCircles: return "ic_zoomIn_circles"
            case .swipeLeft: return "ic_swipe_left"
            case .ZoomLeftWipe: return "ic_zoom_left_wipe"
            case .zoomRightWipe: return "ic_zoom_right_wipe"
            case .coordFormIn: return "ic_coord_formIn"
            case .scaleIn: return "ic_scale_in"
            case .ScaleFade: return "ic_scale_fade"
            case .BiLinear: return "ic_bi_linear"
            case .ConicalAsym: return "ic_conical_asym"
            case .ConicalSym: return "ic_conical_sym"
            case .LinearAawtoothLateral: return "ic_linear_line"
            case .RadialTriLateral: return  "ic_radial"
            case .RadialTriLateralReverse: return "ic_radial_reverse"
            case .Spiral1: return "ic_single_spiral"
            case .Spiral2: return "ic_small_spiral"
            case .Spiral3: return "ic_big_spiral"
            case .Square: return "ic_square"
            case .RotateFade: return "ic_rotate_fade"
            }
        }
    }
}
