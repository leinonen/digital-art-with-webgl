precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform sampler2D u_texture_0;

const float PI = 3.1415926535897932384626433832795;

vec3 checker(vec2 uv)
{
  float checkSize = 8.;
  float fmodResult = mod(floor(checkSize * uv.x) + floor(checkSize * uv.y), 2.0);
  float fin = max(sign(fmodResult), 0.0);
  return vec3(fin, fin, fin);
}

vec3 pattern(vec2 uv, float time) 
{
  float x = mod(time + uv.x, 20.) < 10. ? 1. : 0.;
  float y = mod(time + uv.y, 20.) < 10. ? 1. : 0.;
  return vec3(min(x, y));
}

vec2 displace(vec2 p) 
{
    float offset = u_time * 0.8;
    float amplitude = 0.1;
    float s = .30 + sin(p.x + p.y);
    return p + vec2(
        cos(s * p.y * PI + offset) * amplitude,
        sin(s * p.x * PI + offset) * amplitude
    );
}

void main() 
{
    vec2 p = gl_FragCoord.xy / u_resolution;

    vec3 color1 = pattern(gl_FragCoord.xy, u_time * 110.);
    vec3 color2 = checker(p) * vec3(0.1, 0.5, 0.6);

    vec3 color = mix(color1, color2, 0.85);
    vec2 uv = displace(p);
    color = mix(color, texture2D(u_texture_0, uv).rgb, 0.5);

    gl_FragColor = vec4(color, 1.);
}