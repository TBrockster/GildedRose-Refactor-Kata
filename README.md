## GildedRose-Refactoring-Kata

Please note that all my work resides in the Ruby folder.

## Installation

First, clone this repository, then:

cd GildedRose-Refactoring-Kata/ruby

bundle install

run 'rspec' in the command line to see test results and coverage

## Purpose

The purpose of this kata is to refactor existing complicated code into easy-to-change code, while adding new functionality to it. The purpose of the code itself is to manage the inventory of an Inn, which goods that increase and decrease in quality by varying amounts, as their sell-by-date approaches.

## Approach

At first I found this kata quite frustrating, as it begins in a rather messy nest of 'if-else' statements, seemingly designed to be annoying. On the surface it would be rather simple to add an extra if statement to account for conjured items, or to simply delete the whole thing and start from scratch, but the constraint of small refactoring steps helped solidify my direction.

My ideal solution would be for every 'type' of item to have its own class, and on that class are defined two methods, 'update_sell_in' and 'update_quality', that will handle each 'types' specific behaviour, with the gilded rose class simply calling item.update_sell_in and item.update_quality on each object in the input array, but I interpreted the 'no changing the item class' requirement to also prevent circumventing it by making other classes. With this in mind I settled on a somewhat more complex case statement on GildedRose, which handles behaviour for different tiems.

I began by writing tests for 'generic items', and then expanding it out for the special functionalities of various items. A restriction on changing the Item class stopped me considering making new classes for the special items, and it meant that I didn't double the Item class in my tests. 

Since I am used to TDD, I found it strange to be writing tests that should pass immediately, but once I had written all these passing tests to match the described functionality I move the entire 'if-else' block into the else section of a 'case' statement. Then I began to remove sections of the large, original 'if-else block', into the 'when' block of the 'case' statement, doing some minor refactoring as I went, and ensuring that my tests still passed. 

Once the entire 'if-else' statement had been moved into the 'case' statement, I began to restructure the code a bit more, changing the 'update_quality' method into a 'update_inventory' method, and extracting out'update_sell_in' and 'update_quality' methods. I had an internal debate on how to handle 'Sulfuras, Hand of Ragnaros'. Did I give it an exclusion in the 'update_sell_in' and 'update_quality' methods, and call them both just once, or did I call them within each of the other 'when' blocks? Eventually I decided on guard statements, as this also allowed me to remove the "when 'Sulfuras, Hand of Ragnaros'" block, and leaves easy room to add further exceptions in the future. 

Another issue was reducing the cyclomatic complexity of the 'update_quality' method, which lead to backstage passes having their own 'update_backstage_pass_quality' method, and lead to the item_quality_boundary_check method. 
Finally, I debated how to deal with the RuboCop warning for method length on the 'update_quality' method, but ultimately decided that going over 10 LoC is inevitable in some case statements, and anything I did to bring it under that value would make the could less readable, less changeable, and therefore worse.

After this point I finally decided to drop my imaginary requirement to only use the 'item' class, so I decided to instead create a bunch of different item child classes (inheriting from 'item'), for each item type, and define the necessary methods there instead. After this, I created a Default Behaviour module, defining the default functionality of 'update_sell_in' and 'update_quality', and included it in each new child class.

## Operation

Open in a REPL, such as IRB or Pry.

require_relative './lib/gilded_rose.rb'

Create and instance of GildedRose with an inventory of your choosing, EG:

```
items = [
  Item.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20),
  
  Item.new(name = 'Aged Brie', sell_in = 2, quality = 0),
  
  Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 7),
  
  Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80),
  
  Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = -1, quality = 80),
  
  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 15, quality = 20),
  
  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 49),
  
  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 5, quality = 49),
  
  Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)
]

my_gilded_rose = GildedRose.new(items)

my_gilded_rose.update_inventory
```

You will need to use a custom each loop to extract the altered values from the items.
