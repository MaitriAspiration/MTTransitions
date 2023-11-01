//
//  MTVideoTransitionRenderer.swift
//  MTTransitions
//
//  Created by xushuifeng on 2020/3/23.
//

import Foundation
import MetalPetal
import VideoToolbox

public class MTVideoTransitionRenderer: NSObject {
 
    let effect: MTTransition.Effect
    
    private let transition: MTTransition
    
    public init(effect: MTTransition.Effect) {
        self.effect = effect
        self.transition = effect.transition
        super.init()
    }
    
    public func renderPixelBuffer(_ destinationPixelBuffer: CVPixelBuffer,
                                  usingForegroundSourceBuffer foregroundPixelBuffer: CVPixelBuffer,
                                  andBackgroundSourceBuffer backgroundPixelBuffer: CVPixelBuffer,
                                  forTweenFactor tween: Float) {
        
        let foregroundImage = MTIImage(cvPixelBuffer: foregroundPixelBuffer, alphaType: .alphaIsOne)
        let backgroundImage = MTIImage(cvPixelBuffer: backgroundPixelBuffer, alphaType: .alphaIsOne)
        
        transition.inputImage = foregroundImage.oriented(.downMirrored)
        transition.destImage = backgroundImage.oriented(.downMirrored)
        transition.progress = tween

        if effect == .BiLinear {
            transition.imgName = "bilinear-lateral"
        } else if effect == .ConicalAsym {
            transition.imgName = "conical-asym"
        } else if effect == .ConicalSym {
            transition.imgName = "conical-sym"
        } else if effect == .LinearAawtoothLateral {
            transition.imgName = "linear-sawtooth-lateral-4"
        } else if effect == .RadialTriLateral {
            transition.imgName = "radial-tri-lateral-4"
        } else if effect == .RadialTriLateralReverse {
            transition.imgName = "radial-tri-lateral-5"
        } else if effect == .Spiral1 {
            transition.imgName = "spiral-1"
        } else if effect == .Spiral2 {
            transition.imgName = "spiral-2"
        } else if effect == .Spiral3 {
            transition.imgName = "spiral-3"
        } else if effect == .Square {
            transition.imgName = "square"
        }  else if effect == .DispCurious {
            transition.imgName = "disp"
        } else if effect == .DispCurious1 {
            transition.imgName = "disp1"
        }  else if effect == .DispCurious2 {
            transition.imgName = "disp2"
        } else if effect == .DispCurious3 {
            transition.imgName = "disp3"
        } else if effect == .DispCurious4 {
            transition.imgName = "disp4"
        } else if effect == .DispCurious5 {
            transition.imgName = "671-v7"
        } else if effect == .DispCurious6 {
            transition.imgName = "671-v6"
        }  else if effect == .DispCurious7 {
            transition.imgName = "671-v5"
        } else if effect == .DispCurious8 {
            transition.imgName = "671-v3"
        } else if effect == .DispCurious9 {
            transition.imgName = "671-v2"
        } else if effect == .DispCurious10 {
            transition.imgName = "3d-cnoise"
        } else if effect == .DispCurious11 {
            transition.imgName = "cellnoise-00"
        } else if effect == .DispCurious12 {
            transition.imgName = "triangle-making"//"rect-df"
        }

        if let output = transition.outputImage {
            try? MTTransition.context?.render(output, to: destinationPixelBuffer)
        }
    }
}

extension UIImage {
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
        guard let image = cgImage else {
            return nil
        }
        self.init(cgImage: image)
    }
}
