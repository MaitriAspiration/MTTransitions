//
//  MTSimpleZoomTransition.swift
//  MTTransitions
//
//  Created by alexiscn on 2019/1/28.
//

public class MTSimpleZoomOutTransition: MTTransition {
    
    public var zoomQuickness: Float = 0.8
    public var fade: Bool = true

    override var fragmentName: String {
        return "SimpleZoomOutFragment"
    }

    override var parameters: [String: Any] {
        return [
            "zoomQuickness": zoomQuickness,
            "fade": fade
        ]
    }
}
