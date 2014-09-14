```ruby
class Country < ActiveRecord::Base
  has_many :cities
end

class City < ActiveRecord::Base
  belongs_to :country
  has_many :bars
end

class Bar < ActiveRecord::Base
  belongs_to :city
end
```

*1. How would you (in a controller method) assign to @country the Country named ‘France’?*

```ruby
@country = Country.find_by name: 'France'
```

*2. How would you assign to @cities an Array of all the cities in France?*

```ruby
@cities = Country.find_by(name: 'France').cities
```

*3. How would you assign to @bars an Array of all the bars in France?*

```ruby
@bars = Bar.joins(city: :country).where countries: { name: "France" }
```

*4. How would you assign to @directory an Array of the names of all the bars in France, sorted?*

```ruby
@bars = Bar.joins(city: :country).where(countries: { name: "France" }).order :name
@directory = @bars.map(&:name)
```

*5. Do any of the above answer change if there are 400 cities?*

No.

*6. How about if there are 20,000 bars?*

No.
