precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform sampler2D u_texture_0;

const float PI = 3.1415926535897932384626433832795;

vec2 screen_uv_center() 
{
    return (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;
}

mat2 rotate(float a) 
{
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

vec2 displace(vec2 p) 
{
    float offset = u_time * 0.8;
    float amplitude = 0.1;
    float s = .30;
    return p + vec2(
        cos(s * p.y * PI + offset) * amplitude,
        sin(s * p.x * PI + offset) * amplitude
    );
}

void main() 
{
    vec2 p = screen_uv_center();
    
    // Uncomment!
    // p *= rotate(u_time * 0.5);

    // Uncomment!
    float zoom = 4.0;
    // float zoom = 2. + 0.5 * (1.0 + sin(u_time * 2.1)) * 4.0;

    vec2 offset = displace(p * zoom);

    vec4 color = vec4(0);
    
    // Uncomment
    // color += vec4(.1, .1, .6, 0);
    color += texture2D(u_texture_0, offset).rgba;

    // Uncomment!
    // float d = length(p);
    // if (d < 0.1) {
    //     color *= vec4(0.1, 0, 1, 0);
    // }
    // if (d > 0.2 && d < 0.3) {
    //     color *= vec4(1, 0, 0, .3);
    // }

    // Uncomment!
    // color *= vec4(1. - length(p*1.6));
    gl_FragColor = vec4(color.rgb, 1.0);
    // gl_FragColor = color;
}