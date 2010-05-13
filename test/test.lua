local rl = require "readline"

local cmd = nil

while cmd ~= "exit" do
   cmd = rl.readline("readline test > ")
   print(cmd)
   if cmd == "clear" then 
      rl.clearhistory() 
   else
      rl.addhistory(cmd)
   end
end