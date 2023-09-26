// Author: Max Plotnikov
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

#define TIME_MULT   .25
#define IDLE_TIME   .05

#define rnd(p) fract(sin(dot(p, float2(12.9898,78.233))) * 43758.5453123)

fragment float4 GrowingSquaresFragment(VertexOut vertexIn [[ stage_in ]],
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
    
    float2 U=uv, B;
    float p = 1. / 60.;
    U *= 6.;
      
      float iTime = progress * 3.8;
      
      float t = fract(iTime * TIME_MULT),
           mt = ceil(iTime * TIME_MULT),
          cellStartTime = rnd(ceil(U) * mt) * .5 + IDLE_TIME,
            w = .25 + .75* smoothstep(0., .175, t-cellStartTime-.225);

      B =  t < cellStartTime
               ? float2(0)
               : smoothstep(p,0.,abs(fract(U)-.5) - w/2. );
      return mix(getFromColor(uv, fromTexture, ratio, _fromR),getToColor(uv, toTexture, ratio, _toR), B.x*B.y);
}
