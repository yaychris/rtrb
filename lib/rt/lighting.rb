def lighting(material, light, point, eye_v, normal_v)
  # Mix material and light color
  color = material.color * light.intensity

  light_v = (light.position - point).normalize
  light_dot_normal = light_v.dot(normal_v)

  ambient = color * material.ambient
  diffuse = Color.black
  specular = Color.black

  if light_dot_normal >= 0
    diffuse = color * material.diffuse * light_dot_normal

    reflect_vector = (-light_v).reflect(normal_v)
    reflect_dot_eye = reflect_vector.dot(eye_v)

    if reflect_dot_eye > 0
      factor = reflect_dot_eye ** material.shininess

      specular = light.intensity * material.specular * factor
    end
  end

  ambient + diffuse + specular
end
