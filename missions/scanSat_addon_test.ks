clearscreen.
print "BASICS #31".
until brakes {
  print "BIOME:" at (0,2).
  print "  " + addons:scanSat:getBiome(ship:body, ship:geoposition) + "     " at (0,3).
  // same as addons:scanSat:currentBiome().
  print "ELEVATION:" at (0,5).
  print "  " + round(addons:scanSat:elevation(ship:body, ship:geoposition),2) + " m   " at (0,6).
  print "SLOPE:" at (0,8).
  print "  " + addons:scanSat:slope (ship:body,ship:geoposition) at (0,9).

  print "SPEED:" at (0,11).
  print "  " + round(ship:velocity:surface:mag,2) at (0,12).
}
