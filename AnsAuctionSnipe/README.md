AnS [Auction Snipe] 
===========================
A lightweight addon for WoW auction sniping

Dependecies
=============
Requires AnS

(Optional) Undermine Journal addon for percentage calculations.

(Optional) TSM for percentage calculations.

(Optional) Auctionator addon for percentage calculations.

Features
===============
* To filter out vendor items with unlimited quantities, will require a filter string of: tujdays ~= 252 and using Undermine Journal addon

* Filters must be set before starting a sniping session
* Changes to filters during a running sniping session has no effect.
* To update filters stop and restart the session.

* Pre-built filters for:
    * Herbs
    * Ores
    * Fish
    * Cloth
    * Leather
    * Enchanting
    * Pets
    * Mounts

 * Allows for quick settings of:
    * Max Percent
    * Max Buyout
    * Min iLevel
    * Min Quality
    * CLevel Range
    * Name filter for further refinement

 * Take it to the next level with custom filters, pricing strings, and filter strings


How to Buy & Other Controls
==============
Double click an auction list item, and ba da bing, ba da boom. It will purchase it if it can.

Or set a key binding under ESC -> Bindings -> AnS to buy selected auctions via another button.

(For Advanced Users) There is now a keybinding option to buy the first listed auction item.

CTRL + Left Click allows you to blacklist an item id.

* Want to use the key bindings through TSM macros instead? Use the following functions: /run AuctionSnipe:BuySelected() or /run AuctionSnipe:BuyFirst()


Filter and Percent/Pricing Strings
=========================
A percent/pricing string must end up as a single numerical value

A filter string must end up as a boolean value

Lua operators can be used on strings

```
 >=, ~=, ==, <=, <, >, not, and, or, -, +, *, \
```

Predefined functions for use in strings:

```
first, check, iflte, iflt, ifgte, ifgt, ifeq, ifneq, avg, min, max, mod, abs, ceil, floor, round, random, log, log10, exp, sqrt
```

Predefined Item Variables:

```
vendorsell, percent, ppu, stacksize, buyout, ilevel, quality
```

Predefined TUJ Variables:

```
tujmarket, tujrecent, tujglobalmedian, tujglobalmean, tujage, tujdays, tujstddev, tujglobalstddev
```

Predefined TSM Variables:

```
dbmarket, dbminbuyout, dbhistorical, dbregionmarketavg, dbregionminbuyoutavg, dbregionhistorical, dbregionsaleavg, dbregionsalerate, dbregionsoldperday, dbglobalminbuyoutavg, dbglobalmarketavg, dbglobalhistorical, dbglobalsaleavg, dbglobalsalerate, dbglobalsoldperday
```

Predefined Auctionator Variables:

```
atrvalue
```

Custom VARS
========
Custom variables can now be defined in ESC -> Interface -> Addons -> AnS -> Custom VARS

All the same info regarding filter and percent strings apply to these as well.

Percent Shorthand Now Supported
================================
You can do the following just like TSM:

```
10% dbmarketvalue
```
```
20% dbminbuyout
```

etc..


Filter and Percent/Pricing Strings Update:
========================================
As of version 1.0.4 you can use the following short hand operators: 

lt (less than), gt (greater than), gte (greater than equal), lte (less than equal), eq (equals), neq (not equals).

Quality shorthand: common, uncommon, rare, epic, legendary

As of version 1.0.4 short hand for money is available as such:

```
25g5s10c
```
```
25g10c
```
```
25g
```
```
5s10c
```
```
5s
```
```
10c
```


Using Percent Strings
===========================

Percent strings should always return 1 numerical value.


Example of Percent Strings
================================
avg of tujmarket and tujrecent

```
avg(tujmarket,tujrecent)
```

min of tujmarket and tujrecent

```
min(tujmarket,tujrecent)
```

min of dbmarket, tujmarket, tujrecent, dbregionmarketavg

```
min(dbmarket,tujmarket,tujrecent,dbregionmarketavg)
```

Using custom math in strings
===========
You can use any of the standard lua operators for math such as: * (multiply), \ (divide), + (add), - (subtract)

```
0.25 * min(tujmarket,tujrecent);
```

Using Filter Strings
====================
Filter strings should return a boolean value of true or false.

True means the item is valid and will be displayed.

False the item will not display.

Common Filter String Examples
=====================================
(Shorthand operators are only available in 1.0.4 and above)

Only show auctions less than 50%
------------------------------------
```
percent lt 50
```

Without shorthand
```
percent < 50
```

Only show auctions with a ppu less than equal to 5g
------------------------------------------
```
ppu lte 5g
```

Without shorthand
```
ppu <= 5 * 10000
```

Only show items with ilevel greater than 350
------------------------------------------
```
ilevel gt 350
```

Without shorthand
```
ilevel > 350
```

Only show items with a stacksize of greater than equal to 20
----------------------------------------
```
stacksize gte 20
```

Without shorthand
```
stacksize >= 20
```

Only show items that are rare and above
-----------------------------------------
```
quality gte rare
```

Without shorthand
```
quality >= 4
```

Combining More Than One Examples
===================================
quality common or better and ppu less than equal to 10g
--------------------------------------------
```
quality gte common and ppu lte 10g
```

Without shorthand
```
quality >= 1 and ppu <= 10 * 10000
```

iLevel greater than 350 and percent less than 50
----------------------------------------
```
ilevel gt 350 and percent lt 50
```

Without shorthand
```
ilevel > 350 and percent < 50
```

One or the Other Examples
============================
Only accept items that are less than 1000g or above 5000g ppu
------------------------------------------
```
ppu lt 1000g or ppu gt 5000g
```

Without shorthand
```
ppu < 1000 * 10000 or ppu > 5000 * 10000
```

Only accept items with stacksize 200 or ppu gt 200g and ppu lt 250g
-------------------------------------------------------
```
(stacksize eq 200) or (ppu gt 200g and ppu lt 250g)
```

Without shorthand
```
(stacksize == 200) or (ppu > 200 * 10000 and ppu < 250 * 10000)
```