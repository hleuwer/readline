#include <string.h>
#include <stdio.h>
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

#if LUA_VERSION_NUM > 501
static const luaL_Reg funcs[] = {
#else
static const luaL_reg funcs[] = {
#endif
   {"readline", rl_readline},
   {"add_history", rl_addhistory},
   {"clear_history", rl_clearhistory},
   {"addhistory", rl_addhistory},
   {"clearhistory", rl_clearhistory},
   {NULL, NULL}
};

LUALIB_API int luaopen_readline(lua_State *L)
{
#if LUA_VERSION_NUM > 501
  luaL_newlib(L, funcs);     /* mt */
  lua_pushvalue(L, -1);      /* mt, mt */
  lua_setglobal(L, MYNAME);  /* mt */
#else
   luaL_openlib(L, MYNAME, funcs, 0);
#endif
   lua_pushliteral(L, "version");  /* mt, 'version' */
   lua_pushliteral(L, MYVERSION);  /* mt, 'version', VERS */
   lua_rawset(L, -3);              /* mt */
   lua_pushliteral(L, "_VERSION");
   lua_pushliteral(L, MYVERSION);
   lua_rawset(L, -3);
   using_history();
   return 1;
}
