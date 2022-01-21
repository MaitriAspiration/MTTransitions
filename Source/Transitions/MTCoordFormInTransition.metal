//
//  MTCoordFormInTransition.metal
//  MTTransitions
//
//  Created by iMac on 21/01/22.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 coordFromInFragment(VertexOut vertexIn [[ stage_in ]],
                                texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                constant float & ratio [[ buffer(1) ]],
                                constant float & progress [[ buffer(2) ]],
                                sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());

    float4 coordTo = getToColor(uv, fromTexture, ratio, _fromR);
//    float4 coordFrom = getFromColor(uv, toTexture, ratio, _toR);

    return mix(
      getFromColor(coordTo.rg, fromTexture, ratio, _fromR),
      getToColor(uv, toTexture, ratio, _toR),
      progress
    );
}


