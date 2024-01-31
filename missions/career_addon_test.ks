set terminal:width to 70.
set terminal:height to 40.
print "BASICS #31".
wait 1.

print "  funds: " + round(ADDONS:CAREER:funds,2).
print "science: " + round(ADDONS:CAREER:science,2).

print " ".
print "---".
print " ".

FROM {set idx to 0.}
until idx = 5
step {set idx to idx + 1.}
do {
  print ADDONS:CAREER:ALLCONTRACTS()[idx]:title + " - " +
    ADDONS:CAREER:ALLCONTRACTS()[idx]:state.
}


print " ".
print "---".
print " ".


FROM {set idx to 0.}
until idx = 5
step {set idx to idx + 1.}
do {
  print ADDONS:CAREER:FACILITIES()[idx]:name + " - " +
    ADDONS:CAREER:FACILITIES()[idx]:upgradecost.
}


print " ".
print "---".
print " ".



FROM {set idx to 0.}
until idx = 5
step {set idx to idx + 1.}
do {
  print ADDONS:CAREER:technodes()[idx]:TITLE + " - " +
    ADDONS:CAREER:technodes()[idx]:STATE + " (" +
    ADDONS:CAREER:technodes()[idx]:SCIENCECOST + ")".
}

// AG1 on.
// wait 1.
// ADDONS:CAREER:CLOSEDIALOGS().
// wait 1.
// AG2 on.
// wait 1.
// ADDONS:CAREER:CLOSEDIALOGS().

// wait 1.

// wait until addons:career:ISRECOVERABLE(ship).
// ADDONS:CAREER:recovervessel(ship).