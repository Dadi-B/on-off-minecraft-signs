:::::::::::::::::  Version 2.0 relased!  ::::::::::::::::::
::  Changed many variables names, added multiple signs   ::
::  with same value compatibilty on all facings, added   ::
:: tellraw message of infos and contact email, a config  ::
:: file, functions with facing automation and some tool- ::
:: tips to help you or to give infos abot this generator ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
setlocal EnableDelayedExpansion
if not exist settings.json (
	echo #Config file of "%%0".
	echo.
	echo tooltips:1
	echo pause_end:1
	echo auto_open_end:1
	echo file_name:code.txt
)>settings.json
for /f "eol=# tokens=1* delims=:" %%a in (settings.json) do (
	if %%b==1 (
		set %%a=true
	) else if %%b==0 (
		set %%a=false
	) else set %%a=%%b
)
title Minecraft on-off sign generator 2.0 for vanilla minecraft 1.8+
set ln1= 
set ln2= 
if /I "%tooltips%"=="true" (
	echo [Coded by DadiB]
	echo Change the "settings.json" file to configure particular stuff.
	echo.
)
set /p ver=Version[1.8+]: 
set /p function=Function[Y^/N]: 
set /p fac=Sign facing[N^|E^|S^|W]: 
set /p value=Scoreboard name: 
set /p ln1=1st line of text: 
set /p ln2=2nd line of text: 
echo.
if /I "%tooltips%"=="true" (
	echo Copy and paste the code saved in "%file_name%" in your command block under the sign and set it on always active
	echo.
	echo I hope I helped you, if so help me by giving credits if you share this.
)
set version=%ver%
set ver=%ver:10=9%
set ver=%ver:12=11%
set ver=%ver:14=13%
if %ver:~,3%==1.8 set function=N
if %ver:~,3%==1.9 set function=N
if /I %function%==Y (
	md on-off_sign\%value%\
	if %ver:~,4%==1.11 (
		echo gamerule commandBlockOutput false
		echo summon armor_stand ~ ~.5 ~ {NoGravity:1,Tags:[detector],Invisible:1}
		echo scoreboard objectives add %value% dummy
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign -1 summon armor_stand ~ ~ ~ {Marker:1,NoGravity:1,Invisible:1,Tags:[%value%S]}
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 2 summon armor_stand ~ ~-1 ~2 {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 2 setblock ~ ~ ~1 minecraft:redstone_lamp
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 3 summon armor_stand ~ ~-1 ~-2 {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 3 setblock ~ ~ ~-1 minecraft:redstone_lamp
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 4 summon armor_stand ~2 ~-1 ~ {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 4 setblock ~1 ~ ~ minecraft:redstone_lamp
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 5 summon armor_stand ~-2 ~-1 ~ {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute @e[tag=detector] ~ ~ ~ detect ~ ~ ~ wall_sign 5 setblock ~-1 ~ ~ minecraft:redstone_lamp
		echo execute @e[tag=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text1:"{\"text\":\"%ln1%\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"execute @e[tag=%value%,score_%value%=1] ~ ~ ~ execute @e[tag=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\"{\\\\\\\"text\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"scoreboard players set @e[tag=%value%] %value% 0\\\\\\\"}}\\\",Text4:\\\"[{\\\\\\\"text\\\\\\\":\\\\\\\"[ON]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"green\\\\\\\",\\\\\\\"bold\\\\\\\":false,\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"execute @e[tag=%value%] ~ ~ ~ setblock ~ ~1 ~ stone\\\\\\\"}},{\\\\\\\"text\\\\\\\":\\\\\\\"       \\\\\\\"},{\\\\\\\"text\\\\\\\":\\\\\\\"[OFF]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"red\\\\\\\",\\\\\\\"bold\\\\\\\":true}]\\\"}\"}}",Text2:"{\"text\":\"%ln2%\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"execute @e[tag=%value%,score_%value%=0] ~ ~ ~ execute @e[tag=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\"{\\\\\\\"text\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"scoreboard players set @e[tag=%value%] %value% 1\\\\\\\"}}\\\",Text4:\\\"[{\\\\\\\"text\\\\\\\":\\\\\\\"[ON]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"green\\\\\\\",\\\\\\\"bold\\\\\\\":true,\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"execute @e[tag=%value%] ~ ~ ~ setblock ~ ~1 ~ redstone_block\\\\\\\"}},{\\\\\\\"text\\\\\\\":\\\\\\\"       \\\\\\\"},{\\\\\\\"text\\\\\\\":\\\\\\\"[OFF]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"red\\\\\\\",\\\\\\\"bold\\\\\\\":false}]\\\"}\"}}",Text4:"[{\"text\":\"[ON]\",\"color\":\"green\",\"bold\":false},{\"text\":\"       \"},{\"text\":\"[OFF]\",\"color\":\"red\",\"bold\":true}]"}
		echo scoreboard players set @e[tag=%value%] %value% 0
		echo tellraw @s [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft %version%\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]
		echo kill @e[tag=detector]
	)>on-off_sign\%value%\%version%.mcfunction
	if %ver:~,4%==1.13 (
		echo gamerule commandBlockOutput false
		echo summon armor_stand ~ ~.5 ~ {NoGravity:1,Tags:[detector],Invisible:1}
		echo scoreboard objectives add %value% dummy
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign -1 summon armor_stand ~ ~ ~ {Marker:1,NoGravity:1,Invisible:1,Tags:[%value%S]}
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 2 summon armor_stand ~ ~ ~2 {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 2 setblock ~ ~ ~1 minecraft:redstone_lamp
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 3 summon armor_stand ~ ~ ~-2 {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 3 setblock ~ ~ ~1 minecraft:redstone_lamp
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 4 summon armor_stand ~2 ~ ~ {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 4 setblock ~ ~ ~1 minecraft:redstone_lamp
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 5 summon armor_stand ~-2 ~ ~ {Marker:1,NoGravity:1,Tags:[%value%]}
		echo execute at @e[tag=detector] detect ~ ~ ~ wall_sign 5 setblock ~ ~ ~1 minecraft:redstone_lamp
		echo execute at @e[tag=%value%S] blockdata ~ ~ ~ {Text1:"{\"text\":\"%ln1%\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"execute @e[tag=%value%,score_%value%=1] ~ ~ ~ execute @e[tag=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\"{\\\\\\\"text\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"scoreboard players set @e[tag=%value%] %value% 0\\\\\\\"}}\\\",Text4:\\\"[{\\\\\\\"text\\\\\\\":\\\\\\\"[ON]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"green\\\\\\\",\\\\\\\"bold\\\\\\\":false,\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"execute @e[tag=%value%] ~ ~ ~ setblock ~ ~1 ~ stone\\\\\\\"}},{\\\\\\\"text\\\\\\\":\\\\\\\"       \\\\\\\"},{\\\\\\\"text\\\\\\\":\\\\\\\"[OFF]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"red\\\\\\\",\\\\\\\"bold\\\\\\\":true}]\\\"}\"}}",Text2:"{\"text\":\"%ln2%\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"execute @e[tag=%value%,score_%value%=0] ~ ~ ~ execute @e[tag=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\"{\\\\\\\"text\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"scoreboard players set @e[tag=%value%] %value% 1\\\\\\\"}}\\\",Text4:\\\"[{\\\\\\\"text\\\\\\\":\\\\\\\"[ON]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"green\\\\\\\",\\\\\\\"bold\\\\\\\":true,\\\\\\\"clickEvent\\\\\\\":{\\\\\\\"action\\\\\\\":\\\\\\\"run_command\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"execute @e[tag=%value%] ~ ~ ~ setblock ~ ~1 ~ redstone_block\\\\\\\"}},{\\\\\\\"text\\\\\\\":\\\\\\\"       \\\\\\\"},{\\\\\\\"text\\\\\\\":\\\\\\\"[OFF]\\\\\\\",\\\\\\\"color\\\\\\\":\\\\\\\"red\\\\\\\",\\\\\\\"bold\\\\\\\":false}]\\\"}\"}}",Text4:"[{\"text\":\"[ON]\",\"color\":\"green\",\"bold\":false},{\"text\":\"       \"},{\"text\":\"[OFF]\",\"color\":\"red\",\"bold\":true}]"}
		echo scoreboard players set @e[tag=%value%] %value% 0
		echo tellraw @s [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft %version%\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]
		echo kill @e[tag=detector]
	)>on-off_sign\%value%\%version%.mcfunction
	if /I "%pause_end%"=="true" pause>nul
) else (
set pass8=,Riding:{id:MinecartCommandBlock,Command:"
set pass9={id:MinecartCommandBlock,Tags:[%value%],Command:"
set pass11={id:commandblock_minecart,Tags:[%value%],Command:"
set pass13={id:command_block_minecart,Tags:[%value%],Command:"
if /I %fac%==N (
	set z0=-1
	set z1=1
	set z2=3
	set z3=2
) else if /I %fac%==E (
	set x0=1
	set x1=-1
	set x2=-3
	set x3=-2
) else if /I %fac%==S (
	set z0=1
	set z1=-1
	set z2=-3
	set z3=-2
) else if /I %fac%==W (
	set x0=-1
	set x1=1
	set x2=3
	set x3=2
)
if %ver:~,3%==1.8 (
	echo summon MinecartCommandBlock ~!x0! ~2 ~!z0! {Command:"kill @e[type=MinecartCommandBlock,r=1]"!pass8!summon FallingSand ~!x0! ~ ~!z0! {TileID:152,Time:1,Riding:{id:FallingSand,TileID:137,Time:1,TileEntityData:{Command:\"fill ~ ~ ~ ~%x1% ~1 ~!z1! minecraft:air\"}}}"!pass8!summon ArmorStand ~%x1% ~ ~!z1! {NoGravity:1,CustomName:%value%S,Invisible:1}"!pass8!scoreboard players set @e[type=ArmorStand,name=%value%] %value% 0"!pass8!summon ArmorStand ~!x2! ~-1 ~!z2! {NoGravity:1,CustomName:%value%}"!pass8!blockdata ~%x1% ~ ~!z1! {Text1:\"{\\\"text\\\":\\\"%ln1:\=\\\\%\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[name=%value%,score_%value%=1] ~ ~ ~ execute @e[name=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[name=%value%] %value% 0\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[name=%value%] ~ ~ ~ setblock ~ ~1 ~ minecraft:stone\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"dark_red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true}]\\\\\\\"}\\\"}}\",Text2:\"{\\\"text\\\":\\\"%ln2:\=\\\\%\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[name=%value%,score_%value%=0] ~ ~ ~ execute @e[name=%value%S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[name=%value%] %value% 1\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[name=%value%] ~ ~ ~ setblock ~ ~1 ~ minecraft:redstone_block\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"dark_red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false}]\\\\\\\"}\\\"}}\"}"!pass8!scoreboard objectives add %value% dummy"!pass8!gamerule commandBlockOutput false"!pass8!setblock ~!x3! ~-1 ~!z3! minecraft:redstone_lamp"!pass8!tellraw @a [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft %version%\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]",Riding:{id:FallingSand,TileID:157,Time:1}}}}}}}}}}}> %file_name%
) else if %ver:~,3%==1.9 (
	echo summon FallingSand ~!x0! ~ ~!z0! {TileID:210,Time:1,Passengers:[{id:FallingSand,TileID:152,Time:1,Passengers:[{id:FallingSand,TileID:157,Time:1,Passengers:[{id:MinecartCommandBlock,Tags:[!value!],Command:"gamerule commandBlockOutput false"},{id:MinecartCommandBlock,Tags:[!value!],Command:"scoreboard objectives add !value! dummy"},{id:MinecartCommandBlock,Tags:[!value!],Command:"blockdata ~!x1! ~-1 ~!z1! {Text1:\"{\\\"text\\\":\\\"!ln1:\=\\\\!\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[tag=!value!,score_!value!=1] ~ ~ ~ execute @e[tag=!value!S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=!value!] !value! 0\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[tag=!value!] ~ ~ ~ setblock ~ ~1 ~ stone\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true}]\\\\\\\"}\\\"}}\",Text2:\"{\\\"text\\\":\\\"!ln2:\=\\\\!\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[tag=!value!,score_!value!=0] ~ ~ ~ execute @e[tag=!value!S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=!value!] !value! 1\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[tag=!value!] ~ ~ ~ setblock ~ ~1 ~ redstone_block\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false}]\\\\\\\"}\\\"}}\",Text4:\"[{\\\"text\\\":\\\"[ON]\\\",\\\"color\\\":\\\"green\\\",\\\"bold\\\":false},{\\\"text\\\":\\\"       \\\"},{\\\"text\\\":\\\"[OFF]\\\",\\\"color\\\":\\\"red\\\",\\\"bold\\\":true}]\"}"},{id:MinecartCommandBlock,Tags:[!value!],Command:"summon ArmorStand ~!x2! ~-2 ~!z2! {Marker:1,NoGravity:1,Tags:[!value!]}"},{id:MinecartCommandBlock,Tags:[!value!],Command:"summon ArmorStand ~!x1! ~-1 ~!z1! {Marker:1,NoGravity:1,Tags:[!value!S],Invisible:1}"},{id:MinecartCommandBlock,Tags:[!value!],Command:"setblock ~!x3! ~-1 ~!z3! minecraft:redstone_lamp"},{id:MinecartCommandBlock,Tags:[!value!],Command:"tellraw @a [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft !version!\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]"},{id:MinecartCommandBlock,Tags:[!value!],Command:"scoreboard players set @e[tag=!value!] !value! 0"},{id:MinecartCommandBlock,Tags:[!value!],Command:"blockdata ~ ~-2 ~ {Command:\"fill ~ ~ ~ ~ ~2 ~ air\"}"},{id:MinecartCommandBlock,Tags:[!value!],Command:"kill @e[tag=!value!,r=1]"}]}]}]}> %file_name%
) else if %ver:~,4%==1.11 (
	echo summon falling_block ~!x0! ~ ~!z0! {TileID:210,Time:1,Passengers:[{id:falling_block,TileID:152,Time:1,Passengers:[{id:falling_block,TileID:157,Time:1,Passengers:[{id:commandblock_minecart,Tags:[!value!],Command:"gamerule commandBlockOutput false"},{id:commandblock_minecart,Tags:[!value!],Command:"scoreboard objectives add !value! dummy"},{id:commandblock_minecart,Tags:[!value!],Command:"blockdata ~!x1! ~-1 ~!z1! {Text1:\"{\\\"text\\\":\\\"!ln1:\=\\\\!\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[tag=!value!,score_!value!=1] ~ ~ ~ execute @e[tag=!value!S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=!value!] !value! 0\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[tag=!value!] ~ ~ ~ setblock ~ ~1 ~ stone\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true}]\\\\\\\"}\\\"}}\",Text2:\"{\\\"text\\\":\\\"!ln2:\=\\\\!\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute @e[tag=!value!,score_!value!=0] ~ ~ ~ execute @e[tag=!value!S] ~ ~ ~ blockdata ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=!value!] !value! 1\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute @e[tag=!value!] ~ ~ ~ setblock ~ ~1 ~ redstone_block\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"       \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false}]\\\\\\\"}\\\"}}\",Text4:\"[{\\\"text\\\":\\\"[ON]\\\",\\\"color\\\":\\\"green\\\",\\\"bold\\\":false},{\\\"text\\\":\\\"       \\\"},{\\\"text\\\":\\\"[OFF]\\\",\\\"color\\\":\\\"red\\\",\\\"bold\\\":true}]\"}"},{id:commandblock_minecart,Tags:[!value!],Command:"summon armor_stand ~!x2! ~-2 ~!z2! {Marker:1,NoGravity:1,Tags:[!value!]}"},{id:commandblock_minecart,Tags:[!value!],Command:"summon armor_stand ~!x1! ~-1 ~!z1! {Marker:1,NoGravity:1,Invisible:1,Tags:[!value!S]}"},{id:commandblock_minecart,Tags:[!value!],Command:"setblock ~!x3! ~-1 ~!z3! minecraft:redstone_lamp"},{id:commandblock_minecart,Tags:[!value!],Command:"tellraw @a [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft !version!\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]"},{id:commandblock_minecart,Tags:[!value!],Command:"scoreboard players set @e[tag=!value!] !value! 0"},{id:commandblock_minecart,Tags:[!value!],Command:"blockdata ~ ~-2 ~ {Command:\"fill ~ ~ ~ ~ ~2 ~ air\"}"},{id:commandblock_minecart,Tags:[!value!],Command:"kill @e[tag=!value!,r=1]"}]}]}]}> %file_name%
) else if %ver:~,4%==1.13 (
	echo summon falling_block ~!x0! ~ ~!z0! {BlockState:{Name:repeating_command_block},Time:1,Passengers:[{id:falling_block,BlockState:{Name:stone},Time:-1,Passengers:[{id:falling_block,BlockState:{Name:redstone_block},Time:1,Passengers:[{id:falling_block,BlockState:{Name:stone},Time:-1,Passengers:[{id:falling_block,BlockState:{Name:activator_rail},Time:1,Passengers:[!pass13!gamerule commandBlockOutput false"},!pass13!scoreboard objectives add %value% dummy"},!pass13!data merge block ~!x1! ~-1 ~!z1! {Text1:\"{\\\"text\\\":\\\"%ln1:\=\\\\%\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute at @e[tag=%value%,scores={%value%=1..1}] at @e[tag=%value%S] run data merge block ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=%value%] %value% 0\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute at @e[tag=%value%] run setblock ~ ~1 ~ stone\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"      \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true}]\\\\\\\"}\\\"}}\",Text2:\"{\\\"text\\\":\\\"%ln2:\=\\\\%\\\",\\\"clickEvent\\\":{\\\"action\\\":\\\"run_command\\\",\\\"value\\\":\\\"execute at @e[tag=%value%,scores={%value%=0..0}] at @e[tag=%value%S] run data merge block ~ ~ ~ {Text3:\\\\\\\"{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"scoreboard players set @e[tag=%value%] %value% 1\\\\\\\\\\\\\\\"}}\\\\\\\",Text4:\\\\\\\"[{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[ON]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"green\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":true,\\\\\\\\\\\\\\\"clickEvent\\\\\\\\\\\\\\\":{\\\\\\\\\\\\\\\"action\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"run_command\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"execute at @e[tag=%value%] run setblock ~ ~1 ~ redstone_block\\\\\\\\\\\\\\\"}},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"      \\\\\\\\\\\\\\\"},{\\\\\\\\\\\\\\\"text\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"[OFF]\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"color\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"red\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\"bold\\\\\\\\\\\\\\\":false}]\\\\\\\"}\\\"}}\",Text4:\"[{\\\"text\\\":\\\"[ON]\\\",\\\"color\\\":\\\"green\\\",\\\"bold\\\":false},{\\\"text\\\":\\\"      \\\"},{\\\"text\\\":\\\"[OFF]\\\",\\\"color\\\":\\\"red\\\",\\\"bold\\\":true}]\"}"},!pass13!summon armor_stand ~!x2! ~-2 ~!z2! {Marker:1,NoGravity:1,Tags:[%value%]}"},!pass13!summon armor_stand ~!x1! ~-1 ~!z1! {Marker:1,NoGravity:1,Tags:[%value%S],Invisible:1}"},!pass13!setblock ~!x3! ~-1 ~!z3! minecraft:redstone_lamp"},!pass13!tellraw @a [{\"text\":\"\",\"color\":\"gold\",\"bold\":true},{\"text\":\"ON\",\"color\":\"green\",\"bold\":true},{\"text\":\" - \"},{\"text\":\"OFF\",\"color\":\"red\",\"bold\":true},{\"text\":\" signs for vanilla Minecraft %version%\",\"color\":\"gold\",\"bold\":true},{\"text\":\"\\n Generated by the \\\"ON-OFF signs generator 2.0\\\"\\n Get downloads and video tutorial on this \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"link\",\"bold\":false,\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://www.youtube.com\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"https://www.youtube.com\"}},{\"text\":\"\\n For help/infos and more: \",\"color\":\"dark_aqua\",\"bold\":false},{\"text\":\"\\u25BA\\u25BA\\u25BA dadib.official@gmail.com \\u25C4\\u25C4\\u25C4\",\"bold\":false}]]"},!pass13!scoreboard players set @e[tag=%value%] %value% 0"},!pass13!data merge block ~ ~-2 ~ {Command:\"fill ~ ~ ~ ~ ~2 ~ air\"}"},!pass13!kill @e[tag=%value%,type=command_block_minecart]"}]}]}]}]}]}> %file_name%
)
if /I "%pause_end%"=="true" pause>nul
if /I "%auto_open_end%"=="true" start %file_name%
)