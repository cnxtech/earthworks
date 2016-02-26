module Earthworks
  ##
  # Custom SearchBuilder for EarthWorks that gives larger boost IsWithin
  class SearchBuilder < Geoblacklight::SearchBuilder
    def add_spatial_params(solr_params)
      if blacklight_params[:bbox]
        solr_params[:bq] ||= []
        solr_params[:bq] =
          ["#{Settings.GEOMETRY_FIELD}:\"IsWithin(#{envelope_bounds})\"^300"]
        solr_params[:fq] ||= []
        solr_params[:fq] <<
          "#{Settings.GEOMETRY_FIELD}:\"Intersects(#{envelope_bounds})\""
      end
      solr_params
    rescue Geoblacklight::Exceptions::WrongBoundingBoxFormat
      solr_params
    end
  end
end