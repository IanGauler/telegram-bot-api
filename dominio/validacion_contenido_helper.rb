FORMATO_DURACION = /\A[1-9]\d*:[0-5]\d\z/
def validar_formato_duracion(duracion, error_validez, error_vacia, error_invalido)
  raise error_invalido unless duracion.is_a?(String)
  raise error_vacia if duracion.empty?
  raise error_validez unless duracion.match?(/\A[1-9]\d*:[0-5]\d\z/)
end
