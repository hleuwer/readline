#include <string.h>
#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <readline/readline.h>
#include <readline/history.h>

#include "lua.h"
#include "lauxlib.h"

#define MYNAME "readline"
#define MYVERSION VERSION

static int rl_readline(lua_State *L)
{
   char *line = readline(luaL_optstring(L, 1, NULL));
   lua_pushstring(L, line);
   if (line != NULL)
      free(line);
   return 1;
}
static int rl_addhistory(lua_State *L)
{
   add_history(luaL_checkstring(L, 1));
   return 0;
}
static int rl_clearhistory(lua_State *L)
{
   clear_history();
   return 0;
}
static const luaL_reg funcs[] = {
   {"readline", rl_readline},
   {"add_history", rl_addhistory},
   {"clear_history", rl_clearhistory},
   {"addhistory", rl_addhistory},
   {"clearhistory", rl_clearhistory},
   {NULL, NULL}
};

LUALIB_API int luaopen_readline(lua_State *L)
{
   luaL_openlib(L, MYNAME, funcs, 0);
   lua_pushliteral(L, "version");
   lua_pushliteral(L, MYVERSION);
   lua_rawset(L, -3);
   lua_pushliteral(L, "_VERSION");
   lua_pushliteral(L, MYVERSION);
   lua_rawset(L, -3);
   using_history();
   return 1;
}
