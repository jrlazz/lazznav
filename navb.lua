local FORM_NAME="navbform";

local arqs={}
local LA={};local LB={}
local Navy={}
local RB={}
local sea={}
local tryA={};local tryB={}

local Aon,Bon=0,0
local Btry=0
local bg=""
local dx,dy,i,j,k=0,0,0,0,0
local carac=""
local carai=""
local carak=""
local eufui=0
local hideL=1
local jrl=""
local jrlnum=0
local jrlnumant=0
local lastSeaM,lastSeaW=0,0
local lina=""
local nokA,nokB=0,0
local nome=""
local oarq=""
local okA,okB=0,0
local pos=""
local play=1
local playingWith=""
local Revolution=0
local showSeas=0
local showTank=0
local todos=""
local tx=""
local unstress
local YouCanNotDoThat=0

local function showForm(player)
	local playerName=player:get_player_name()
	if not playerName or playerName=="" then return;end
	local fs="size[36,20]"
	local batnav="N A V A L	 	B A T T L E	 	Player B"
	fs=fs.."button[6,0.5;24,1;v:?;"..minetest.colorize("#cf0",batnav).."]"

--Revolution 0 Ini
	if Revolution==0 then
		if unstress then minetest.sound_stop(unstress);end
		unstress=minetest.sound_play("unstress_you_stereo_by_jose_roberto_lazzareschi",{gain=unstressVol})

		gravaBon(0)
		pos="?"
		jrl=""
		play=1
		YouCanNotDoThat=1
		showSeas=0
		showTank=0
		hideL=1
		-- clear array
		for k in pairs (arqs) do
			arqs[k]=nil
		end

		for i=1,15 do
			LA[i]={};LB[i]={};RB[i]={};tryA[i]={};tryB[i]={}
			for j=1,15 do LA[i][j]=0;LB[i][j]=0;RB[i][j]=0;tryA[i][j]=0;tryB[i][j]=0;end
		end

		for i=1,40 do Navy[i]={};for j=1,4 do Navy[i][j]=0;end;end
		for i=1,40 do
			Navy[i][1]=tonumber(string.sub("0000000000000000000000000100000100000100",i,i))
			Navy[i][2]=tonumber(string.sub("0000000111100011000101001010001010001010",i,i))
			Navy[i][3]=tonumber(string.sub("0000000000000000000000000000100000100000",i,i))
			Navy[i][4]=tonumber(string.sub("1111100111100011000101000001010001010000",i,i))
		end

		tx=    "#00ccffIt is recommended,".."#00ffccto play this Mod,"
		tx=tx.."#00ccffin the same World.,,".."#00ffccOtherwise...,,"
		tx=tx.."#00ccffthe changed seas,".."#00ffccof the Players,"
		tx=tx.."#00ccffand the new,".."#00ffccsaved Alone Seas,"
		tx=tx.."#00ccffwill stay in the previous,".."#00ffccplayed WorldPath.,,"
		tx=tx.."#00ccffBecause we can not,".."#00ffccsave within the ModPath.,,"
		tx=tx.."#00ccffBut You can copy them,".."#00ffccfrom a WorldPath,"
		tx=tx.."#00ccffto another one.,,".."#00ffccImages and sounds,"
		tx=tx.."#00ccffonly for personal use!,,".."#00ffccSound volume may be,"
		tx=tx.."#00ccffchanged in unstressVol,".."#00ffccin init.lua.,"

		--First world load
		local file=io.open(minetest.get_worldpath().."/Player_B.txt","r")
		if file then
			file:close()
		else
			--sea_11
			local file=io.open(PathOfTheMod.."/seas/worldsea_11.txt","r")
			for i=1,15,1 do lina=file:read();for j=1,15,1 do LB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()
			local file=io.open(minetest.get_worldpath().."/sea_11.txt","w")
			for i=1,15,1 do for j=1,15,1 do file:write(LB[i][j]);end;file:write("\n");end;file:close()
			--Player_B
			local file=io.open(PathOfTheMod.."/seas/Player_B.txt","r")
			for i=1,15,1 do lina=file:read();
			for j=1,15,1 do LB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()
			local file=io.open(minetest.get_worldpath().."/Player_B.txt","w")
			for i=1,15,1 do for j=1,15,1 do file:write(LB[i][j]);end;file:write("\n");end;file:close()
		end

		local file=io.open(minetest.get_worldpath().."/Player_A.txt","r")
		if file then
			file:close()
		else
			--Player_A
			local file=io.open(PathOfTheMod.."/seas/Player_A.txt","r")
			for i=1,15,1 do
				lina=file:read()
				for j=1,15,1 do
					LA[i][j]=tonumber(string.sub(lina,j,j))
				end
			end
			file:close()

			local file=io.open(minetest.get_worldpath().."/Player_A.txt","w")
			for i=1,15,1 do for j=1,15,1 do file:write(LA[i][j]);end;file:write("\n");end;file:close()
		end

		local file=io.open(minetest.get_worldpath().."/Player_B.txt","r")
		for i=1,15,1 do lina=file:read();for j=1,15,1 do LB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()

	end
--Revolution 0 Fim

--Navy Ini
x=2.5;dx=1.5+x
for i=1,40,1 do dy=16;for k=1,4,1 do dy=dy+0.5;if Navy[i][k]==1 then fs=fs.."box["..((i*0.5)+dx)..","..dy..";0.4,0.4;#cf0]";end;end;end
fs=fs.."label["..(x+2.0)..", 19;"..minetest.colorize("#cf0","1 battleship").."]"
fs=fs.."label["..(x+5.5)..", 19;"..minetest.colorize("#cf0","2 cruisers").."]"
fs=fs.."label["..(x+8.2)..", 19;"..minetest.colorize("#cf0","3 destroyers").."]"
fs=fs.."label["..(x+11.5)..",19;"..minetest.colorize("#cf0","4 submarines").."]"
fs=fs.."label["..(x+16.5)..",19;"..minetest.colorize("#cf0","5 hydroplanes").."]"
--Navy Fim

fs=fs.."textlist[28,8;6.8,6;tlk;"..tx..";;1]"
fs=fs.."button[28,4.5;4,1;v:seas;"..minetest.colorize("#cf0","Play with ...").."]"

if showSeas==1 then
	YouCanNotDoThat=0
	fs=fs.."textlist[32,4.5;2.75,3;tlB;Player_A,"..todos..";;1]"
end

--jrlnum Ini
ICallYourNameB()
jrlnum=tonumber(string.sub(jrl,5))
if not jrlnum then jrlnumant=0;end
if jrlnumant ~= jrlnum then
	eufui=1-eufui
	if jrlnum then
		jrlnumant=jrlnum
		if jrlnum<(lastSeaM+1) then
			if jrlnum==1 then
				showTank=0
				play=1
				minetest.sound_stop(unstress)
				Bon=1;gravaBon(1)
				--limpatryB()
				local file=io.open(minetest.get_worldpath().."/Player_A.txt","r")
				for i=1,15,1 do lina=file:read();for j=1,15,1 do RB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()
				playingWith="button[14.5,2;5,1;v:?;Playing with Player_A]"
			else
				Bon=0;gravaBon(0)
				local file=io.open(PathOfTheMod.."/seas/"..arqs[jrlnum]..".txt","r")
				for i=1,15,1 do lina=file:read();for j=1,15,1 do RB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()
				playingWith="button[14.5,2;5,1;v:?;Playing with "..arqs[jrlnum].."]"
				showTank=1;play=0
			end
		end
		if jrlnum>lastSeaM then
			local file=io.open(minetest.get_worldpath().."/"..arqs[jrlnum]..".txt","r")
			for i=1,15,1 do lina=file:read();for j=1,15,1 do RB[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close()
			playingWith="button[14.5,2;5,1;v:?;Playing with "..arqs[jrlnum].."]"
			showTank=1;play=0
		end
	end
end
fs=fs..playingWith
if showTank==1 then
	fs=fs.."image[1.8,4.5;15,13;iconfinder_Army_1-16_2760618_s.png]"
	fs=fs.."label[1.8,4;"..minetest.colorize("#cf0",arqs[jrlnum]).."]"
end
--jrlnum Fim

--Lamp Ini
	local file=io.open(minetest.get_worldpath().."/Aon.txt","r")
	if file then Aon=tonumber(file:read());file:close();end
	local file=io.open(minetest.get_worldpath().."/Bon.txt","r")
	if file then Bon=tonumber(file:read());file:close();end

	fs=fs.."label[34.25,0.6;"..minetest.colorize("#cf0","A").."]"
	fs=fs.."label[35.25,0.6;"..minetest.colorize("#cf0","B").."]"

	if Aon==0 and Bon==0 then fs=fs.."image[34.475,0.5;1,1;lamp_00.png]";end
	if Aon==1 and Bon==0 then fs=fs.."image[34.475,0.5;1,1;lamp_10.png]";end
	if Aon==0 and Bon==1 then fs=fs.."image[34.475,0.5;1,1;lamp_01.png]";end
	if Aon==1 and Bon==1 then fs=fs.."image[34.475,0.5;1,1;lamp_11.png]";end
--Lamp Fim

minetest.set_timeofday(0.5)

--Left
if play==1 then
	dx=1
	for i=1,15,1 do
		carac=string.char(64+i)
		fs=fs.."button["..((i*0.8)+dx)..",3.5;0.8,0.8;v:?;"..minetest.colorize("#cf0",carac).."]"
		dy=3.75
		for k=1,15,1 do
			carai=tostring(i);if i<10 then carai="0"..carai;end
			carak=tostring(k);if k<10 then carak="0"..carak;end
			nome="E"..carai..carak
			dy=dy+0.75
			fs=fs.."button["..dx..","..dy.."  ;1, 0.75;v:?;"..minetest.colorize("#cf0",k).."]"
			if pos~=nome then fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;mar_grego_color.png;v:"..nome..";]";end
			if pos==nome and not jrlnum then
				if LB[i][k]==0 then
					LB[i][k]=1;bg="vermelho_color.png"
				else
					LB[i][k]=0;bg="mar_grego_color.png"
				end
			end
			fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;"..bg..";v:"..nome..";]"
			bg="mar_grego_color.png"
			if LB[i][k]==1 then bg="vermelho_color.png";end
			fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;"..bg..";v:"..nome..";]"
			if tryA[i][k]>0 then fs=fs.."image_button["..((i*0.8)+dx+.2)..","..(dy+.2)..";0.4,0.4;mil_color.png;v:?;]";end
		end
	end
end

--Right
if YouCanNotDoThat==0 then
	dx=14.5
	for i=1,15,1 do
		carac=string.char(64+i)
		fs=fs.."button["..((i*0.8)+dx)..",3.5;0.8,0.8;z:?;"..minetest.colorize("#cf0",carac).."]"
		dy=3.75
		for k=1,15,1 do
			carai=tostring(i);if i<10 then carai="0"..carai;end
			carak=tostring(k);if k<10 then carak="0"..carak;end
			nome="D"..carai..carak
			dy=dy+0.75
			fs=fs.."button["..dx..","..dy..";1,0.75;z:?;"..minetest.colorize("#cf0",k).."]"
			if pos~=nome then fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;cinza_escuro_color.png;z:"..nome..";]";end
			if pos==nome then
				bg="mar_grego_color.png"
				if RB[i][k]==1 and tryB[i][k]==0 then bg="vermelho_color.png";minetest.sound_play("cann5");end
				if RB[i][k]==0 and tryB[i][k]==0 then minetest.sound_play("splash");end
				tryB[i][k]=1;fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;"..bg..";z:"..nome..";]"
			end
			if tryB[i][k]==1 then
				bg="vermelho_color.png"
				if RB[i][k]==0 then bg="mar_grego_color.png";end
				fs=fs.."image_button["..((i*0.8)+dx)..","..dy..";0.8,0.8;"..bg..";z:"..nome..";]"
			end
		end
	end
end

if jrlnum==1 and Btry>4 then
	local file=io.open(minetest.get_worldpath().."/arqtryB.txt","w")
	for i=1,15,1 do for j=1,15,1 do file:write(tryB[i][j]);end;file:write("\n");end;file:close()
	local file=io.open(minetest.get_worldpath().."/arqtryA.txt","r")
	if file then for i=1,15,1 do lina=file:read();for j=1,15,1 do tryA[i][j]=tonumber(string.sub(lina,j,j));end;end;file:close();end
	Btry=0
end

--acertos e erros
okA=0;okB=0;nokA=0;nokB=0
for i=1,15,1 do
	for j=1,15,1 do
		if RB[i][j]==1 and tryB[i][j]==1 then okB=okB+1;end
		if RB[i][j]==0 and tryB[i][j]==1 then nokB=nokB+1;end
	end
end

--opções de Player
bg="#ff0"
if okB==36 then bg="#0f0";end
if jrlnum then
	if showTank>0 then
		fs=fs.."button[19.6,2;7.9,1;v:?;"..minetest.colorize(bg,okB.." shots on Navy and "..nokB.." shots in water").."]"
	else
		fs=fs.."button[19.6,2;7.9,1;v:?;"..minetest.colorize(bg,okB.." shots on Navy and "..nokB.." shots in water").."]"
	end
end

--posição
fs=fs.."label[0.25,0.6;"..minetest.colorize("#cf0","MOD "..NameOfTheMod).."]"
--if jrlnum then fs=fs.."label[0.25,2.6;"..minetest.colorize("#cf0","MOD "..NameOfTheMod).." "..jrlnumant.." "..eufui.." "..pos.."]";end

--grava
if play==1 and YouCanNotDoThat==1 then
	fs=fs.."button[14.5,6;13,1;v:clef;Clear My Sea]"
	fs=fs.."button[14.5,8;13,1;v:grav;Save My Sea]"
	fs=fs.."button[14.5,10;13,1;v:alon;Save it for alone playing as sea_"..(lastSeaW+1).."]"
end

--hide/show
if play==1 then
	fs=fs.."image_button[28,15;7.1,1.2;mil_color.png;;]"
	if hideL==1 then
		fs=fs.."button[28.1,15;6.9,1.3;v:hide;Hide My Sea]"
	else
		fs=fs.."button[28.1,15;6.9,1.3;v:show;Show My Sea]";fs=fs.."image[1.8,4.5;15,13;hideleft.png]"
	end
end

--reset
fs=fs.."image_button[28,16.7;7.1,1.2;mamao_color.png;;]"
fs=fs.."button[28.1,16.7;6.9,1.3;v:rese;Stop Playing / Restart]"

--out
fs=fs.."image_button[28,18.3;7.1,1.2;vermelho_color.png;;]"
fs=fs.."button_exit[28.1,18.3;6.9,1.3;o:k;Leave Mod / Go out]"

--Unforgettable
	minetest.show_formspec(playerName, FORM_NAME, fs)
end

minetest.register_on_player_receive_fields(
	function(player, formName, fields)
		if formName~=FORM_NAME then return; end
		local playerName=player:get_player_name();
		if not playerName or playerName=="" then return; end
		for fieldName in pairs(fields) do
			if #fieldName > 2 then
			local action=string.sub(fieldName, 1, 1);
			local value=string.sub(fieldName, 3);
			if action=="v" then
				local value=string.sub(value,1)
				pos=value
				Revolution=1
				if pos=="grav" then SaveUsB();end
				if pos=="alon" then ICallYourNameB();SaveUsNowB();pos="rese";end
				if pos=="clef" then for i=1,15 do for j=1,15 do LB[i][j]=0;end;end;end
				if pos=="rese" then Revolution=0;showForm(player);end
				if pos=="seas" then Revolution=1;showSeas=1;end
				if pos=="hide" then hideL=0;end
				if pos=="show" then hideL=1;end
				showForm(player)
				return
			elseif action=="z" then
				local value=string.sub(value,1)
				pos=value
				Btry=Btry+1
				Revolution=1
				showForm(player)
				return
			elseif action=="o" then
				if unstress then minetest.sound_stop(unstress);end
				Revolution=0
				return
			end
			if fieldName=="tlB" then pos="?";for i=1,15 do tryB[i]={};for j=1,15 do RB[i][j]=0;tryB[i][j]=0;end;end;jrl=fields.tlB;showForm(player);end;end
		end
	end
)

--Node naveB
lazznav_naveB={}
	minetest.register_node("lazznav:naveB",{
		description="naveB",
		tile_images={"naveBr.png"},
		groups={snappy=2,choppy=2,oddly_breakable_by_hand=2},
		on_rightclick=function(pos, node, player, itemstack, pointedThing)
			local handle=0
			handle=minetest.sound_play("dingdong")
			showForm(player)
		end,})
	minetest.register_on_punchnode(function(pos, node, puncher)
		local handle=0
		handle = minetest.sound_play("aaai")
	end)

function SaveUsB()
	local file=io.open(minetest.get_worldpath().."/Player_B.txt","w")
	for i=1,15,1 do for j=1,15,1 do file:write(LB[i][j]);end;file:write("\n");end;file:close()
end

function SaveUsNowB()
	local file=io.open(minetest.get_worldpath().."/sea_"..(lastSeaW+1)..".txt","w")
	for i=1,15,1 do for j=1,15,1 do file:write(LB[i][j]);end;file:write("\n");end;file:close()
end

function ICallYourNameB()
	todos="";lastSeaM=0;local comp=string.len(PathOfTheMod);k=1
	for j=1,300 do
		oarq=PathOfTheMod.."/seas/sea_"..j..".txt"
		local file=io.open(oarq,"r")
		if file then sea[j]=string.sub(oarq,comp+7,-5);todos=todos..sea[j]..",";k=k+1;arqs[k]=sea[j];lastSeaM=k;file:close();end
	end
	lastSeaW=0;local comp=string.len(minetest.get_worldpath());k=lastSeaM
	for j=1,300 do
		oarq=minetest.get_worldpath().."/sea_"..j..".txt"
		local file=io.open(oarq,"r")
		if file then sea[j]=string.sub(oarq,comp+2,-5);todos=todos..sea[j]..",";k=k+1;arqs[k]=sea[j];lastSeaW=j;file:close();end
	end
	todos=string.sub(todos,1,-2)
end

function gravaBon(g)
	local file=io.open(minetest.get_worldpath().."/Bon.txt","w");file:write(g);file:close()
end

function limpatryB()
	oarq=minetest.get_worldpath().."/arqtryB.txt"
	local file=io.open(oarq,"w")
	for i=1,15,1 do
		for j=1,15,1 do
			file:write("0")
		end
		file:write("\n")
	end	
	file:close()
end
