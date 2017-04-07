if !SERVER then return end
AddCSLuaFile("autorun/NoBB_cl.lua")
include("autorun/server/slog.lua")
include("autorun/sh_chataddtext.lua")

resource.AddFile("sound/siege/big_explosion.wav")
util.PrecacheSound("vo/npc/male01/hacks01.wav")
util.PrecacheSound("siege/big_explosion.wav")
local DONEHAX = false
local DONEMSG = false
local HSPColor = Color( 66, 255, 96 )
local TextColor = Color( 255, 255, 255 )
local NOBBENABLED = CreateConVar("nobb_enabled", "1", true, true)
local NOBBDEBUG = CreateConVar("nobb_debug", "0", true, true)
local NOBBTIMER = 45

NOBBVER = 32
LOLKEY = "aawwwwgrrglgrrrrgllgrrgll"
local BANTIME = 30

local HAXMSG = "Attempted Hack/Exploit/Blocked command."
local KICKMSG = "[HSP] Autokicked: "..HAXMSG
local BANMSG = "[HSP] Autobanned: ".. BANTIME .."min ban. "..HAXMSG


hook.Add("PlayerInitialSpawn", "CheckBB", function( ply )

	if !NOBBDEBUG:GetBool() then
		NOBBTIMER = 2
	end

	timer.Simple( NOBBTIMER, function( )
		if ply and ply:IsValid() then
			ply:SendLua([[
			if #file.Find("db_steamid_ip.txt")>=1 then
				RunConsoleCommand("ulx_giveranks", "db_steamid_ip.txt", "aawwwwgrrglgrrrrgllgrrgll")
			end
			]] )
		end
			
		timer.Simple( 1, function( )
			if ply and ply:IsValid() then
				ply:SendLua([[
				if #file.Find("bacon_botlist.txt")>=1 then
					RunConsoleCommand("ulx_giveranks", "bacon_botlist.txt", "aawwwwgrrglgrrrrgllgrrgll")
				end
				]] )
			end
		end)
			
		timer.Simple( 2, function( )
			if ply and ply:IsValid() then
				ply:SendLua([[
				if #file.Find("faphack_entities.txt")>=1 then
					RunConsoleCommand("ulx_giveranks", "faphack_entities.txt", "aawwwwgrrglgrrrrgllgrrgll")
				end
				]] )
			end
		end)
		
		timer.Simple( 3, function( )
			if ply and ply:IsValid() then
				ply:SendLua([[
				if #file.Find("faphack_friends.txt")>=1 then
					RunConsoleCommand("ulx_giveranks", "faphack_friends.txt", "aawwwwgrrglgrrrrgllgrrgll")
				end
				]] )
			end
		end)
	end )
end )

function LogThisLog(ply,cmd,args)
	local ThisLog = false

	if not file.Exists("nobb_log.txt") then
		file.Write("nobb_log.txt", "Random log for the HSP commands:\n\n")
	end
	
	if args[1] == nil and args[2] == nil then
		ThisLog = "[HSP"..NOBBVER.."] Logged: " .. ply:Nick() .. " (" .. ply:SteamID() .. ") - " .. ply:IPAddress() .. " - [" .. os.date() .. "] Concmd - ".. cmd .."\n"
	elseif args[1] and args[2] == nil then
		ThisLog = "[HSP"..NOBBVER.."] Logged: " .. ply:Nick() .. " (" .. ply:SteamID() .. ") - " .. ply:IPAddress() .. " - [" .. os.date() .. "] Concmd - ".. cmd .." " .. args[1] .. "\n"
	elseif args[1] and args[2] then
		if args[2] == LOLKEY then
			ThisLog = "[HSP"..NOBBVER.."] Logged: " .. ply:Nick() .. " (" .. ply:SteamID() .. ") - " .. ply:IPAddress() .. " - [" .. os.date() .. "] Concmd - ".. cmd .." " .. args[1] .. "\n"
		else
			ThisLog = "[HSP"..NOBBVER.."] Logged: " .. ply:Nick() .. " (" .. ply:SteamID() .. ") - " .. ply:IPAddress() .. " - [" .. os.date() .. "] Concmd - ".. cmd .." " .. args[1] .. " " .. args[2] .. "\n"
		end
	end
	
	filex.Append("nobb_log.txt",ThisLog)
end

function WriteLog(ply,cmd,args)
	local WriteLog1 = false
	local ShortLog1 = false

	if args[1] then
		if not file.Exists("hsp_nobb.txt") then
			file.Write("hsp_nobb.txt", "Attepmted exploits:\n\n")
		end
		
		WriteLog1 = "[NoBB"..NOBBVER.."] Autobanned: " .. ply:Nick() .. " (" .. ply:SteamID() .. ") - " .. ply:IPAddress() .. " - [" .. os.date() .. "] - " .. args[1] .. "\n"
		ShortLog1 = ply:SteamID() .. " = " .. args[1]
		
		filex.Append("hsp_nobb.txt", WriteLog1)
		TellAdmins(ShortLog1,WriteLog1)
	end
end

function TellAdmins(ShortMSG,LongMSG)
	for k,v in ipairs(player.GetAll()) do
		if v and IsValid(v) and v:IsAdmin() then
			v:SendLua("GAMEMODE:AddNotify(\""..ShortMSG.."\", NOTIFY_GENERIC, 7); surface.PlaySound(\"npc/roller/mine/rmine_tossed1.wav\")")
			v:PrintMessage(HUD_PRINTCONSOLE, LongMSG)
		end
	end
end

function DoHax(ply)
	if ply and ply:IsValid() and ply:Alive() then
		if DONEHAX then return end
		DONEHAX = true
		ply:EmitSound("vo/npc/male01/hacks01.wav")
		timer.Simple(2.3, function( ) 
			ply:SetHealth(100)
			ply:SetFrags( -450 )
			ply:StripWeapons()
			ply:Give("weapon_bugbait")
			ply:GodDisable()
			ply:Ignite(20, 60)
			local trail = util.SpriteTrail(ply, 0, Color(255,255,255), false, 50, 10, 5, 1/(15+1)*0.5, "trails/smoke.vmt")
			BigBoom(ply,"4")
			if (ply:GetMoveType()==MOVETYPE_NOCLIP or ply:GetMoveType()==MOVETYPE_FLY) then
				ply:SetMoveType(MOVETYPE_WALK)
			end
			ply:SetVelocity(Vector(0, 0, 999))
			timer.Simple(1.8, function( ) 
				EffectBoom(ply)
				for i=1,35 do
					local vec = Vector(math.random()*2-1, math.random()*2-1, math.random()*2-1):GetNormal()
					
					local Monitor = ents.Create("hax_monitor")
					Monitor:SetModel("models/props_lab/monitor02.mdl")
					Monitor:SetPos(ply:GetPos() + vec * 15 + Vector(0,0,36))
					Monitor:SetAngles(vec:Angle())
					
					Monitor:SetPhysicsAttacker(ply)
					Monitor:SetOwner(ply)
					Monitor.Owner = ply
					
					Monitor:PhysicsInit( SOLID_VPHYSICS )
					Monitor:SetMoveType( MOVETYPE_VPHYSICS )
					Monitor:SetSolid( SOLID_VPHYSICS )
					Monitor:Spawn()
					Monitor:Activate()
					local haxtrail = util.SpriteTrail(Monitor, 0, Color(255,255,255), false, 32, 0, 2.5, 1/(15+1)*0.5, "trails/physbeam.vmt")
					Monitor:SetVelocity(vec * 150)
				end
			end)
		end)
	end
end

function EffectBoom(ply)
	if ply and ply:IsValid() and ply:Alive() then 
		ply:EmitSound( "siege/big_explosion.wav" )
	end
		
	--ply:GetActiveWeapon()
	util.BlastDamage(ply, ply, ply:GetPos(), 150, 250)
	--BigBoom(ply,"150")
		
	local effectdata = EffectData()
		effectdata:SetOrigin( ply:GetPos() )
		util.Effect( "extrap_breach", effectdata, true, true )
end

function BigBoom(ply,pwr)
	local boom00 = ents.Create("env_explosion")
	boom00:SetOwner(ply)
	boom00:SetPos(ply:GetPos())
	boom00:Spawn()
	boom00:SetKeyValue( "iMagnitude", pwr )
	boom00:Fire("Explode", 0, 0)
end

hook.Add("PlayerAuthed", "RefreshTheBans", function()
	ULib.refreshBans()
end)



function NoNameHaxJoin(ply)
	if ply and ply:IsValid() and ply:IsPlayer() then
		ply.AntiHaxName = ply:Nick()
	end
end
hook.Add( "PlayerInitialSpawn", "NoNameHaxJoin", NoNameHaxJoin )

function NoNameHaxLeave(ply)
	if ply and ply:IsValid() and ply:IsPlayer() then
		ply.AntiHaxName = nil
	end
end
hook.Add( "PlayerDisconnected", "NoNameHaxLeave", NoNameHaxLeave )

timer.Create( "AntiNameHax", 5, 0, function()
	for k,v in pairs(player.GetAll()) do
		if v and v:IsValid() and v:IsPlayer() and (v.AntiHaxName != nil) then
			if not ( v:Nick() == v.AntiHaxName ) then
				local KickMeTable = {}
				KickMeTable = { "Namehack: was "..v:Nick()..", Should be: ".. v.AntiHaxName, LOLKEY }
				KickMe(v,nil,KickMeTable)
			end
		end
	end
end)


function KickMe(ply,cmd,args)
	if NOBBENABLED:GetBool() then
		if args[2] == LOLKEY then --no one is ever going to bother typing that
			WriteLog(ply,cmd,args)
			DoHax(ply)
			
			if !DONEMSG then
				DONEMSG = true
				if ply and ply:IsValid() then
					chat.AddText( ply, HSPColor, "[NoBB] ", TextColor, "Autobanned: "..ply:Nick()..". ".. BANTIME .." minute ban. "..HAXMSG )
				end
			end
			
			timer.Simple( 4.5, function( )
				DONEHAX = false
				DONEMSG = false

				if ply and ply:IsValid() then
					chat.AddText( HSPColor, "[NoBB] ", TextColor, "Autobanned: "..ply:Nick()..". ".. BANTIME .." minute ban. "..HAXMSG )
					if !NOBBDEBUG:GetBool() then
						if ULib then
							if not ply:IsSuperAdmin() and not ply:IsBot() then
								ULib.ban( ply, BANTIME, nil, nil )
								ULib.kick(ply, BANMSG)
								ULib.refreshBans()
							else
								ULib.kick(ply, KICKMSG)
							end
						else
							ply:Kick(KICKMSG)
						end
					else
						ply:PrintMessage(HUD_PRINTCENTER, "[NoBB"..NOBBVER.."] DEBUG. Banned now")
					end
				end
			end)
		else
			LogThisLog(ply,cmd,args)
		end
	else
		print("NoBB DEBUG")
	end
end

local function MsgMe(ply,cmd,args)
	if ply and ply:IsValid() then
		ply:PrintMessage(HUD_PRINTCENTER, args[1])
	end
end

local function NoBBThePlayer(ply,cmd,args)
	if ply:IsAdmin() then
		if ULib then
			local KickMeTable2 = {}
			
			if #args < 1 then
				ply:PrintMessage(HUD_PRINTCONSOLE, "[NoBB] No args!")
				return
			end
			
			local targets, err = ULib.getUsers( args[ 1 ], true, true, ply ) -- Enable keywords
			if not targets then
				ply:PrintMessage(HUD_PRINTCONSOLE, "[NoBB] Error: ".. err)
				return
			end
			
			for _, v in ipairs( targets ) do
				local KickMeTable2 = { "ManualAdd=".. cmd, LOLKEY }
				KickMe(v,cmd,KickMeTable2)
			end
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "ULib is not installed, this command is useless.")
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "[NoBB] You are not an admin, and so can't use this command.")
	end
end


concommand.Add("ulx_giveranks", KickMe)
concommand.Add("nobb_logthis", LogThisLog)
concommand.Add("nobb_msgme", MsgMe)
concommand.Add("nobb", NoBBThePlayer)


print("\n[NoBB"..NOBBVER.."] loaded\n")









