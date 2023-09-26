// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

#define GRID_SIZE 20.

float screenIn(float2 uv) { return step(abs(uv.x-0.5), 0.5) * step(abs(uv.y-0.5), 0.5); }
float2x2 rotate(float r) { float c=cos(r),s=sin(r); return float2x2(c,-s,s,c); }
float hash(float v) { return fract(sin(v)*43237.5324); }

fragment float4 DiagonalGlitchFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    const float PI_1 = acos(-1.);

    float ratio1 = smoothstep(0., 1., progress);
    ratio1 = smoothstep(0., 1., ratio1);
    ratio1 = smoothstep(0., 1., ratio1);

    float2 st = uv;
    
    float2 uv3 = st;
    uv3 *= rotate(PI_1/6.);
    
    uv3.y *= GRID_SIZE;
    float2 id = float2(0.);
    id.y = floor(uv3.y);
    uv3.x *= GRID_SIZE*hash(id.y);
    id.x = id.y + floor(uv3.x);
    
    float angle = sign(hash(id.x)*2.-1.);
    float offset = hash(id.x + id.y)+1.414;
    
    float2 uv1 = st;
    float2 uv2 = st + float2(angle * offset * ratio1, 0.)*rotate(-PI_1/6.);

    return screenIn(uv2)<1. ? getToColor(uv1, toTexture, ratio, _toR) : getFromColor(uv2, fromTexture, ratio, _fromR);
}
