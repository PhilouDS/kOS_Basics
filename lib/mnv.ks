global function exeMnv {
  parameter myNode.
  
  if hasNode {
    set tset to 0.
    lock throttle to tset.

    set max_acc to ship:maxthrust/ship:mass.
    set burn_duration to myNode:deltav:mag/max_acc.

    kuniverse:timewarp:warpto(time:seconds + myNode:ETA - burn_duration/2 - 60).
    wait until kuniverse:timewarp:issettled.

    lock steering to myNode:deltav.
    wait until vAng(ship:facing:vector, myNode:deltaV) < 1.

    wait until myNode:eta <= (burn_duration/2).

    set done to False.
    //initial deltav
    set dv0 to myNode:deltav.
    until done
    {
      set max_acc to ship:maxthrust/ship:mass.
      set tset to min(myNode:deltav:mag/max_acc, 1).
      if vdot(dv0, myNode:deltav) < 0
      {
          print "End burn, remain dv " + round(myNode:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, myNode:deltav),1).
          lock throttle to 0.
          break.
      }
      if myNode:deltav:mag < 0.1
      {
          print "Finalizing burn".
          wait until vdot(dv0, myNode:deltav) < 0.5.

          lock throttle to 0.
          print "End burn".
          set done to True.
      }
    }
  }
  else {
    print("No existing maneuver").
  }

  unlock steering.
  unlock throttle.
  wait 0.
  remove myNode.
  set ship:control:pilotMainThrottle to 0.
}