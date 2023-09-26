//
//  MTDirectionalEasingTransition.swift
//  MTTransitions
//
//  Created by xu.shuifeng on 2021/2/22.
//

import MetalPetal

public class MTDissolveTransition: MTTransition {
    
    public var uLineWidth: Float = 0.1;
    public var uSpreadClr: MTIColor = MTIColor(red: 1, green: 0, blue: 0, alpha: 1.0);
    public var uHotClr: MTIColor = MTIColor(red: 0.9, green: 0.9, blue: 0.2, alpha: 1.0);

    public var uPow: Float = 5.0;
    public var uIntensity:Float = 1.0;

    override var fragmentName: String {
        return "DissolveEasingFragment"
    }
    
    override var parameters: [String: Any] {
        return [
            "uLineWidth": uLineWidth,
            "uSpreadClr": MTIVector(value: simd_float3(uSpreadClr.red, uSpreadClr.green, uSpreadClr.blue)),
            "uHotClr": MTIVector(value: simd_float3(uHotClr.red, uHotClr.green, uHotClr.blue)),
            "uPow": uPow,
            "uIntensity": uIntensity
        ]
    }
}
