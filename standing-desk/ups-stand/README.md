# ups-stand

## description
I purchased [CyberPower Systems Standby Series UPS (SX550G)](https://www.microcenter.com/product/319826/cyberpower-systems-standby-series-ups-(sx550g))
to go with my [FLEXISPOT Standing Desk 48 x 30 Inches Height Adjustable Desk Electric Sit Stand Desk Home Office Desks Whole Piece Desk Board (Black Frame + Black top,2 Packages)](https://www.amazon.com/gp/product/B07H2W9Y3W/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1)

Because I also purchased the [FlexiSpot Height Adjustable Desk Leg Casters Wheels Set of 4 pcs](https://www.amazon.com/gp/product/B0732QT98V/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1) I wanted to be able to roll my desk around without being tied to a floor-sitting UPS. This mount allows the UPS to travel with the desk.

## attribution
I considered using danielupshaw.com's roundedcube.scad but it was more powerful than I needed.
Instead I used [@thejollygrimreaper](https://www.youtube.com/@thejollygrimreaper)'s [`hull` approach](https://www.youtube.com/watch?v=gKOkJWiTgAY).
In `UPSMount.scad` I have this named as `roundedTile()` and have extended it to use spheres for rounding on all edges in `roundedCube()`.