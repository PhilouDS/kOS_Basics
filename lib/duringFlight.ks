global function doStage {
  parameter something is "Stage activated".
  stage.
  print something.
}

global function activateChute {
  parameter vSpeed.
  parameter something is "Chute activated".
  wait until verticalSpeed < vSpeed.
  doStage(something).
}

global function testChute {
  parameter waitingTime is 3.
  wait waitingTime.

  if verticalSpeed <> -4 {
    print "Chute not deployed yet.".
    print " ".
  }
  else {
    print "Chute deployed.".
    print "Vertical speed is " + round(verticalSpeed, 2) + " m/s.".
  }
}