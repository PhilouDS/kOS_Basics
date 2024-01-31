global printSpace is "We are in space! \o/".
global spaceAlt is ship:body:atm:height.
global shipApo is ship:orbit:apoapsis.

global function normalVector {
  parameter dir is 1.
  local normVec to dir * vectorCrossProduct(body:position, prograde:vector):normalized.
  return normVec.
}

global function radialVector {
  parameter dir is 1.
  local radVec to dir *  vectorCrossProduct(prograde:vector, normalVector):normalized.
  return radVec.
}