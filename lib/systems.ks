global scienceModule is "ModuleScienceExperiment".

global function mysteryGoo {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(scienceModule) {
      PRT:getModule(scienceModule):doEvent("observe mystery goo").
    }
  }
  print "Mystery Goo observed".
}

global function crewReport {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(scienceModule) {
      PRT:getModule(scienceModule):doEvent("crew report").
    }
  }
}

global function magneto {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(scienceModule) {
      PRT:getModule(scienceModule):doEvent("run magnetometer report").
    }
  }
}

global antennaModule is "ModuleDeployableAntenna".
global deployAntennaEvent is "extend antenna".
global retractAntennaEvent is "retract antenna".

global function extendAntennas {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(antennaModule) {
      PRT:getModule(antennaModule):doEvent(deployAntennaEvent).
    }
  }
}

global solarModule is "ModuleDeployableSolarPanel".
global deployPanelsEvent is "extend solar panel".
global retractPanelsEvent is "retract solar panel".

global function retractAntennas {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(antennaModule) {
      PRT:getModule(antennaModule):doEvent(retractAntennaEvent).
    }
  }
}


global fairingModule is "ModuleProceduralFairing".
global deployFairingEvent is "deploy".

global function extendPanels {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(solarModule) {
      PRT:getModule(solarModule):doEvent(deployPanelsEvent).
    }
  }
}

global function retractPanels {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(solarModule) {
      PRT:getModule(solarModule):doEvent(retractPanelsEvent).
    }
  }
}

global function deployFairing {
  parameter tag.
  for PRT in ship:partsTagged(tag) {
    if PRT:hasModule(fairingModule) {
      PRT:getModule(fairingModule):doEvent(deployFairingEvent).
    }
  }
}
