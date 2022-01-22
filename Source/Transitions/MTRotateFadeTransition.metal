//
//  MTRotateFadeTransition.metal
//  MTTransitions
//
//  Created by iMac on 22/01/22.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float2 rotate2D1(float2 uv, float angle){
    float2x2 rm = float2x2(float2(cos(angle), -sin(angle)),
                           float2(sin(angle), cos(angle)));
    return uv * rm;
}

fragment float4 rotateFadeFragment(VertexOut vertexIn [[ stage_in ]],
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
        
    float2 p = fract(rotate2D1(uv - 0.5, progress * PI * 2.0) + 0.5);

    return mix(getFromColor(p, fromTexture, ratio, _fromR),
               getToColor(p, toTexture, ratio, _toR),
      progress);
}


