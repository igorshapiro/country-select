# Country-Select

Forked from https://github.com/purcell/country-select.

Provides a simple helper to get an HTML select list of countries.  The list of countries comes from the ISO 3166 standard.  While it is a relatively neutral source of country names, it will still offend some users.

Users are strongly advised to evaluate the suitability of this list given their user base.

## Installation

Install as a gem using

    gem install country-select-iso

Or put the following in your Gemfile

    gem 'country-select-iso'

## Example
    country_select("user", "country_name")

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

### ISO2 code as value
You can set the value to one of different options:


| symbol | value to be used | Example |
---------------------------------------
| :iso2  | ISO Alpha 2      | US      |
---------------------------------------


    country_select("user", "country", value: :iso2, priority_countries: ["RU"])

```html
<select id="user_country" name="user[country]"><option value="RU">Russia</option><option value="" disabled="disabled">-------------</option>
  <option value="AF">Afghanistan</option>
  <option value="AX">Aland Islands</option>
  <option value="AL">Albania</option>
  <option value="DZ">Algeria</option>
  <option value="AS">American Samoa</option>
  <option value="AD">Andorra</option>
  ...
</select>
```

Countries list source: http://download.geonames.org/export/dump/countryInfo.txt
States list source: http://download.geonames.org/export/dump/admin1CodesASCII.txt

Copyright (c) 2008 Michael Koziarski, 2012 Igor Shapiro released under the MIT license
