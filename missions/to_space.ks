// script to launch a rocket into space with log

print "Basics #27".

sas off.
lock steering to heading(90, 90).
lock throttle to 1.

when ship:altitude >= 36_000 then {
  lock steering to Prograde.
  print "Following the orbit Prograde.".
  logEntry("Following the orbit Prograde.").
  wait 0.
}

when ship:altitude >= (ship:body:atm:height + 500) then {
  lights on.
  wait 0.
  deployPanels().
  wait 0.5.
  extendAntennas().
  wait 0.5.
  deployFairing().
  wait 0.5.
}

wait 1.
stage. print "Ignition.".
logEntry("Ignition").
wait until stage:ready.
stage. print "Liftoff.".
logEntry("Liftoff").

set oldThrust to ship:availableThrust.
wait 0.

when ship:availableThrust < (oldThrust - 10) then {
  wait until stage:ready.
  stage.
  print "Staging".
  logEntry("Staging").
  wait 0.
  set oldThrust to ship:availableThrust.
  wait 0.
  preserve.
}


wait until ship:velocity:surface:mag >= 40.
print "Starting GT.".
logEntry("Starting GT").

lock steering to heading(90, 85).

wait until vAng(ship:facing:vector, heading(90, 85):vector) <= 0.3.
print "In position.".

wait until vAng(ship:srfPrograde:vector, ship:facing:vector) <= 0.3.
print "Following the surface Prograde.".
logEntry("Following the surface Prograde.").
lock steering to srfPrograde.

log "MISSION TIME ; ALTITUDE" to
    "0:/logs/alt_of_" + ship:name + ".csv".

until ship:orbit:apoapsis >= 80_000 {
  log timestamp(missionTime):clock + ";" + round(ship:altitude,0) to
    "0:/logs/alt_of_" + ship:name + ".csv".
  wait 0.1.
}

logEntry("Apoapsis okay.").
lock throttle to 0.
wait 0.
unlock steering.
sas on.
wait 0.
set ship:control:pilotmainthrottle to 0.


function deployPanels{
  panels on.
  logEntry("Panels deployed").
}

function extendAntennas{
  AG2 on.
  logEntry("Antenna extended").
}

function deployFairing{
  AG1 on.
  logEntry("Fairing deployed").
}

function logEntry {
  parameter message.
  log timestamp(missionTime):clock + " - " + message to
    "0:/logs/log_of_" + ship:name + ".txt".
}