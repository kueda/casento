#encoding: utf-8
module Casento
  class Occurrence < OpenStruct
    def kingdom
      "Animalia"
    end

    def phylum
      "Arthropoda"
    end
    
    def dwc_class
      "Insecta"
    end

    def specificEpithet
      species
    end

    def infraspecificEpithet
      subspecies
    end

    def scientificName
      name
    end

    def state
      super.gsub(/\(state of\)/i, "").strip
    end

    def stateProvince
      state
    end

    %w(
      kingdom
      phylum
      order
      family
      genus
      specificEpithet
      infraspecificEpithet
      scientificName
      stateProvince
    ).each do |m|
      define_method "dwc_#{m}" do
        send(m)
      end
      if m.to_s.underscore != m.to_s
        define_method m.to_s.underscore do
          send(m)
        end
      end
    end

    def name
      [genus, species, subspecies].compact.join(" ").strip
    end

    def species
      super =~ /spp/ ? nil : super      
    end
  end
end
