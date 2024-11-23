class Recomendaciones
  CANTIDAD_RECOMENDACIONES = 5

  def de_la_semana(dia_actual, repositorio_canciones)
    condicion_de_filtro = FiltroDias.filtro_para_dia(dia_actual)
    repositorio_canciones.top_escuchadas_para_dias(condicion_de_filtro, CANTIDAD_RECOMENDACIONES)
  end
end

class FiltroDias
  def self.filtro_para_dia(dia_actual)
    dia_actual.saturday? || dia_actual.sunday? ? 'IN (0, 6)' : 'NOT IN (0, 6)'
  end
end
