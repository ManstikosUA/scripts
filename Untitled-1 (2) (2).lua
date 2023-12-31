script_name("LZHelper ")
script_version("31.12.2023")

local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = ""
        end
    end
end






require 'moonloader'
local ffi = require 'ffi'
require "lib.sampfuncs"

local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8








local keys = require 'vkeys'
local bNotf, notf = pcall(import, "imgui_notf.lua")


local main_window_state = imgui.ImBool(false)
local sobes_window_state = imgui.ImBool(false)

local text_buffer = imgui.ImBuffer(256)
local inputField = imgui.ImBuffer(256)

local inicfg = require 'inicfg'

local directIni = "moonloader\\pdhelperManstikosUA.ini"

local mainIni = inicfg.load(nil, directIni)
--local stateIni = inicfg.save(main.Ini, directIni)
local tab = 1 -- � ���� ���������� ����� �������� ����� �������� �������

local data =
{                                                                                                                         -- ������ �������� ��� data.** �� ������, ���� ����������� ������� ���� �������
    config =
        {
        rusname = u8"��� �������",
                rang = u8"����"
    }
}
-----------------����
local themes = import 'resource/LZHelper/imgui_themes.lua'
-- radiobutton
local checked_radio = imgui.ImInt(1)


------------------------
local mainIni = inicfg.load(data, 'moonloader\\pdhelperManstikosUA.ini') -- ��������� ������
if mainIni == nil then -- ���������, ��� �� � �������. ���� ��� - ������� ������ �� �������� ��������, ����� - ���������
    print('�� ������ ���� �������, ������.')
    if inicfg.save(mainIni, 'moonloader\\pdhelperManstikosUA.ini') then
        print('���� ��� � ����������� ��� ������, ������ ���.')
        mainIni = inicfg.load(nil, 'moonloader\\pdhelperManstikosUA.ini')
    end
end


local maxChars = 256
local MultiLineChars = 1024
local rusname = imgui.ImBuffer(u8:encode(mainIni.config.rusname), maxChars)
local rang = imgui.ImBuffer(u8:encode(mainIni.config.rang), maxChars)

local sobes_privet = imgui.ImBuffer(u8:encode(mainIni.sobes.sobes_privet), maxChars)
local sobes_doki = imgui.ImBuffer(u8:encode(mainIni.sobes.sobes_doki), MultiLineChars)

local sobestab = 1




------------------------------------------------------------------------
function main()
    while not isSampAvailable() do wait(0) end
    local mainIni = inicfg.load(nil, directIni)

    imgui.Process= false

    imgui.SwitchContext()
    themes.SwitchColorTheme()
-----------------------------------------------------------------------------
        sampRegisterChatCommand("udost", cmd_udost)
        sampRegisterChatCommand("pas", cmd_pas)
        sampRegisterChatCommand("lics", cmd_lics)
        sampRegisterChatCommand("medka", cmd_medka)
        sampRegisterChatCommand("lzmenu", cmd_lzmenu)
        sampRegisterChatCommand("cuff", cmd_cuff)
        sampRegisterChatCommand("gotome", cmd_gotome)
        sampRegisterChatCommand("cput", cmd_cput)
        sampRegisterChatCommand("bodycam", cmd_bodycam)
        sampRegisterChatCommand("ticket", cmd_ticket)
        sampRegisterChatCommand("frisk", cmd_frisk)
        sampRegisterChatCommand("arrest", cmd_arrest)
        sampRegisterChatCommand("mask", cmd_mask)
        sampRegisterChatCommand("uncuff", cmd_uncuff)
        sampRegisterChatCommand("su", cmd_su)
        sampRegisterChatCommand("clear", cmd_clear)
        sampRegisterChatCommand("doki", cmd_doki)
        sampRegisterChatCommand("setcity", cmd_setcity )
        sampRegisterChatCommand("setnamesurname", cmd_setnamesurname)
        sampRegisterChatCommand("meg", cmd_meg)
        sampRegisterChatCommand("statistiko", cmd_statistiko)
        sampRegisterChatCommand("setz", cmd_setz)
        sampRegisterChatCommand("drugs", cmd_drugs)
        sampRegisterChatCommand("ecspertiza", cmd_ecspertiza)
        sampRegisterChatCommand("chatclear", cmd_chatclear)
        sampRegisterChatCommand("prin", cmd_prin)
        sampRegisterChatCommand("prin1", cmd_prin1)
        sampRegisterChatCommand("prin2", cmd_prin2)
        sampRegisterChatCommand("prin3", cmd_prin3)
        sampRegisterChatCommand("prin4", cmd_prin4)
        sampRegisterChatCommand("vig", cmd_vig)
        sampRegisterChatCommand("uninvite", cmd_uninvite)
        sampRegisterChatCommand("invite", cmd_invite)
        sampRegisterChatCommand("setpaswrld", cmd_setpaswrld)
        sampRegisterChatCommand("ssobes", cmd_ssobes)
        
------------------------------------------------------------------------
        sampAddChatMessage('����������� ������ ��� ������ ������.������ ��������� � ����������', 0x03fc7b)
        sampAddChatMessage('{03fc7b}- �������. ������� {fc035e}ManstikosUA', -1)
        sampAddChatMessage('{10a2e0}����� �������� ���������� �������: {ffffff}/phelp  ;', -1)

----------------------------------------------------------------------------------------------------

    _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)


-----------------------------------------------------------------------------------------------------
    
    
    while true do
        wait(0)
        

    end
end







    function cmd_setpaswrld(arg)
    if arg == "" then
        sampAddChatMessage('������ ������� ������ �����!', 0xfc5603)
    else
        mainIni.ac.password = arg
        if inicfg.save(mainIni, directIni) then
            sampAddChatMessage('�������! ������ ��� ����� ������ ��� �������� �����: {10a2e0}' .. mainIni.ac.password, -1)
        end
    end
end

function onReceiveRpc(id,bitStream)
    if id == 61 then
        dialogId = raknetBitStreamReadInt16(bitStream)
        style = raknetBitStreamReadInt8(bitStream)
        str = raknetBitStreamReadInt8(bitStream)
        title = raknetBitStreamReadString(bitStream, str)
        if title:find("�����������") then sampSendDialogResponse(dialogId,1,0, mainIni.ac.password)
            sampSendChat("/enter")
        end
    end 
end
    
---------------------------------------------------------------------------------------------------------------------
local function sendMessage(message, delay)
    lua_thread.create(function()
        wait(delay)
        sampSendChat(message)
    end)
end
------------------------------------------------------------------------------------------------------




function cmd_udost(arg)
    sendMessage("/me � ������� ����� �������������", 0)
    sendMessage("/me ����� ���� � ������", 1500)
    sendMessage("/me ����� ��������� ���� ������ ������������� �� �������", 3000)
    sendMessage("/do ������������� � �����.", 4500)
    sendMessage("/me ������� ������������� �������� ���������", 6000)
    lua_thread.create(function()
        wait(7500)
        sampAddChatMessage('��������� ������������� �������.', -1)
    end)
end
-------------------------------------------------------------------------------------------------------
function cmd_pas(arg)
    sendMessage("/me � ������� ����� �������", 0)
    sendMessage("/me ����� ���� � ������", 1500)
    sendMessage("/me ����� ��������� ���� ������ ������� �� �������", 3000)
    sendMessage("/do ������� � �����.", 4500)
    sendMessage("/me ������� ������� �������� ��������", 6000)
    sendMessage("/showpass " .. arg, 7000)
    lua_thread.create(function()
        wait(7500)
    end)
end
-------------------------------------------------------------------------------------------------------------
function cmd_lics(arg)
    sendMessage("/me � ������� ����� ����� ��������", 0)
    sendMessage("/me ����� ���� � ������", 1500)
    sendMessage("/me ����� ��������� ���� ������ ����� �������� �� �������", 3000)
    sendMessage("/do ����� �������� � ����� � �����.", 4500)
    sendMessage("/me ������� ����� �������� �������� ��������", 6000)
    sendMessage("/showlicenses " .. arg, 7000)
    lua_thread.create(function()
        wait(7500)
    end)
end
------------------------------------------------------------------------------------------------------

function cmd_medka(arg)
    sendMessage("/me � ������� ����� ���.�����")
    sendMessage("/me ����� ���� � ������", 1500)
    sendMessage("/me ����� ��������� ���� ������ ���.����� �� �������", 3000)
    sendMessage("/do ���.����� � �����.", 4500)
    sendMessage("/me ������� ���.����� �������� ��������", 6000)
    lua_thread.create(function()
        wait(7500)
        sampAddChatMessage('��������� ����� ������� �������.', -1)
    end)
end
---------------------------------------------------------------------------------------------------------
function cmd_lzmenu(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function cmd_ssobes(arg)
    sobes_window_state.v = not sobes_window_state.v
    imgui.Process = sobes_window_state.v
end

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end


------------------------------------------------------------------------
local fontsize = nil
function imgui.BeforeDrawFrame()
    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 10.5, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) 
    end
end
------------------------------------------------------------------------------


function imgui.OnDrawFrame()
    if main_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 300), imgui.Cond.Always)
        imgui.Begin(u8'������', WinState, imgui.WindowFlags.NoResize)
        for numberTab,nameTab in pairs({'��������','�������������','���������','����'}) do -- ������ � ������ ������� � ���������� ������� �������
            if imgui.Button(u8(nameTab), imgui.ImVec2(100,50)) then -- 2�� ���������� ������������� ������ ������ (��������� � ����� �� ������)
                tab = numberTab -- ������ �������� ���������� tab �� ����� ������� ������
            end
        end
        imgui.SetCursorPos(imgui.ImVec2(120, 28)) -- [��� ������] ������������� ������� ��� ������ ����
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(555, 250), true) then -- [��� ������] ������ ����� � ������� �������� ����������
            -- == [��������] ���������� ������� == --

            
            if tab == 1 then -- ���� �������� tab == 1
                -- == ���������� ������� �1
                imgui.Text(u8'������� ������ ������� "��������"')
                imgui.Text(u8"��� ��� (RUS): ")
                if imgui.InputText(u8'', rusname, imgui.InputTextFlags.None, nil, nil, maxChars) then
                    mainIni.config.rusname = u8:decode(rusname.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA.ini")
                end
            imgui.Text(u8"���� ���������: ")
        if imgui.InputText(u8' ', rang, imgui.InputTextFlags.None, nil, nil, maxChars) then
            mainIni.config.rang = u8:decode(rang.v)
            inicfg.save(mainIni, "pdhelperManstikosUA.ini")
        end
        if imgui.Button(u8"���������", imgui.ImVec2(100, 20)) then
            mainIni.config.rusname = u8:decode(rusname.v)
            mainIni.config.rang = u8:decode(rang.v)
            sampAddChatMessage("{FFFFFF}�� ������� �������� ��� ��:{00BFFF} " .. u8:decode(rusname.v), -1)
            sampAddChatMessage("{FFFFFF}��� ����:{00BFFF} " .. u8:decode(rang.v), -1)
            if inicfg.save(mainIni, directIni) then
                sampAddChatMessage("���������! 2", -1)
            end
        end
                if imgui.Button(u8'������') then
                    sampAddChatMessage('�� ������ ������ �� ������� ����� '..tab, -1)
                end
    
    -------------------������� 3
            elseif tab == 2 then
                imgui.CenterText("��������� ������ ��� �������������")
                imgui.Text(u8"������� ����� ��� �����������:")
                if imgui.InputText("  ", sobes_privet, imgui.InputTextFlags.None, nil, nil, maxChars) then
                    mainIni.sobes.sobes_privet = u8:decode(sobes_privet.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA.ini")
                end
                if imgui.Button(u8"������� � ���") then
                    sampSendChat(u8:decode(sobes_privet.v))
                end
                imgui.Text(u8"����� ��� ����������:")
                imgui.Text(u8"��� ��� ��� �������� ���������� ������")
                if imgui.InputTextMultiline('#sobes_dokitext', sobes_doki) then
                    mainIni.sobes.sobes_doki = u8:decode(sobes_doki.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA")
                end
                
                if imgui.Button(u8"���������") then
                    mainIni.sobes.sobes_privet = u8:decode(sobes_privet.v)
                    mainIni.sobes.sobes_doki = u8:decode(sobes_doki.v)
                    if inicfg.save(mainIni, directIni) then
                        sampAddChatMessage('������� ���������!', -1)
                    end
                    
                end
                
            elseif tab == 3 then -- ���� �������� tab == 2
                -- == ���������� ������� �2
                imgui.Text(u8'������� ������ ������� "���������"')
                imgui.BeginChild("themespon", imgui.ImVec2(200, 175), true)
                    for i, value in ipairs(themes.colorThemes) do
                        if imgui.RadioButton(value, checked_radio, i) then
                            themes.SwitchColorTheme(i)
                        end
                    end
                    imgui.EndChild()
                if imgui.Button(u8'������') then
                    sampAddChatMessage('�� ������ ������ �� ������� ����� '..tab, -1)
                end
            elseif tab == 4 then -- ���� �������� tab == 3
                -- == ���������� ������� �3
                imgui.Text(u8'������� ������ ������� "����"')
                imgui.Text(u8"������� /pas - ���������� ������� (/pas ID)")
                imgui.Text(u8"������� /lics - ���������� ��������(/lics ID)")
                imgui.Text(u8"������� /medka - ���������� �� ��� ���.�����(���������� ����� �������)")
                imgui.Text(u8"������� /udost - ���������� �� ��� �������������(���������� ����� �������)")
                imgui.Text(u8"������� /cuff - ������ �� ������ ���������, ���� ���������(/cuff ID)")
                imgui.Text(u8"������� /gotome - �������� ������ �� �����, ���� ���������(/gotome ID)")
                imgui.Text(u8"������� /cput - �������� ������ � ������, ���� ���������(/cput ID)")
                imgui.Text(u8"������� /bodycam - �������� ��������� ������")
                imgui.Text(u8"������� /ticket - ��������� �� ��� ������� + ������� ������(/ticket ID)")
                imgui.Text(u8"������� /frisk - ��������� �� ��� ������ + �����(/frisk ID)")
                imgui.Text(u8"������� /arrest - ��������� ������ + �����(/arrest ID)")
                imgui.Text(u8"������� /uncuff - ����� ��������� + ���������(/uncuff ID)")
                imgui.Text(u8"������� /su - ������ ������ + ���������(/su ID)")
                imgui.Text(u8"������� /clear - �������� ������ + ���������(/clear ID)")
                imgui.Text(u8"������� /doki - ��������� ���������(/doki ID)")
                imgui.Text(u8"������� /meg - ������� ���������� ������ � �������(/meg)")
                imgui.Text(u8"������� /setpaswrld - ���������� ������ ��� �������� ������")
                imgui.Text(u8"������� /chatclear - ��������� �������� ���")
                imgui.Text(u8"������� /ecspertiza - ��������� �� ����������")
                imgui.Text(u8"������� /drug ���������� - ���������� ��������� � ��")
                imgui.Text(u8"������ ������� L.ALT - ������+�����������")
                imgui.Text(u8"������� /statistiko - ������� ���������� ���������")
    
                if imgui.Button(u8'������') then
                    sampAddChatMessage('�� ������ ������ �� ������� ����� '..tab, -1)
                end
            end
            -- == [��������] ���������� ������� ����������� == --
            imgui.EndChild()
        end
        imgui.End()   
    end
    

    if sobes_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(1100, 800), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 300), imgui.Cond.Always)
        imgui.Begin(u8'���� �������������', WinState, imgui.WindowFlags.NoResize)
        imgui.CenterText(u8"��� ������������?")
        imgui.PushFont(fontsize)
            imgui.Text(u8'������� �� ������� "�����������", \n����� ������� ���� � ������������. \n����� ������� ����������� - "�������"')
        imgui.PopFont()
        imgui.Separator()
        -----------------------------------------------
        if imgui.Button(u8'�����������', imgui.ImVec2(0,0)) then
            sobestab = 1
        end
    
        imgui.SameLine()
        if imgui.Button(u8'sobestipo', imgui.ImVec2(0,0)) then
            sobestab = 2
        end

        if imgui.Button(u8"�����", imgui.ImVec2(0,0)) then
            sobestab = 3
        end

        imgui.SameLine()
        if imgui.Button(u8"��������", imgui.ImVec2(0,0)) then
            sobestab = 4
        end


        imgui.Separator()
        ------------------------------------------------
        for numberTab,nameTab in pairs({'�����������', '���������', '�����', '��������'}) do -- ������ � ������ ������� � ���������� ������� �������
            if imgui.Button(u8(nameTab), imgui.ImVec2(0.1,0.1)) then
                sobestab = numberTab -- ������ �������� ���������� tab �� ����� ������� ������
            end
        end

            -- == [��������] ���������� ������� == --
        if sobestab == 1 then -- ���� �������� tab == 1
            imgui.PushFont(fontsize)
            imgui.Text(u8"�����, ������� ����� ���������:")
            imgui.Text(u8(mainIni.sobes.sobes_privet))
            imgui.PopFont()

            
        -----2 �������
            imgui.SameLine() 
        elseif sobestab == 2 then
            imgui.Text("sss 2")

        elseif sobestab == 3 then
            imgui.Text("da ya nigers")
        end



        imgui.End()
    end
end

function cmd_cuff (arg)
    sendMessage("/me ���� � ����� ��������� � ����� �� �� �����������", 0)
    sendMessage("/cuff " .. arg, 1000)
    lua_thread.create(function()
        wait(7500)
    end)
end

---------------------------------------------------------------------------------------------------------

function cmd_gotome(arg)
    sendMessage("/me ������� ����������� �� ����, � ���� �� �����", 0)
    sendMessage("/gotome " .. arg, 1000)
    lua_thread.create(function()
        wait(7500)        
    end)
end

function cmd_cput(arg)
    sendMessage("/me ������ ����� � ����������", 0)
    sendMessage("/do ����� ���������� �������.", 1500)
    sendMessage("/me ������ ������ ����������� ����, ����� ���� ������� ��� � ����������", 2500)
    sendMessage("/cput " .. arg, 3500)
end


function cmd_bodycam()
    sendMessage("/do �� ����� ����� ������� ����-������.", 0)
    sendMessage("/do �� ����-������ ��������� ������ ��������� ������.", 1500)
    sendMessage("/me ������� ����, ������ ��������� ������� ����� �� ������ ������", 2500)
    sendMessage("/do ����-������ ���� ������.", 3500)
end

function cmd_ticket(arg)

    sendMessage("/do ����� � ������ � �����.", 0)
    sendMessage("/me ��������� �����, �������� ��� ����������", 1500)
    sendMessage("/todo �����������.*��������� ����� ��������", 2500)
    sendMessage("/do ����� �� ����� � ��������.", 3500)
    sendMessage("/todo ������*��������� ����� ����������", 4500)
    sendMessage("/ticket " .. arg, 5500)
end

function cmd_frisk(arg)
    sendMessage("/me ����� ��������, � ����� ���������� ���� ��������������", 0)
    sendMessage("/frisk " .. arg, 1500)
end

function cmd_arrest(arg) 
    sendMessage("/do ����� �� �����.", 0)
    sendMessage("/me ������ ����� � �����, ������ � �������� �����������.", 1500)
    sendMessage("/do �����������: �������, �������� ���� ��������.", 2500)
    sendMessage("/do �� ������� ������� 2 �������, ����� �������� �����������.", 3500)
    sendMessage("/me ��������� �������� �����������", 4500)
    sendMessage("/arrest " .. arg, 5500)
end

function cmd_mask()
    sendMessage("/me ���� ����� � �����, ���������� ������ �����, � ����� ���������� � � ������� ���������", 0)
    sendMessage("/me ������� �����, ������� ������ �����, ����� ������� � �� �����", 1500)
    sendMessage("/me ���������� ������, ������� ������� �� ����� �����", 2500)
    sendMessage("/do � ���� ��������� ������� �����.", 3500)
    sendMessage("/me ����� �� ������ ���������", 4500)
    sendMessage("/mask", 5500)
end

function cmd_uncuff(arg)
    sendMessage("/do ��������� ���������� �� �������� ��������.", 0)
    sendMessage("/do ���� � ������ �������.", 1500)
    sendMessage("/me ������ ��������� ���� ������� ���� �� �������", 2500)
    sendMessage("/do ���� � �����.", 3500)
    sendMessage("/me ������� ���� � ���������", 4500)
    sendMessage("/do ���� � �����.", 5500)
    sendMessage("/me ��������� ���� � ������ �����", 6500)
    sendMessage("/uncuff " .. arg, 7500)
    sendMessage("/do ��������� ����������.", 8500)
end

function cmd_su(arg)
    sendMessage("/su " .. arg, 0)
    sendMessage("/do ���� ��� � �����.", 1500)
    sendMessage("/me ����� � ���� ������ �����", 2500)
    sendMessage("/me ������� �������� � ������", 3500)
    sendMessage("/me ����� ���� ���", 4500)
end

function cmd_clear(arg)
    sendMessage("/do ���� ��� ��������� �� �����.", 0)
    sendMessage("/me ���� ���� ��� � �����", 1500)
    sendMessage("/do ���� ��� � �����.", 2500)
    sendMessage("/me ����� � ���� ������ �����", 3500)
    sendMessage("/me ������������ ����� ���������� � ����������", 4500)
    sendMessage("/do �������...", 5500)
    sendMessage("/do ������ �������.", 6500)
    sendMessage("/me ������� ���������� � �������", 7500)
    sendMessage("/do �������...", 8500)
    sendMessage("/clear " .. arg, 9500)
    sendMessage("/do ���������� � ������� �����.", 10500)
end

function cmd_doki(arg)
    sendMessage("������������, � ��������� " .. "*" .. mainIni.config.city .. "*" ..  " - *" .. mainIni.config.namesurname .. "*.", 0)
    sendMessage("/do ������������� � ����� ������� ����.", 1500)
    sendMessage("/me ������ �������������, ������� ��� ����� ���������", 2500)
    sendMessage("/showudost " .. arg, 3500)
    sendMessage("������ ������������ ���� ��������� ��� ������������� ����� ��������?", 4500)
end

function cmd_setcity(arg)
    mainIni.config.city = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('����� ������� ���������� �� {10a2e0}' .. mainIni.config.city, -1)
    end
end

function cmd_setnamesurname(arg)
    mainIni.config.namesurname = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('��� � ������� ������� ����������� �� {10a2e0}' .. mainIni.config.namesurname, -1)
    end
end

function cmd_meg()
    sendMessage("/m �������� ����������!", 0)
    sendMessage("/m ���������� ���������� ������ � ��������� ���������!", 1500)
    sendMessage("/m � ������ ������������ - �� ������� �����!", 2500)
end

function cmd_statistiko()
    notf.addNotification("              Untitled-1.LUA     \n   ��� ���: " .. nick .. "  " .. "\n   ��� ID: " .. id .. " ", 99999999, 4)
end

function cmd_setz(arg)
    mainIni.config.z = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('+', -1)
    end
end

function cmd_drugs(arg)
    sendMessage("/usedrugs " .. arg, 0)
    sendMessage("/do � ������� ����� �������� �� ������", 1500)
    sendMessage("/me ����� ���� � ������, ������ ��������", 2500)
    sendMessage("/me ������� ��������", 3500)
end

function cmd_ecspertiza()
    sendMessage("/me ������� � �����, ������ ��� � �������� ���������� �����", 0)
    sendMessage("/do � ����� ��������� ������ �������� � �������� ��� ���������� ����������� �������.", 1500)
    sendMessage("/me �������� ���� � �����, ���� � ����� ���� �������� � ������� HNO3", 2500)
    sendMessage("/me ������� � �����, ������� �������� � ��������� �� ����, � ����������� �� ���������� ���� ��", 3500)
    sendMessage("/me �������� ���������, ���� �������� � ������� �� � ��������� ���������", 4500)
    sendMessage("/me ���� ������� ��������� �������� ������ � ���� ������� �������� HNO3 � ��������, �������� �������", 5500)
    sendMessage("/do � �������� ����� ������� �����-�������� �����.", 6500)
    sendMessage("/do �� ����� ����� ������� � ����� ���������, � ���� �������.", 7500)
    sendMessage("/me ���� ����� � ��������� �� �����, ������ ��� �� ������� ���� � ������� ���������", 8500)
    sendMessage("/me ������ ������� ������� ��������� ���������� �������� � ������� HNO3", 9500)
    sendMessage("/me ���������� � ��������, ����������� ������ �� ��������", 10500)
    sendMessage("/do ������ ���� ����� �������� � �������� ���� �������-�������� �����.", 11500)
    sendMessage("/do � �������� ���������� ����� ��������� � ����-����������.", 12500)
    sendMessage("/me ������ ������ ���������� � ���������", 13500)
    sendMessage("/me ������ ������� ������, � ������ � ������ � �����������", 14500)
    sendMessage("/do ������ � �������: �������� �������� �������������.", 15500)
end


function cmd_chatclear()
    for i =1, 25 do
        sampAddChatMessage("", -1)
    end
    sampAddChatMessage('ChatClear -------ManstikosUA', -1)
end


function cmd_prin()
    sendMessage("������������, �� ������ �� �������������?", 0)
end

function cmd_prin1()
    sendMessage("�������, ����� ��� ����������� ��� ������� � ��������", 0)
    sendMessage("�� ������ ���, � ������ ���� � ����������� ����� ��������,", 1500)
    sendMessage("�� � ������ �������� ���", 2500)
    sendMessage("/b ���������� ����� �� �� (/pass | /sl)", 3500)
end

function cmd_prin2()
    sendMessage("������ ,� ����������� �� � �������.", 0)
    sendMessage("������ ������� ����������, ������ �� ������ �������� � ���?", 1500)
end

function cmd_prin3()
    sendMessage("����, ��� �� ��������� ����� ��", 0)
    sendMessage("��� ��������� ������, ����� �������� � ����� ��� �������", 1500)
end

function cmd_prin4()
    sendMessage("�������! � �����, �� ��� ���������!", 0)
    sendMessage("��������� �������, ������ � ����� ��� ������", 1500)
end

----------------------------------------------------------------------------------------------------------------------------
function cmd_vig(arg)
    sendMessage("/do ������� � ������ � ������ �������.", 0)
    sendMessage("/me ������ ��������� ���� ������� ������� � ������ �� �������", 1500)
    sendMessage("/do ������� � ����� � �����.", 2550)
    sendMessage("/me ������ ��� ���������� � �������", 3550)
    sendMessage("/do �������...", 4550)
    sendMessage("/vig " .. arg, 5600)
    sendMessage("/do ������ �������.", 6550)
    sendMessage("/me ����� ������� � ����� � ������",7550)
    sendMessage("/do �������������� ������.", 8550)
end

function cmd_uninvite(arg) 
    sendMessage("/do ���� ��� ��������� �� �����.", 0)
    sendMessage("/me ���� ���� ��� � �����", 1550)
    sendMessage("/do ���� ��� � �����.", 2550)
    sendMessage("/me ����� � ���� ������ � ����� �������� ������ � ����������", 3550)
    sendMessage("/do �������...", 4550)
    sendMessage("/uninvite " .. arg, 5550)
    sendMessage("/do ������ � ���������� ��������.", 6550)
    sendMessage("/me �������� ���� ��� �� �����", 7550)
end

function cmd_invite(arg) 
    sendMessage("/me ������ ����� � ������ ���������������", 0)
    sendMessage("/me ������� �� �������� ���������", 1500)
    sendMessage("/invite " .. arg, 2500)
end
