# Country-Select

Forked from https://github.com/purcell/country-select.

Provides a simple helper to get an HTML select list of countries.  The list of countries comes from the ISO 3166 standard.  While it is a relatively neutral source of country names, it will still offend some users.

Users are strongly advised to evaluate the suitability of this list given their user base.

## Installation

Install as a gem using

    gem install country-select-iso

Or put the following in your Gemfile

    gem 'country-select-iso'
    
# Using as library
## Countries list
```ruby
CountrySelectIso::countries
```

will return array of hashes with the following keys:
<table>
  <tr>
    <th>Key symbol</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td>:iso2</td>
    <td>ISO Alpha 2 country code</td>
    <td>US</td>
  </tr>
  <tr>
    <td>:iso3</td>
    <td>ISO Alpha 3 country code</td>
    <td>USA</td>
  </tr>
  <tr>
    <td>:name</td>
    <td>Country name</td>
    <td>United States</td>
  </tr>
  <tr>
    <td>:capital</td>
    <td>Capital city name</td>
    <td>Washington</td>
  </tr>
  <tr>
    <td>:top_level_domain</td>
    <td>Top-level internet domain</td>
    <td>.us</td>
  </tr>
  <tr>
    <td>:currency_code</td>
    <td>Currency code</td>
    <td>USD</td>
  </tr>
  <tr>
    <td>:currency_name</td>
    <td>Currency name</td>
    <td>Dollar</td>
  </tr>
  <tr>
    <td>:phone_code</td>
    <td>Phone number country code</td>
    <td>1</td>
  </tr>
  <tr>
    <td>:postal_code_format</td>
    <td>Postal code format</td>
    <td>#####-####</td>
  </tr>
  <tr>
    <td>:postal_code_expr</td>
    <td>Postal coe Regexp</td>
    <td>^\d{5}(-\d{4})?$</td>
  </tr>
  <tr>
    <td>:neighbours_iso2</td>
    <td>Array of neighboring countries ISO2 codes</td>
    <td>['CA','MX','CU']</td>
  </tr>
</table>

## Countries list
```ruby
CountrySelectIso::states
```

will return array of hashes with the following keys:

> TBD

# Using in views

## Example
```ruby
    country_select("user", "country_name")
```

```html
<select id="user_country" name="user[country]">
  <option value="Canada">Canada</option>
  <option value="United Kingdom">United Kingdom</option>
  <option value="United States">United States</option>
  <option value="" disabled="disabled">-------------</option>
  <option value="Afghanistan">Afghanistan</option>
  <option value="Aland Islands">Aland Islands</option>
  <option value="Albania">Albania</option>
  ...
</select>
```

### Options
You can set the value of <option> tag to one of the following, by specifying a :value option:

<table>
    <tr>
    <th>Symbol</th>
    <th>Value to bo used</th>
    <th>Example</th>
    </tr>
    <tr>
    <td>:iso2</td>
    <td>ISO Alpha 2</td>
    <td>US</td>
    </tr>
    <tr>
    <td>:iso3</td>
    <td>ISO Alpha 3</td>
    <td>USA</td>
    </tr>
    <tr>
    <td>:name</td>
    <td>Country name</td>
    <td>United States</td>
    </tr>
</table>

You can also include an array of priority countries that will be shown first. Countries are matched by either iso3, iso2 or country name

```ruby
    country_select("user", "country", value: :iso2, priority_countries: ["RU", "USA", "Albania"])
```

```html
<select id="user_country" name="user[country]">
    <option value="AL">Albania</option>
    <option value="RU">Russia</option>
    <option value="US">United States</option>
    <option value="" disabled="disabled">-------------</option>
    <option value="AF">Afghanistan</option>
    <option value="AX">Aland Islands</option>
    <option value="AL">Albania</option>
    ...
</select>
```

Countries list source: http://download.geonames.org/export/dump/countryInfo.txt

States list source: http://download.geonames.org/export/dump/admin1CodesASCII.txt

Copyright (c) 2008 Michael Koziarski, 2012 Igor Shapiro released under the MIT license
