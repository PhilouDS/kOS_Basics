global function computeVelocity {
  parameter per, apo, shipAlt.
  local bMu is ship:body:mu.
  local bRadius is ship:body:radius.
  local SA is shipAlt + bRadius.
  local RP is bRadius + per.
  local RA is bRadius + apo.
  local SMA is (RP + RA) / 2.

  return sqrt(bMu * (2 / SA - 1 / SMA)).
}

global function hTrans {
  parameter shipAlt, targetAlt.
  local initialVel is 0.
  local finalVel is 0.
  local deltaVneeded is 0.

  set initialVel to computeVelocity(ship:orbit:periapsis, ship:orbit:apoapsis, shipAlt).
  if shipAlt < targetAlt {
    set finalVel to computeVelocity(shipAlt, targetAlt, shipAlt).
  }
  else {
    set finalVel to computeVelocity(targetAlt, shipAlt, shipAlt).
  }

  set deltaVneeded to finalVel - initialVel.

  print "---".
  print "initial vel: " + round(initialVel, 2) + " m/s ".
  print "  final vel: " + round(finalVel, 2) + " m/s ".
  print "    delta-v: " + round(deltaVneeded, 5) + " m/s ".
  print "---".

  return deltaVneeded.
}

global function goToFrom {
  parameter targetAlt.
  parameter fromAlt is "AP".
  local newDV is 0.
  local newNode is node(0,0,0,0).

  if fromAlt = "AP" {
    set newDV to hTrans(ship:orbit:apoapsis, targetAlt).
    set newNode to node(time:seconds + ETA:apoapsis, 0, 0, newDV).
  }
  else {
    set newDV to hTrans(ship:orbit:periapsis, targetAlt).
    set newNode to node(time:seconds + ETA:periapsis, 0, 0, newDV).
  }
  return newNode.
}