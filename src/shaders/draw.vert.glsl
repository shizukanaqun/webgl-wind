precision mediump float;

attribute float a_index;

uniform sampler2D u_particles;
uniform float u_particles_tex_size;

float decode(const vec2 channels) {
    return dot(channels, vec2(255.0, 255.0 * 255.0)) / (255.0 * 255.0);
}

void main() {
    float x = mod(a_index, u_particles_tex_size);
    float y = floor(a_index / u_particles_tex_size);
    vec4 particle_sample = texture2D(u_particles, vec2(x, y) / u_particles_tex_size);
    vec2 pos = vec2(decode(particle_sample.rg), decode(particle_sample.ba));

    gl_PointSize = 1.0;
    gl_Position = vec4(1.0 - 2.0 * pos, 0, 1);
}