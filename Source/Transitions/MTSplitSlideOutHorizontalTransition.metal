// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

bool inBoundsMetalSpliOutHorizon (float2 p) {
    const float2 boundMin = float2(0.0, 0.0);
    const float2 boundMax = float2(1.0, 1.0);
    return all(boundMin < p) && all(p < boundMax);
}

fragment float4 SplitSlideOutHorizontalFragment(VertexOut vertexIn [[ stage_in ]],
                                          texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                                          texture2d<float, access::sample> toTexture [[ texture(1) ]],
                                          constant float & reverse [[ buffer(0) ]],
                                          constant float & ratio [[ buffer(1) ]],
                                          constant float & progress [[ buffer(2) ]],
                                          sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float modifier = (uv.y > 0.5 ? 1.0 : -1.0) * (reverse ? -1.0 : 1.0) ;
    float2 p = float2(uv.x + (progress * modifier), uv.y);

    return inBoundsMetalSpliOutHorizon(p) ? getFromColor(p, fromTexture, ratio, _fromR) : getToColor(uv, toTexture, ratio, _toR);
}
