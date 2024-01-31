sas off.
lock steering to heading(90, 90).
lock throttle to 1.

when ship:altitude >= (ship:body:atm:height + 500) then {
  lights on.
  wait 0.
  deployPanels().
  wait 0.5.
  extendAntennas().
  wait 0.5.
  deployFairing().
  set throttlePID:SETPOINT to 40.
  print "  Target ETA: " + throttlePID:SETPOINT + " s   " at (0,4).
  wait 0.
}

wait 1.
stage. print "Ignition.".
wait until stage:ready.
stage. print "Liftoff.".

set oldThrust to ship:availableThrust.
wait 0.

when ship:availableThrust < (oldThrust - 10) then {
  wait until stage:ready.
  stage.
  until ship:availablethrust > 0 {
    stage.
  }
  hudText("Staging",
    4, 2, 25, rgb(1, 1, 0.5), false).
  wait 0.
  set oldThrust to ship:availableThrust.
  wait 0.
  preserve.
}


wait until ship:velocity:surface:mag >= 40.
print "Starting GT.".

gravityTurn(80_000).


lock throttle to 0.
wait 0.
unlock steering.
sas on.
wait 0.
set ship:control:pilotmainthrottle to 0.


function gravityTurn{
  parameter targetApo.
  parameter pitchAngle is 85.
  lock steering to heading(90, pitchAngle).

  wait until vAng(ship:facing:vector, heading(90, pitchAngle):vector) <= 0.3.
  print "In position.".
    
  wait until vAng(ship:srfPrograde:vector, ship:facing:vector) <= 0.3.
  clearScreen.
  print "Following the surface Prograde." at (0,0).
  lock steering to srfPrograde.

  set throttlePID to PIDLoop(1.05, 10, 0.03, 0.01, 1).
  
  set throttlePID:SETPOINT to 90.
  set wanted_throttle to 1.
  lock throttle to wanted_throttle.
  
  print "  Target ETA: " + throttlePID:SETPOINT + " s   " at (0,4).

  until ship:altitude >= 36000 {
    print ("--- THROTTLE PID ---") at (0,6).
    set wanted_throttle to throttlePID:UPDATE(time:seconds, ETA:apoapsis).
    print "    Apoapsis: " + round(ship:apoapsis,2) + " m   " at (0,2).
    print "ETA:Apoapsis: " + round(ETA:apoapsis,2) + " s   " at (0,3).
    
    print "    Throttle: " + round(throttle,2) + "   " at (0,7).
    wait 0.
  }
  
  lock steering to Prograde.
  print "Following the orbit Prograde.     " at (0,0).
  set throttlePID:SETPOINT to 80.
  
  print "  Target ETA: " + throttlePID:SETPOINT + " s   " at (0,4).

  until ship:apoapsis >= targetAPO {
    set wanted_throttle to throttlePID:UPDATE(time:seconds, ETA:apoapsis).
    print "    Apoapsis: " + round(ship:apoapsis,2) + " m   " at (0,2).
    print "ETA:Apoapsis: " + round(ETA:apoapsis,2) + " s   " at (0,3).
    
    print "    Throttle: " + round(throttle,2) + "   " at (0,7).
    wait 0.
  }

  //---> NEW SETPOINT: 20 sec to APO
  set throttlePID:SETPOINT to 20.
  print "  Target ETA: " + throttlePID:SETPOINT + " s   " at (0,4).

  until ship:periapsis > 0 or ETA:apoapsis < 10 {
    set wanted_throttle to throttlePID:UPDATE(time:seconds, ETA:apoapsis).
    print "    Apoapsis: " + round(ship:apoapsis,2) + " m   " at (0,2).
    print "ETA:Apoapsis: " + round(ETA:apoapsis,2) + " s   " at (0,3).
    
    print "    Throttle: " + round(throttle,2) + "   " at (0,7).
    wait 0.
  }

  set pitchPID to PIDLoop(1.05, 10, 0.03, -5, 5).
  //---> NEW SETPOINT: 10 sec to APO
  set pitchPID:SETPOINT to 10.

  lock throttle to 0.3.
  clearscreen.

  print "  Target ETA: " + pitchPID:SETPOINT + " s   " at (0,4).
  local oldEcc is ship:orbit:eccentricity.
  wait 0.
  
  until ship:orbit:eccentricity <= 0.00001 or ship:orbit:eccentricity > oldEcc {
    print ("--- PITCH PID ---") at (0,6).
    set wanted_pitch to pitchPID:UPDATE(time:seconds, ETA:apoapsis).
    lock steering to heading(90, wanted_pitch).
    print "    Apoapsis: " + round(ship:apoapsis,2) + " m   " at (0,2).
    print "ETA:Apoapsis: " + round(ETA:apoapsis,2) + " s   " at (0,3).
    print "Eccentricity: " + round(ship:orbit:eccentricity,5) + "   " at (0,4).
    
    print "       Pitch: " + round(wanted_pitch,2) + "°    " at (0,7).
    set oldEcc to ship:orbit:eccentricity.
    if ETA:apoapsis < 0.1 {break.}
    wait 0.
  }
}



function deployPanels{
  panels on.
  hudText("Panels deployed",
    4, 2, 25, rgb(1, 1, 0.5), false).
}

function extendAntennas{
  AG2 on.
  hudText("Antennas extended",
    4, 2, 25, rgb(1, 1, 0.5), false).
}

function deployFairing{
  AG1 on.
  hudText("Fairing deployed",
    4, 2, 25, rgb(1, 1, 0.5), false).
}