local rl = require "readline"

local cmd = nil

print(string.format("Testscript for module %q", "readline"))
print(string.format("Type ctrl-c to exit; 'clear' to clear history"))
while cmd ~= "exit" do
   cmd = rl.readline("readline test > ")
   print(cmd)
   if cmd == "clear" then 
      rl.clearhistory() 
   else
      rl.addhistory(cmd)
   end
end