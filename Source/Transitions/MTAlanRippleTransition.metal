// Author: gre
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 AlanRippleFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float freq = 8.0;
    float period = 8.0;
    float speed = 2.0;
    float fade = 4.0;
    float displacement = 0.2;

    float2 U = (uv - float2(0.5)) * 2.;
    float2 T = uv;
    float D = length(U);
    
    float time = progress * 2.5;
    
    if (progress == 0.) {
      return getFromColor(uv, fromTexture, ratio, _fromR);
    } else if (progress == 1.) {
      return getToColor(uv, toTexture, ratio, _toR);
    }
    
    float frame_time = mod(time * speed, period);
    float pixel_time = max(0.0, frame_time - D);

    float wave_height = (cos(pixel_time * freq) + 1.0) / 2.0;
    float wave_scale = (1.0 - min(1.0, pixel_time / fade));
    float frac = wave_height * wave_scale;

    float2 tc = T + ((U / D) * -((sin(pixel_time * freq) / fade) * wave_scale) * displacement);
    
    return mix(
      getFromColor(tc, fromTexture, ratio, _fromR),
      getToColor(tc, toTexture, ratio, _toR),
      1. - frac
    );

}

