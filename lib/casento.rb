# encoding: utf-8
require "uri"
require "ostruct"
require "nokogiri"
require "open-uri"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/hash"
require "active_support/inflector"
require "casento/version"
require "casento/occurrence"

module Casento
  def self.search( opts = {} )
    occurrences = []
    page = 1
    loop do
      page_results = get_page( page, opts )
      break if page_results.blank?
      occurrences += page_results
      page += 1
    end
    occurrences
  end

  def self.get_page( page, opts )
    opts.symbolize_keys!
    # puts "opts: #{opts.inspect}"
    url = "http://researcharchive.calacademy.org/research/entomology/EntInv/index.asp?"
    params = {
      "Page" => page,
      "xAction" => "Search"
    }
    params["Country"] = opts[:country] if opts[:country]
    params["StateProv"] = opts[:state] if opts[:state]
    params["County"] = opts[:county] if opts[:county]
    params["Ord"] = opts[:order] if opts[:order]
    %w(Family Genus Species Subspecies).each do |rank|
      val = opts[rank.to_sym] || opts[rank.downcase.to_sym]
      params[rank] = val if val
    end
    url = "#{url}#{URI.encode_www_form( params )}"
    # puts "opening #{url}"
    headers = %w(
      order
      family
      genus
      species
      subspecies
      country
      state
      county
      url
    )
    occurrences = []
    open( url ) do |response|
      # puts "response: #{response}"
      html = Nokogiri::HTML(response.read)
      html.xpath("//tr[td[@class='tdata']]").each do |tr|
        occ = Occurrence.new
        tr.css("td").each_with_index do |td, i|
          # puts "td: #{td}"
          val = if headers[i] == "url"
            td.at("a")[:href]
          else
            td.inner_text.to_s
          end
          val = val.gsub(/[[:space:]]+$/, "").strip
          next if val.blank?
          next if val =~ /not entered/
          # puts "setting #{headers[i]} to #{val}"
          occ.send("#{headers[i]}=", val)
        end
        occurrences << occ
      end
    end
    occurrences
  end
end
