uniform samplerCube cubemap;


  //vec3 color = vec3(textureCube(cubemap, vec3(vertTexCoord,1.0)));
  //gl_FragColor = vec4(vertTexCoord, 0.0, 1.0);
  gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0);
  //gl_FragColor = vec4(color, 1.0);
}