// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;


fragment float4 CirclePinchWarpFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float ratio1 = smoothstep(0., 1., progress);

    float2 p = uv*2.-1.;
    float l = length(p) / sqrt(2.);
    float ll = smoothstep(l-0.04, l+0.04, ratio1);
    if (ratio1 == 0.) {
      ll = 0.;
    } else if (ratio1 == 1.) {
      ll = 1.;
    }
    
    float w = 0.3;
    float2 p1 = p*(1.+smoothstep(0., l+w, ratio1));
    float2 p2 = p*smoothstep(l-w, 1., ratio1);
    
    float2 uv1 = p1*0.5+0.5;
    float2 uv2 = p2*0.5+0.5;
    
    float4 video = mix(getFromColor(uv1, fromTexture, ratio1, _fromR), getToColor(uv2, toTexture, ratio1, _toR), ll);

    return float4(video.rgb,1.0);

}
