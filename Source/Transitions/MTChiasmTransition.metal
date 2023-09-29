//
//  MTFadeInWipeUpTransition.metal
//  MTTransitions
//
//  Created by Nazmul on 04/08/2022.
//

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

float4 transition_part(float2 uv, float progress, texture2d<float, access::sample> fromTexture, texture2d<float, access::sample> toTexture, float _fromR, float _toR, float ratio) {
    
    float a = progress/1.3 + rand(float2(uv.x, progress/1000000.))/5.;
    a = mix(0., a, progress);
    float b = mix(0., a-0.1, progress);
    if (uv.y < 0.5 - a || uv.y > 0.5 + a)
        return getFromColor(uv, fromTexture, ratio, _fromR);
    else if (uv.y < 0.5 - b || uv.y > 0.5 + b)
        return float4(1.);
    else
        return getToColor(uv, toTexture, ratio, _toR);
}

float4 transition_comp(float2 uv, float progress, texture2d<float, access::sample> fromTexture, texture2d<float, access::sample> toTexture, float _fromR, float _toR, float ratio) {
    float4 color = float4(0.);
    float total = 0.0;
    for (float t = 0.0; t <= 40.0; t++) {
        float ofs = progress < .5 ? mix(0., t/400., progress * 2.) :
        mix(t/400., 0., (progress-0.5)*2.);
        float startOfs = progress < .5 ? mix(0., -0.05, progress * 2.) :
        mix(-0.05, 0., (progress-0.5)*2.);
        color += transition_part(float2(uv.x, uv.y + startOfs + ofs), progress, fromTexture, toTexture, _fromR, _toR, ratio);
        total += 1.0;
    }
    float4 val = (color/total);
    return val;
}

fragment float4 ChiasmFragment(VertexOut vertexIn [[ stage_in ]],
                               texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                               texture2d<float, access::sample> toTexture [[ texture(1) ]],
                               constant float & rgbSplit [[ buffer(0) ]],
                               constant float & ratio [[ buffer(1) ]],
                               constant float & progress [[ buffer(2) ]],
                               
                               sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    uv.y = 1.0 - uv.y;
    float _fromR = float(fromTexture.get_width())/float(fromTexture.get_height());
    float _toR = float(toTexture.get_width())/float(toTexture.get_height());
    
    float p = rgbSplit * ((progress < .5) ? (progress * 2.) : (1. - (progress - 0.5) * 2.));
    
    return float4(
                  transition_comp(uv, progress-p, fromTexture, toTexture, _fromR, _toR, ratio).r,
                  transition_comp(uv, progress, fromTexture, toTexture, _fromR, _toR, ratio).g,
                  transition_comp(uv, progress+p, fromTexture, toTexture, _fromR, _toR, ratio).b,
                  1.);
    
}


