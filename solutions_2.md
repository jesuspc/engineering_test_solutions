####Question 2####

> Let S be the set of numbers greater than zero and less than 100,000
that are evenly divisible by 19.

_Details about the though process that has been followed to get every result can be found at the inline comments inside galois.rb_

**1. How many numbers are there in S?**

```ruby
    Galois.new(0..100000, 19).size #=> 5263
```

**2. How many numbers in S have a square that ends in a 1?**

```ruby
    Galois.new(0..100000, 19).squares_ending_in(1).size #=> 1053
```

**3. How many numbers in S have a reflection that is also in S? (The reflection of 145 is 541)**

```ruby
    Galois.new(0..100000, 19).with_reflections.size #=> 250
```

**4. How many numbers in S can be multiplied by some other number in S to produce a third number in S?**

```ruby
     Galois.new(0..100000, 19).products_in_set.size #=> 277
```
