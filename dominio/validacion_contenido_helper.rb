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

def validar_titulo(titulo, error_titulo_vacio, error_invalido)
  raise error_invalido unless titulo.is_a?(String)
  raise error_titulo_vacio if titulo.empty?
end
