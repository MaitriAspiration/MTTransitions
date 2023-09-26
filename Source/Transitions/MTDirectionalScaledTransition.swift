//
//  MTDirectionalTransition.swift
//  MTTransitions
//
//  Created by alexiscn on 2019/1/28.
//

import MetalPetal

public class MTDirectionalScaledTransition: MTTransition {
    
    public var direction: CGPoint = CGPoint(x: 0, y: 1.0)
    public var scale: Float = 0.7

    override var fragmentName: String {
        return "DirectionalScaledFragment"
    }

    override var parameters: [String: Any] {
        return [
            "direction": MTIVector(value: direction),
            "scale": scale
        ]
    }
}
