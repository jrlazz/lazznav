local MOD_NAME = minetest.get_current_modname();
local MOD_PATH = minetest.get_modpath(MOD_NAME);
local WORLD_PATH = minetest.get_worldpath();

NameOfTheMod=MOD_NAME
PathOfTheMod=MOD_PATH
unstressVol=0.3

lazznav = {};

dofile(MOD_PATH.."/nava.lua");
dofile(MOD_PATH.."/navb.lua");

local playerMesh = "character.b3d";

-- autodetect version of player mesh used by default
do
   if default and default.registered_player_models then
      local haveCharName = false;  -- 'character.*' has priority
      local name = nil;
      local nNames = 0;

      for k in pairs(default.registered_player_models) do
         if string.find(k, "^character\\.[^\\.]+$") then
            if haveCharName then nNames = 2; break; end;
            name = k;
            nNames = 1;
            haveCharName = true;
         elseif not haveCharName then
            name = k;
            nNames = nNames + 1;
         end;
      end;

      if nNames == 1 then playerMesh = name; end;
   end;
end;

function lazznav.setPlayerSkin(player)
   local playerName = player:get_player_name();
   if not playerName or playerName == "" then return; end

   player:set_properties(
      {
         visual = "mesh",
         visual_size = { x = 1, y = 1 },
         mesh = playerMesh,
         textures = { skin }
      });
end
