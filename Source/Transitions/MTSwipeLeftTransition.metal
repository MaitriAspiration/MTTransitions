//
//  MTSwipeLeftTransition.metal
//  MTTransitions
//
//  Created by iMac on 21/01/22.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;


fragment float4 SwipeLeftFragment(VertexOut vertexIn [[ stage_in ]],
                                texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                constant float & ratio [[ buffer(0) ]],
                                constant float & progress [[ buffer(1) ]],
                                sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    if (1.0 - uv.x > progress) {
        return getFromColor(float2(uv.x + progress, uv.y), fromTexture, ratio, _fromR);
    } else {
        return getToColor(float2(uv.x + progress - 1.0, uv.y), toTexture, ratio, _toR);
    }
}
