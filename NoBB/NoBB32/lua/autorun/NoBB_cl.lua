if SERVER then return end
util.PrecacheSound("vo/npc/male01/hacks01.wav")
util.PrecacheSound("siege/big_explosion.wav")
local KR30CMD = false
local KR30SVC = false
local KR30HTS = false
local KR30MWF = false
local KR30AIM = false
local KR30AIM2 = false
local KR30FAP = false
local KR30BB1 = false
local KR30FCV = false
local EVERYTIME = 35
local SPAWNTIME = 45
local LOLKEY = "aawwwwgrrglgrrrrgllgrrgll"

local NOBBVER = 32
local DEBUG = false --false

--[[
=====NoBB SCRIPT, CLIENTSIDE=====

Version NOBBVER

If you can read this, fuck you. This script was not disigned to stop advanced users, only those who dl their aimbot from gmod.org.
(Note that aimbots, namehacks and exploits are still against the rules, even if this script doesn't detect it)
If you actually *did* find this, add -=[UH]=- HeX on steam (/id/MFSiNC) or join gmod.game-host.org:27015.

Got any ideas how to make this better? 
]]

--fucking U89
--CreateClientConVar("setinfo","One-Man Cheeseburger Apocalypse",false, false)


local BadFiles = {}
local BadFiles = {
	"autorun/asb_module_bot.lua",
	"autorun/client/asb_module_bot.lua",
	"vgui/scriptenforcer.lua",
	"menu_plugins/scriptenforcer.lua",
	"menu_plugins/faphack.lua",
	"menu_plugins/gmcl_luamd5.lua",
	"menu_plugins/sethhack.lua",
	"menu_plugins/gm_forceconvar.lua",
	"menu_plugins/abc_panel.lua",
	"menu_plugins/selfpwn.lua",
	"menu_plugins/testbot-vgui.lua",
	"autorun/hax.lua",
	"autorun/client/hax.lua",
	"bbot.lua",
	"autorun/bbot.lua",
	"autorun/client/bbot.lua",
	"autorun/Adv.Name.lua",
	"autorun/client/Adv.Name.lua",
	"autorun/sethhack.lua",
	"autorun/client/sethhack.lua",
	"autorun/client/name_new.lua",
	"autorun/name_new.lua",
	"vgui/gmcl_luamd5.lua",
	"vgui/sethhack.lua",
	"vgui/gm_forceconvar.lua",
	"autorun/gm_forceconvar.lua",
	"autorun/client/gm_forceconvar.lua",
	"antiread.lua",
	"autorun/antiread.lua",
	"autorun/client/antiread.lua",
	"autorun/lua_run_cl2.lua",
	"autorun/client/lua_run_cl2.lua",
	"autorun/client/spamhax.lua",
	"autorun/spamhax.lua",
	"autorun/sv_cheats_bypass.lua",
	"autorun/client/sv_cheats_bypass.lua",
	"autorun/client/azubot.lua",
	"autorun/azubot.lua",
	"autorun/client/cctv.lua",
	"autorun/cctv.lua",
	"autorun/client/I_laik_being_dum.lua",
	"autorun/I_laik_being_dum.lua",
	"hai.lua",
	"autorun/client/hai.lua",
	"autorun/hai.lua",
	"vgui/abc_panel.lua",
	"autorun/keypad_cracker.lua",
	"autorun/keypadcracker_menu.lua",
	"autorun/client/keypad_cracker.lua",
	"autorun/client/keypadcracker_menu.lua",
	"autorun/client/bunnyhop.lua",
	"autorun/bunnyhop.lua",
	"autorun/client/bhop.lua",
	"autorun/bhop.lua",
	"inscript_plugins/ingamename_plugin.lua",
	"autorun/client/abestrollingscript.lua",
	"autorun/abestrollingscript.lua",
	"autorun/client/aimbot.lua",
	"autorun/aimbot.lua",
	"autorun/waroftheservers.lua",
	"autorun/client/waroftheservers.lua",
	"autorun/selfpwn.lua",
	"autorun/client/selfpwn.lua",
	"vgui/selfpwn.lua",
	"autorun/client/speedhack.lua",
	"autorun/speedhack.lua",
	"autorun/client/ShootHack.lua",
	"autorun/ShootHack.lua",
	"autorun/client/asb.lua",
	"autorun/asb.lua",
	"autorun/client/mawbot.lua",
	"autorun/mawbot.lua",
	"vgui/testbot-vgui.lua",
	"autorun/client/jetbot.lua",
	"autorun/jetbot.lua",
	"autorun/testbot-autorun.lua",
	"autorun/client/[gzf]aimbot108.lua",
	"autorun/client/nbot.lua",
	"autorun/client/jetboombot.lua",
	"autorun/client/module_bot.lua",
	"autorun/client/_TEMPLATE.lua",
	"autorun/client/asb_base.lua",
	"autorun/client/[GzF]AimBot.lua",
	"autorun/client/A-Hack.lua",
	"autorun/client/AutoAim.lua",
	"autorun/client/MawBot.lua",
	"autorun/client/tacobot.lua",
	"autorun/[gzf]aimbot108.lua",
	"autorun/nbot.lua",
	"autorun/jetboombot.lua",
	"autorun/module_bot.lua",
	"autorun/_TEMPLATE.lua",
	"autorun/asb_base.lua",
	"autorun/[GzF]AimBot.lua",
	"autorun/A-Hack.lua",
	"autorun/AutoAim.lua",
	"autorun/MawBot.lua",
	"autorun/tacobot.lua",
	"autorun/client/testbot-real.lua",
	"autorun/client/fuckoff.lua",
	"autorun/fuckoff.lua",
	"autorun/client/SlobBot.lua",
	"autorun/SlobBot.lua",
	"autorun/stuff/BaconBot.lua",
	"autorun/BaconBot.lua",
	"autorun/client/BaconBot.lua",
	"autorun/Adv.Name.lua",
	"autorun/client/Adv.Name.lua",
	"autorun/namescript.lua",
	"autorun/client/namescript.lua",
	"autorun/entinfo.lua.lua",
	"autorun/client/entinfo.lua.lua",
	"autorun/entinfo.lua",
	"autorun/client/entinfo.lua",
	"autorun/randomname.lua",
	"autorun/client/randomname.lua",
	"autorun/randomname.lua",
	"autorun/client/randomname.lua",
	"autorun/SlobBot.old",
	"autorun/client/SlobBot.old",
	"autorun/leetbot.lua",
	"autorun/client/leetbot.lua",	
	"autorun/elebot.lua",
	"autorun/client/elebot.lua",
	"FapHack/faphack.lua",
	"autorun/FapHack/faphack.lua",
	"autorun/client/faphack.lua",
	"autorun/faphack.lua",
	"includes/enum/faphack.lua",
	"includes/modules/gmcl_localcommand.dll",
	"includes/modules/gm_forceconvar.dll",
	"includes/modules/gm_funcsolver.dll",
	"gm_funcsolver.dll",
	"includes/modules/gm_se2.dll",
	"includes/modules/gm_concmd.dll",
	"includes/modules/gm_secret.dll",
	"includes/modules/gm_testbot.dll",
	"includes/modules/gmcl_decz.dll",
	"includes/modules/gm_include.dll",
	"includes/modules/gm_luamd5.dll",
	"includes/modules/gmcl_luamd5.dll",
	"includes/modules/gm_gmodeworld.dll",
	"includes/modules/gm_bindkey.dll",
	"includes/modules/gmcl_unblock.dll",
	"includes/modules/gm_sethhack.dll",
	"includes/modules/gm_bbot.dll",
	"includes/modules/gmcl_deco.dll",
	"includes/modules/gm_INetChannel.dll",
	"includes/modules/gm_cmd.dll",
	"includes/modules/gmsh_rcon.dll",
	"includes/modules/gm_scriptenforcer.dll",
	"includes/modules/gm_netchannel.dll"
}



local BadCmds = {}
local BadCmds = {
	"lua_openscript_cl2",
	"raidbot_predictcheck",
	"aa_enabled",
	"BMaimbot",
	"+BMaimbot",
	"aimbot_headshots_on",
	"CBon_Reload_Script",
	"+CBon_menu",
	"ah_chatspammer",
	"ah_spammer",
	"ah_reload",
	"+ah_menu",
	"+nbot_options",
	"name",
	"sm_fexec",
	"GAT_RandomName",
	"name_menu",
	"namechanger_on",
	"cl_name",
	"+wots_toggleimmunity",
	"send_file",
	"Bacon_Reload_Script",
	"fap_reload",
	"download_file",
	"upload_file",
	"plugin_load",
	"sethhack_load",
	"st_jumpspam",
	"force_cvar",
	"teabag_interval",
	"cl_docrash",
	"_fap_initshit",
	"SE_AddFile",
	"SE_RemoveFile",
	"SE_LoadScripts",
	"+namechanger",
	"RandomNCOn",
	"BlankNCON",
	"PsaySpamOn",
	"GayOn",
	"RatingSpammerOn",
	"+jbf_scan",
	"kennykill",
	"kenny_team",
	"kenny_bodyshots",
	"+kenny",
	"kenny_tagasshole",
	"kenny_addhit",
	"Kenny_noclip",
	"bacon_toggle",
	"Bacon_EntTriggerBot",
	"Bacon_Reload_Script",
	"+wots_spinhack",
	"wots_spinhack",
	"wire_button_model",
	"lol_togglestick",
	"lol_name",
	"lol_copy",
	"lol_fuckthis",
	"lol_barrel",
	"lol_idk",
	"lol_setchat",
	"lol_chat",
	"lol_help",
	"lol_admins",
	"lol_adminalert",
	"lol_hud",
	"lol_cancel",
	"lol_aim",
	"lol_hair",
	"lol_headshot",
	"lol_teamshot",
	"wots_namecracker_menu",
	"wots_namecracker_on",
	"wots_namecracker_off",
	"wots_crash",
	"wots_lag_on",
	"wots_lag_off",
	"speedhack_speed",
	"SetCV",
	"+wowspeed",
	"+gofast",
	"+goslow",
	"va_reload",
	"JBF_off",
	"JBF_on",
	"JBF_headshots_off",
	"JBF_headshots_on",
	"JBF_enemysonly_on",
	"JBF_enemysonly_off",
	"JBF_playersonly_on",
	"JBF_playersonly_off",
	"_JBF_lagcompensation",
	"JBF_lagcompensation",
	"JBF_suicidehealth",
	"JBF_offset",
	"+BUTTFUCK",
	"entx_spazon",
	"entx_spazoff",
	"entx_setvalue",
	"+buttfuck",
	"Fap_Menu",
	"fap_aim_toggle",
	"fap_reload",
	"fap_aim_enabled",
	"fap_aim_friendlyfire",
	"fap_aim_targetnpcs",
	"fap_aim_autofire",
	"fap_aim_autoreload",
	"fap_aim_bonemode",
	"fap_aim_targetfriends",
	"fap_aim_targetsteamfriends",
	"fap_aim_targetmode",
	"fap_aim_nospread",
	"fap_aim_maxdistance",
	"fap_aim_targetadmins",
	"fap_aim_antisnap",
	"fap_aim_norecoil",
	"fap_aim_antisnapspeed",
	"niggeron",
	"niggerff",
	"niggerfl",
	"niggersz",
	"niggernpc",
	"niggerw",
	"niggeri",
	"niggershd",
	"niggermxsh",
	"niggershit",
	"niggersd",
	"NameGenDerma",
	"+elebot",
	"+leetbot",
	"elebot_offset",
	"leetbot_offset",
	"elebot_minview",
	"leetbot_minview",
	"elebot_maxview",
	"leetbot_maxview",
	"elebot_boxsize",
	"leetbot_boxsize",
	"elebot_simplecolors",
	"leetbot_simplecolors",
	"elebot_targetteam",
	"leetbot_targetteam",
	"elebot_showadmin",
	"leetbot_showadmin",
	"elebot_filledbox",
	"leetbot_filledbox",
	"wots_attack",
	"+wots_menu",
	"wots_menu",
	"wots_megaspam",
	"wots_namegen_on",
	"wots_namegen_off",
	"name_change",
	"name_changer",
	"+name_changer",
	"+Bacon_Menu",
	"+BaconToggle",
	"BaconToggle",
	"Bacon_triggerbot_toggle",
	"+Bacon_triggerbot_toggle",
	"Bacon_FF_Toggle",
	"aimbot_scan",
	"+aimbot_scan",
	"entx_spazon",
	"entx_spazoff",
	"_aimbot",
	"_aimbot_headshots",
	"aimbot_offset",
	"entx_run1",
	"entx_run2",
	"entx_run3",
	"entx_run4",
	"entx_traceget",
	"entx_camenable",
	"+slobpos",
	"Bacon_Trigger_Bot",
	"+Bacon_Trigger_Bot",
	"Bacon_Ignore_SteamFriends",
	"Bacon_Mode",
	"gzfaimbot_reload",
	"gzfaimbot_toggle",
	"+gzfaimbot",
	"gzfaimbot",
	"gzfaimbot_menu",
	"at_autoaim_on",
	"at_autoaim_off",
	"at_changer_on",
	"at_changer_off",
	"at_norecoil_on",
	"at_norecoil_off",
	"at_menu",
	"at_autoshoot_on",
	"at_autoshoot_off",
	"aa_reload",
	"aa_toggle",
	"+aa",
	"aa_menu",
	"+Mawpos",
	"+nBot",
	"+nbot_Options",
	"nbot_Options",
	"aimbot_on",
	"aimbot_hitbox",
	"aimbot_target_teamates",
	"aimbot_target_closest",
	"aimbot_target_clear",
	"+asb_bot",
	"asb_bot",
	"asb_options",
	"+asb",
	"asb",
	"asb_unload",
	"asb_reload",
	"asb_shoot",
	"+entinfo",
	"entinfo_target",
	"asb_shoot",
	"asb_nospread",
	"asb_players",
	"entinfo_targetplayer"
}



local BadData = {}
local BadData = {
	"cmdallow/cmddeny.txt",
	"cmdallow/cmdallow.txt",
	"db_steamid_ip.txt",
	"bacon_botlist.txt",
	"faphack_entities.txt",
	"faphack_friends.txt",
	"theinit3sx3.txt",
	"x4xq054.txt",
	"lv9d3c.txt",
	"youvirus.txt",
	"5p1r1tw41k.txt",
	"B0unc3.txt",
	"d4h3sp.txt",
	"d4h41m.txt"
}



local BadBins = {}
local BadBins = {
	"../addons/sourcenginesuck_serverowner.vdf",
	"../sourcenginesuck_serverowner.vdf",
	"../bin/sourcenginesuck_serverowner.vdf",
	"../../bin/sourcenginesuck_serverowner.vdf",
	"../../sourcenginesuck_serverowner.vdf"
}

if DEBUG then
	SPAWNTIME = 3
	EVERYTIME = 4
end

local function KickMe(key)
	if LocalPlayer() and LocalPlayer():IsValid() then
		RunConsoleCommand("ulx_giveranks", key, LOLKEY)
	end
end

function RunString(str)
	return false
end 

timer.Simple( SPAWNTIME, function( )
	if LocalPlayer() and LocalPlayer():IsValid() then
		
		for k, v in pairs( BadBins ) do
			if #file.Find(v)>=1 then --blocked in 3, 2..
				KickMe("Bin=".. v)
			end
		end
		for k, v in pairs( BadFiles ) do
			if #file.FindInLua(v)>=1 then
				KickMe("Module=".. v)
			end
		end
		timer.Simple( 2, function( )
			for k, v in pairs( BadCmds ) do
				concommand.Add(v, function(ply,cmd,args) KickMe("Key - ".. cmd) end)
			end
		end)
		timer.Simple( 2.5, function( )
			for k, v in pairs( BadData ) do
				if #file.Find(v)>=1 then
					KickMe("Datafile=data/".. v)
				end
			end
		end)
		
		
		if GetConVar("cl_cmdrate"):GetInt() !=30 then
			KickMe("TS=cl_cmdrate=".. GetConVar("cl_cmdrate"):GetInt())
		end
		if GetConVar("host_timescale"):GetInt() !=1 then
			KickMe("TS=host_timescale=".. GetConVar("host_timescale"):GetInt())
		end
		if GetConVar("sv_cheats"):GetInt() !=0 then
			KickMe("TS=sv_cheats=".. GetConVar("sv_cheats"):GetInt())
		end
		if GetConVar("mat_wireframe"):GetInt() !=0 then
			KickMe("TS=mat_wireframe=".. GetConVar("mat_wireframe"):GetInt())
		end
		
		
		if (SlobMegaAIM or GetSlobBotTarget or AntiBanOn or BotVisible) then
			KickMe("TS=SlobBot")
		elseif (FapHack) then
			KickMe("TS=FapHack")
		elseif (speeeeed) then
			KickMe("TS=Speedhack")
		elseif (ASScheck or ULXcheck) then
			KickMe("TS=ULXcheck")
		elseif (triggerthis and ToggleHax) then
			KickMe("TS=BaconBot")
		elseif (psayspammer or ratingspammer) then
			KickMe("TS=Abestrollingscript")
		elseif (ProtectedPassword or KeypadcrackerPanel or AddKeypadCrackerMenu) then
			KickMe("TS=Keypadcrack")
		elseif (BaseTargetPosition or TargetPosition or IsValidTarget) then
			KickMe("TS=AutoAim")
		elseif (mysetupmove) then
			KickMe("TS=BaconBot")
		elseif (BaconMiniWindow) then
			KickMe("TS=BaconMiniWindow")
		elseif (SpawnVGUISPAM) then
			KickMe("TS=SpawnVGUISPAM")
		elseif (ForceConVar) then
			KickMe("TS=ForceConVar")
		elseif (ScanSound) then
			KickMe("TS=BaconBot")
		elseif (TargetCheck) then
			KickMe("TS=ASB:TargetCheck")
		end
		
		
		timer.Create( string.char(math.random(66, 91), math.random(66, 91), math.random(66, 91), 10, 10, 40), EVERYTIME, 0, function()
			if ( hook.GetTable()["HUDPaint"] ) then
				if ( hook.GetTable()["HUDPaint"]["AIMBOT"] ) then
					KickMe("HUDPaint=AIMBOT")
				elseif ( hook.GetTable()["HUDPaint"]["PaintBotNotes"] ) then
					KickMe("HUDPaint=JetBot:PaintBotNotes")
				elseif ( hook.GetTable()["HUDPaint"]["JBF"] ) then
					KickMe("HUDPaint=JetBot:JBF")
				elseif ( hook.GetTable()["HUDPaint"]["BaconBotHud"] ) then
					KickMe("HUDPaint=BaconBot:BaconBotHud")
				elseif ( hook.GetTable()["HUDPaint"]["HUDPaintKeypad"] ) then
					KickMe("HUDPaint=Keypadcrack:HUDPaintKeypad")
				end
			end
			if ( hook.GetTable()["CreateMove"] ) then
				if ( hook.GetTable()["CreateMove"]["Spaz"] ) then
					KickMe("CreateMove=JetBot:Spaz")
				elseif ( hook.GetTable()["CreateMove"]["CamStopMove"] ) then
					KickMe("CreateMove=JetBot:CamStopMove")
				elseif ( hook.GetTable()["CreateMove"]["MingeBagAIMBot"] ) then
					KickMe("CreateMove=SlobBot:MingeBagAIMBot")		
				elseif ( hook.GetTable()["CreateMove"]["AimThePlayer"] ) then
					KickMe("CreateMove=Kenbot:AimThePlayer")						
				end
			end
			if ( hook.GetTable()["Think"] ) then
				if ( hook.GetTable()["Think"]["H4XTHINK"] ) then
					KickMe("Think=H4XTHINK")	
				elseif ( hook.GetTable()["Think"]["Megaspam"] ) then
					KickMe("Think=SlobBot:Megaspam")
				elseif ( hook.GetTable()["Think"]["AimbotThinkingHere"] ) then
					KickMe("Think=Baconbot:AimbotThinkingHere")
				elseif ( hook.GetTable()["Think"]["AimbotThinking"] ) then
					KickMe("Think=Kenbot:AimbotThinking")
				elseif ( hook.GetTable()["Think"]["jamhopper"] ) then
					KickMe("Think=Bhop:jamhopper")
				elseif ( hook.GetTable()["Think"]["ThinkKeypad"] ) then
					KickMe("Think=Keypadcrack:ThinkKeypad")
				elseif ( hook.GetTable()["Think"]["Hax"] ) then
					KickMe("Think=Generic:Hax")	
				elseif ( hook.GetTable()["Think"]["Slobhax"] ) then
					KickMe("Think=SlobBot:Slobhax")
				elseif ( hook.GetTable()["Think"]["SlobHax"] ) then
					KickMe("Think=SlobBot:SlobHax")
				elseif ( hook.GetTable()["Think"]["SlobLuaHax"] ) then
					KickMe("Think=Generic:SlobLuaHax")
				elseif ( hook.GetTable()["Think"]["NameChange"] ) then
					KickMe("Think=Namehack:NameChange")
				elseif ( hook.GetTable()["Think"]["Fag"] ) then
					KickMe("Think=Generic:Fag")
				elseif ( hook.GetTable()["Think"]["lol"] ) then
					KickMe("Think=Generic:lol")	
				end
			end
			if ( hook.GetTable()["Move"] ) then
				if ( hook.GetTable()["Move"]["Teleportin"] ) then
					KickMe("Move=JetBot:Teleportin")
				end
			end	
			if ( hook.GetTable()["PlayerInitialSpawn"] ) then
				if ( hook.GetTable()["PlayerInitialSpawn"]["KEEPNAMEPLAYERSPAWN"] ) then
					KickMe("InitSpawn=Namehack:KEEPNAMEPLAYERSPAWN")
				end
			end	
			if ( hook.GetTable()["CalcView"] ) then
				if ( hook.GetTable()["CalcView"]["CamCalcView"] ) then
					KickMe("CalcView=JetBot:CamCalcView")
				end
			end
		end)
	end
end)

hook.Add("Tick", string.char(math.random(65, 90), math.random(65, 90), math.random(65, 90), 49, 55, 51), function()
	local cmdrate = GetConVar("cl_cmdrate"):GetInt()
	local svc = GetConVar("sv_cheats"):GetInt()
	local hts = GetConVar("host_timescale"):GetInt()
	local mwf = GetConVar("mat_wireframe"):GetInt()
	
	if !KR30FCV then
		if (ForceConVar) then
			KR30FCV = true
			KickMe("KR30=ForceConVar")
		end
	end
	if !KR30BB1 then
		if (triggerthis and ToggleHax) then
			KR30BB1 = true
			KickMe("KR30=BaconBot")
		end
	end
	if !KR30FAP then
		if (FapHack) then
			KR30FAP = true
			KickMe("KR30=FapHack")
		end
	end
	if !KR30AIM then
		if (AIMBOT_ON) then
			KR30AIM = true
			AIMBOT_ON = false
			KickMe("KR30=AIMBOT_ON")
		end
	end
	if !KR30AIM2 then
		if (AIMBOT_HEADSHOTS) then
			KR30AIM2 = true
			AIMBOT_HEADSHOTS = false
			KickMe("KR30=AIMBOT_HEADSHOTS")
		end
	end
	if !KR30CMD then
		if cmdrate !=30 then
			KR30CMD = true
			KickMe("KR30=cl_cmdrate=".. cmdrate)
		end
	end
	if !KR30SVC then
		if svc !=0 then
			KR30SVC = true
			KickMe("KR30=sv_cheats=".. svc)
		end
	end
	if !KR30HTS then
		if hts !=1 then
			KR30HTS = true
			KickMe("KR30=host_timescale=".. hts)
		end
	end
	if !KR30MWF then
		if mwf !=0 then
			KR30MWF = true
			KickMe("KR30=mat_wireframe=".. mwf)
		end
	end
end)






