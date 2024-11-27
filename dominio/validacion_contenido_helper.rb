FORMATO_DURACION = /\A[1-9]\d*:[0-5]\d\z/
def validar_formato_duracion(duracion, error_validez, error_vacia, error_invalido)
  raise error_invalido unless duracion.is_a?(String)
  raise error_vacia if duracion.empty?
  raise error_validez unless duracion.match?(/\A[1-9]\d*:[0-5]\d\z/)
end

FORMATO_ANIO_VALIDO = /\A\d+\z/

def validar_anio(anio)
  raise AnioVacio if anio.is_a?(String) && anio.empty?
  raise AnioInvalido if anio.is_a?(String) && !anio.match?(FORMATO_ANIO_VALIDO)
  raise AnioFueraDeRango if anio.to_i > Time.now.year

  anio.to_i
end

def validar_parametro(parametro, error_parametro_vacio, error_invalido)
  raise error_invalido unless parametro.is_a?(String)
  raise error_parametro_vacio if parametro.empty?
end
