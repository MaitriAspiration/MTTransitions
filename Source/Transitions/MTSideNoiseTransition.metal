// Author: gre
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float randomSideNoise (float2 st) {
    return fract(sin(dot(st.xy,float2(12.9898,78.233)))*43758.5453123);
}

fragment float4 SideNoiseFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float fade = smoothstep(0., 1., progress);
    fade = smoothstep(0., 1., fade);
    fade = smoothstep(0., 1., fade);
    
    float2 texCoords = uv;
    float offset = randomSideNoise(uv) * .7;
    float f = clamp(sin(fade * 3.14159), .0, 1.);
    texCoords.x += offset * f;
    float fader = step(texCoords.x, fade);
    float4 video_a = getFromColor(texCoords, fromTexture, ratio, _fromR);
    float4 video_b = getToColor(texCoords, toTexture, ratio, _toR);
    return mix(video_a, video_b, fader);

}

