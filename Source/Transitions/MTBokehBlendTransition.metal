// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

#define S(a,b,c) smoothstep(a,b,c)

// Borrowed from BigWIngs (random 1 -> 4)
float4 N14(float t) {
    return fract(sin(t*float4(123., 104., 145., 24.))*float4(657., 345., 879., 154.));
}

float bokehSpot(float2 uv, float2 id, float decimation, float time)
{
    float accum = 0.0;

    for (float x = -1.0; x <= 1.0; x += 1.0)
    {
        for (float y = -1.0; y <= 1.0; y += 1.0)
        {
            float2 offset = float2(x, y);
            float2 cellId = id + offset;
            float4 rnd = N14(mod(cellId.x, 300.0) * 25.3 + mod(cellId.y, 300.0) * 6.67);

            float2 cellUV = uv - offset + rnd.yz * 0.5;

            float dst = length(cellUV);

            float radSeed = sin(time * 0.02 + rnd.x * 40.0);
            float rad =  (abs(radSeed) - decimation) / (1.0 - decimation);

            float intensity = S(rad, rad - 0.15, dst);

            accum += intensity;
        }
    }

    return accum;
}

// Computes a random layer of bokeh spots
float bokehLayer(float2 uv, float decimation, float time)
{
    float2 id = floor(uv);
    float2 cellUV = (uv - id) - float2(0.5, 0.5) ;

    float intensity = bokehSpot(cellUV, id, decimation, time);

    return intensity;
}


// Computes the bokeh background
float3 bokeh(float2 uv, float time)
{
    //accumulates several layers of bokeh
    float intensity = bokehLayer(uv * 0.2 + float2(time * 0.3, 0.0), 0.9, time) * 0.2;
    //intensity += bokehLayer(uv * 0.8 + vec2(200.0 + iTime * 0.3, 134.0), 0.9) * 0.3;
    intensity += bokehLayer(uv * 0.5 + float2(0.0 + time * 0.3, 334.0), 0.95, time) * 0.15;
    intensity += bokehLayer(uv * 0.1 + float2(time * 0.3, 99.0), 0.95, time) * 0.05;

    float cDist = max(0.0, 1.0 - length(uv) * 0.05);

    intensity = cDist + intensity;

    // Vary color with intensity
    // First color is the blue
    // Second color is the green
    float3 chroma = mix(float3(236.0/255.0, 133.0/255.0, 209.0/255.0), float3(150.0/255.0, 180.0/255.0, 255.0/255.0), uv.y * 0.1 + 0.4 + intensity * 0.35444777);

    return chroma * intensity;
}

fragment float4 BokehBlendFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float2 scaledUV = uv * 10.;

    float3 bg = bokeh(scaledUV, progress * 15.);

    bg.rgb -= scaledUV.y * 0.01;

    float3 col = bg;

    // Gamma correction to make the image warmer
    float gamma = 0.8;
    col.rgb = pow(col.rgb, float3(gamma));
    
    if (progress < 0.5) {
      return mix(getFromColor(uv, fromTexture, ratio, _fromR), float4(col, 1.0), progress * 2.);
    }
    
    return mix(float4(col, 1.0), getToColor(uv, toTexture, ratio, _toR), (progress - 0.5) * 2.);

}
