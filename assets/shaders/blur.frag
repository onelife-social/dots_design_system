#include<flutter/runtime_effect.glsl>

precision highp float;

uniform sampler2D uTexture;
uniform float uSigma;
uniform float uWidth;
uniform float uHeight;

out vec4 fragColor;

vec4 blur(vec2 uv,float radius,vec2 resolution){
  vec4 color=vec4(0.);
  float total=0.;
  
  float twoSigmaSq=2.*radius*radius;
  
  // Fixed loop bounds: -4 to 4 for a 11x11 grid
  for (int x = -5; x <= 5; x++) {
    for (int y = -5; y <= 5; y++) {
      vec2 offset = vec2(float(x), float(y));

      // Only include weights inside the blur radius
      if (length(offset) <= radius) {
        float weight = exp(-(dot(offset, offset)) / twoSigmaSq);
        vec2 sampleUV = uv + offset / resolution;
        color += texture(uTexture, sampleUV) * weight;
        total += weight;
      }
    }
  }
  
  return color/total;
}

void main(){
  vec2 resolution=vec2(uWidth,uHeight);
  vec2 currentPos=FlutterFragCoord().xy;
  vec2 uv=currentPos/resolution;
  fragColor=blur(uv,uSigma,resolution);
}