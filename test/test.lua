local rl = require "readline"

local cmd = nil

print(string.format("Testscript for module %q", "readline"))
print(string.format("Type ctrl-c or 'exit' to exit; 'clear' to clear history"))
while cmd ~= "exit" do
   cmd = rl.readline("readline test > ")
   if cmd == "clear" then
      rl.clearhistory()
   elseif cmd == "exit" then
   	  print("command exit: leaving.")
   	  os.exit(0)
   else
	  print(cmd)
      rl.addhistory(cmd)
   end
end