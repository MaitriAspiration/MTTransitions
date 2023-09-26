//
//  MTDirectionalEasingTransition.swift
//  MTTransitions
//
//  Created by xu.shuifeng on 2021/2/22.
//

import MetalPetal

public class MTSplitSlideInOutVerticalTransition: MTTransition {
    public var reverse = false

    override var fragmentName: String {
        return "SplitSlideInOutVerticalFragment"
    }
    
    override var parameters: [String: Any] {
        return [
            "reverse": reverse
        ]
    }

}
