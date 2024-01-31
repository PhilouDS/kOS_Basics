clearScreen.
wait 1.
lights on.
brakes off.

local mainTarget is LatLng(0.1022222, -74.5683333333).
print "Target acquired...".


// initialisation Vitesse
set wheelThrottlePID to 0.
set speedPID to PIDLoop(0.3, 0.1, 0.1, -1, 1).
set speedPID:setPoint to 25.

lock wheelThrottle to wheelThrottlePID.

// initialisation Direction
set wheelDirection to 0.
set turnPID TO PIDLOOP(0.01,0.001,0.01,-0.005,0.005).
set turnPID:setPoint to 0.

print "Start!".

until ship:velocity:surface:mag > 7 {
    // update velocity:
    set myVelocity to ship:velocity:surface:mag.
    set wheelThrottlePID to speedPID:UPDATE(time:seconds, myVelocity).
    // update direction:
    set myHeading to mainTarget:bearing.
    set wheelDirection to turnPID:UPDATE(TIME:SECONDS,myHeading).
    set ship:control:wheelsteer to wheelDirection.
    print "Distance to target: " + round(mainTarget:distance, 1) + (" m   ") at (0,10).
    print "bearing to target: " + round(mainTarget:bearing, 1) + ("°   ") at (0,11).
    wait 0.1.
}


print "On my way!".
set turnPID TO PIDLOOP(0.01,0.001,0.01,-0.005,0.005).

until mainTarget:distance < 250 {
    // update velocity:
    set myVelocity to ship:velocity:surface:mag.
    set wheelThrottlePID to speedPID:UPDATE(time:seconds, myVelocity).
    // update direction:
    set myHeading to mainTarget:bearing.
    set wheelDirection to turnPID:UPDATE(TIME:SECONDS,myHeading).
    set ship:control:wheelsteer to wheelDirection.
    print "Distance to target: " + round(mainTarget:distance, 1) + (" m   ") at (0,10).
    print "bearing to target: " + round(mainTarget:bearing, 1) + ("°   ") at (0,11).
    print "heading to target: " + round(mainTarget:heading, 1) + ("°   ") at (0,12).
    wait 0.1.
}

print "Less than 250 m.".

set speedPID:setPoint to 10.

until mainTarget:distance < 100 {
    // MaJ vitesse :
    set myVelocity to ship:velocity:surface:mag.
    set wheelThrottlePID to speedPID:UPDATE(time:seconds, myVelocity).
    // MaJ direction :
    set myHeading to mainTarget:bearing.
    set wheelDirection to turnPID:UPDATE(TIME:SECONDS,myHeading).
    set ship:control:wheelsteer to wheelDirection.
    print "Distance to target: " + round(mainTarget:distance, 1) + (" m   ") at (0,10).
    print "bearing to target: " + round(mainTarget:bearing, 1) + ("°   ") at (0,11).
    wait 0.1.
}

print "Less than 100 m.".

set speedPID:setPoint to 3.

until mainTarget:distance < 20 {
    // MaJ vitesse :
    set myVelocity to ship:velocity:surface:mag.
    set wheelThrottlePID to speedPID:UPDATE(time:seconds, myVelocity).
    // MaJ direction :
    set myHeading to mainTarget:bearing.
    set wheelDirection to turnPID:UPDATE(TIME:SECONDS,myHeading).
    set ship:control:wheelsteer to wheelDirection.
    print "Distance to target: " + round(mainTarget:distance, 1) + (" m   ") at (0,10).
    print "bearing to target: " + round(mainTarget:bearing, 1) + ("°   ") at (0,11).
    wait 0.1.
}

lock wheelThrottle to 0.
brakes on.

until ship:velocity:surface:mag < 0.01 {
    print "Distance to target: " + round(mainTarget:distance, 1) + (" m   ") at (0,10).
    print "bearing to target: " + round(mainTarget:bearing, 1) + ("°   ") at (0,11).
}

print "Arrived to destination.".

unlock wheelThrottle.
shutdown.