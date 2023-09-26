//
//  MTRippleTransition.swift
//  MTTransitions
//
//  Created by alexiscn on 2019/1/28.
//
import MetalPetal

public class MTRotateScaleVanishReverseTransition: MTTransition {
    public var FadeInSecond: Bool = true
    public var ReverseEffect: Bool = true
    public var ReverseRotation: Bool = false

    override var fragmentName: String {
        return "RotateScaleVanishReverseFragment"
    }

    override var parameters: [String: Any] {
        return [
            "FadeInSecond": FadeInSecond,
            "ReverseEffect": ReverseEffect,
            "ReverseRotation": ReverseRotation
        ]
    }
}
