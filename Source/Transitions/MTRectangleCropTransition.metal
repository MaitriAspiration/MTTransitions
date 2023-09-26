// Author: gre
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 RectangleCropFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float s = pow(2.0 * abs(progress - 0.5), 3.0);
    float2 q = uv.xy / float2(1.0).xy;

    // bottom-left
    float2 bl = step(float2(1.0 - 2.0*abs(progress - 0.5)), q + 0.25);
    
    // top-right
    float2 tr = step(float2(1.0 - 2.0*abs(progress - 0.5)), 1.25 - q);

    float2 dir = 1.0 - bl.x * bl.y * tr.x * tr.y;
    float dist = length(dir);
    
    
    return mix(getFromColor(uv, fromTexture, ratio, _fromR), getToColor(uv, toTexture, ratio, _toR),
               step(s, dist)
               );
}
