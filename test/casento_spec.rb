#encoding: utf-8
require 'test_helper'

describe Casento do
  it "should have a version" do
    refute_nil ::Casento::VERSION
  end

  describe "search" do
    occurrence = Casento.search(
      genus: "Catocala",
      species: "andromache",
      subspecies: "wellsi",
      state: "California"
    ).first
    it "should return objects that respond to name" do
      refute_nil occurrence.name
    end
    it "should have a URL" do
      occurrence.url.must_equal "http://researcharchive.calacademy.org/research/entomology/EntInv/index.asp?xAction=getrec&close=true&AllStuffID=495703"
    end
    it "should return results from multiple pages" do
      results = Casento.search( genus: "Exoprosopa", state: "California" )
      results.size.must_be :>, 20
    end
    describe "DwC-compliant field names work for" do
      it "scientificName" do
        occurrence.scientificName.must_equal "Catocala andromache wellsi"
      end
      it "kingdom" do
        occurrence.kingdom.must_equal "Animalia"
      end
      it "phylum" do
        occurrence.phylum.must_equal "Arthropoda"
      end
      it "dwc_class" do
        occurrence.dwc_class.must_equal "Insecta"
      end
      it "order" do
        occurrence.order.must_equal "Lepidoptera"
      end
      it "family" do
        occurrence.family.must_equal "Noctuidae"
      end
      it "genus" do
        occurrence.genus.must_equal "Catocala"
      end
      it "specificEpithet" do
        occurrence.specificEpithet.must_equal "andromache"
      end
      it "infraspecificEpithet" do
        occurrence.infraspecificEpithet.must_equal "wellsi"
      end
      it "country" do
        occurrence.country.must_equal "U.S.A."
      end
      it "stateProvince" do
        occurrence.stateProvince.must_equal "California"
      end
      it "county" do
        occurrence.county.must_equal "Calaveras"
      end
    end
  end
end
