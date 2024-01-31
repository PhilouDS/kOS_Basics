brakes off.
wait 1.
lights on.
wait 1.

lock wheelThrottle to 0.5.
wait 3.
lock wheelThrottle to 1.
wait 3.
lock wheelThrottle to 0.
brakes on.

wait until ship:velocity:surface:mag < 0.1.
wait 1.

brakes off.
lock wheelThrottle to -1.
wait 3.
lock wheelThrottle to 0.
brakes on.

wait until ship:velocity:surface:mag < 0.1.
wait 1.

set ship:control:wheelsteer to 0.5.
wait 3.
set ship:control:wheelsteer to 1.
wait 3.
set ship:control:wheelsteer to -0.5.
wait 3.
set ship:control:wheelsteer to -1.
wait 3.
set ship:control:wheelsteer to 0.