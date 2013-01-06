require_relative 'countries-list.rb'

# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(options, html_options)
      end

      def state_select(object, method, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(options, html_options)
      end
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, options = nil)
        options = options || {}
        value = options[:value] || :name
        priority_countries = options[:priority_countries] || ["US", "GB", "CA"]

        countries = ::CountrySelectIso::countries.sort{|c1, c2| c1[:name] <=> c2[:name]}

        country_options = ""

        if priority_countries
          country_options += options_for_select(countries
            .select{|c|  !priority_countries.index{|pc| country_matches(c, pc)}.nil?}
            .map{|c| [c[:name], c[value]]}, selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        country_options + options_for_select(countries.map{|c| [c[:name], c[value]]}, selected)
      end

      def state_options_for_select(selected = nil, options = nil)
        options = options || {}
        country = options[:country] || "US"
        value = options[:value] || :full_code
        name = options[:name] || :localized_name
        states = ::CountrySelectIso::states.select{|s| s[:country_iso2] == country}.sort{|s1, s2| s1[name] <=> s2[name]}
        options_for_select(states.map{|s| [s[name], s[value]]})
      end

      def country_matches country, value
        country[:name] == value || country[:iso2] == value || country[:iso3] == value
      end
    end
    
    class InstanceTag
      def to_country_select_tag(options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, options).html_safe,
            options, value
          ), html_options
        )
      end

      def to_state_select_tag(options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            state_options_for_select(value, options).html_safe,
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def country_select(method, options = {}, html_options = {})
        @template.country_select(@object_name, method, options.merge(object: @object), html_options)
      end

      def state_select(method, options = {}, html_options = {})
        @template.state_select(@object_name, method, options.merge(object: @object), html_options)
      end
    end
  end
end
