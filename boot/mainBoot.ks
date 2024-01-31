clearScreen.

wait until ship:unpacked.

openTerminal().

runpath("0:/missions/basics27.ks").

global function openTerminal {
  core:part:getModule("kosProcessor"):doEvent("open terminal").
}

global function closeTerminal {
  core:part:getModule("kosProcessor"):doEvent("close terminal").
}