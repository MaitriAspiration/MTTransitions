// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

#define DIVISION 20.

float hash1(float v) { return fract(sin(v)*43237.5324); }
float noise(float v) { float f=fract(v), i=floor(v), u=f*f*(3.-2.*f); return mix(hash1(i), hash1(i+1.), u); }

fragment float4 RandomSlideFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float iTime = progress * PI / 2.;
    float ratio1 = sin(iTime);
    
    float2 st = uv;
    float n = DIVISION;
    float thr = noise(1.+8.*floor(st.y*n)/n + ratio1);
    float2 uv3 = st + float2(smoothstep(-thr, thr, ratio1*2.-1.), 0.);
    float2 uv1 = uv3;
    float2 uv2 = uv3-float2(1., 0.);
    return mix(getFromColor(uv1, fromTexture, ratio, _fromR), getToColor(uv2, toTexture, ratio, _toR), ratio1);

}
