module CountrySelectIso
  def self.load_countries_from file_name
    File.read(file_name).split("\n")
      .select{|l| l =~ /^\#/ ? false : true}
      .map{|l| l.split("\t")}
      .map {|p|
        # #  Field               Example
        # ---------------------------------------------
        # 0  ISO                 US
        # 1  ISO3                USA  
        # 2  ISO-Numeric         840
        # 3  fips                US
        # 4  Country             United States
        # 5  Capital             Washington
        # 6  Area(in sq km)      9629091
        # 7  Population          310232863
        # 8  Continent           NA
        # 9  tld                 .us
        # 10 CurrencyCode        USD
        # 11 CurrencyName        Dollar
        # 12 Phone               1
        # 13 Postal Code Format  #####-####
        # 14 Postal Code Regex   ^\d{5}(-\d{4})?$
        # 15 Languages           en-US,es-US,haw,fr
        # 16 geonameid           6252001
        # 17 neighbours          CA,MX,CU
        # 18 EquivalentFipsCode
        {
          iso2: p[0],
          iso3: p[1],
          iso_num: p[2],
          name: p[4],
          capital: p[5],
          continent: p[8],
          top_level_domain: p[9],
          currency_code: p[10],
          currency_name: p[11],
          phone_code: p[12],
          postal_code_format: p[13],
          postal_code_epxr: Regexp.new(p[14]),
          languages: (p[15] || '').split(','),
          neighbours_iso2: (p[17] || '').split(',')
        }
      }
  end

  def self.load_states_from file_name
    File.read(file_name).split("\n")
      .select{|l| l =~ /^\#/ ? false : true}
      .map{|l| l.split("\t")}
      .map {|p|
        # AD.06  Parròquia de Sant Julià de Lòria  Parroquia de Sant Julia de Loria  3039162
        code_parts = p[0].split('.')
        {
          country_code: code_parts[0],
          state_code: code_parts[1],
          full_code: p[0],
          localized_name: p[1],
          name: p[2],
          something_unknown: p[3]
        }
      }
  end

  def self.countries  
    @@countries ||= load_countries_from(File.join(File.dirname(__FILE__), "../data/countries.txt"))
  end

  def self.states
    @@states ||= load_states_from(File.join(File.dirname(__FILE__), '../data/states.txt'))
  end
end