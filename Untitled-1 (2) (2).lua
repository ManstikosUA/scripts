script_name("LZHelper ")
script_version("31.12.2023")

local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
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
local tab = 1 -- в этой переменной будет хранится номер открытой вкладки

local data =
{                                                                                                                         -- задаем значения для data.** на случай, если потребуется создать файл конфига
    config =
        {
        rusname = u8"Имя Фамилия",
                rang = u8"Ранг"
    }
}
-----------------темы
local themes = import 'resource/LZHelper/imgui_themes.lua'
-- radiobutton
local checked_radio = imgui.ImInt(1)


------------------------
local mainIni = inicfg.load(data, 'moonloader\\pdhelperManstikosUA.ini') -- загружаем конфиг
if mainIni == nil then -- проверяем, все ли в порядке. Если нет - создаем конфиг из заданных значений, иначе - загружаем
    print('Не найден файл конфига, создаю.')
    if inicfg.save(mainIni, 'moonloader\\pdhelperManstikosUA.ini') then
        print('Файл был с настройками был создан, ошибок нет.')
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
        sampAddChatMessage('Простенький скрипт для слабых компов.Только отыгровки и инструкция', 0x03fc7b)
        sampAddChatMessage('{03fc7b}- запущен. Написал {fc035e}ManstikosUA', -1)
        sampAddChatMessage('{10a2e0}Чтобы прочесть инструкцию введите: {ffffff}/phelp  ;', -1)

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
        sampAddChatMessage('Нельзя вводить пустой текст!', 0xfc5603)
    else
        mainIni.ac.password = arg
        if inicfg.save(mainIni, directIni) then
            sampAddChatMessage('Успешно! Теперь ваш новый пароль для быстрого входа: {10a2e0}' .. mainIni.ac.password, -1)
        end
    end
end

function onReceiveRpc(id,bitStream)
    if id == 61 then
        dialogId = raknetBitStreamReadInt16(bitStream)
        style = raknetBitStreamReadInt8(bitStream)
        str = raknetBitStreamReadInt8(bitStream)
        title = raknetBitStreamReadString(bitStream, str)
        if title:find("Авторизация") then sampSendDialogResponse(dialogId,1,0, mainIni.ac.password)
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
    sendMessage("/me в кармане лежит удостоверение", 0)
    sendMessage("/me сунул руку в карман", 1500)
    sendMessage("/me лёгким движением руки достал удостоверение из кармана", 3000)
    sendMessage("/do Удостоверение в руках.", 4500)
    sendMessage("/me передал удостоверение человеку навпротив", 6000)
    lua_thread.create(function()
        wait(7500)
        sampAddChatMessage('передайте удостоверение вручную.', -1)
    end)
end
-------------------------------------------------------------------------------------------------------
function cmd_pas(arg)
    sendMessage("/me в кармане лежит паспорт", 0)
    sendMessage("/me сунул руку в карман", 1500)
    sendMessage("/me лёгким движением руки достал паспорт из кармана", 3000)
    sendMessage("/do Паспорт в руках.", 4500)
    sendMessage("/me передал паспорт человеку напротив", 6000)
    sendMessage("/showpass " .. arg, 7000)
    lua_thread.create(function()
        wait(7500)
    end)
end
-------------------------------------------------------------------------------------------------------------
function cmd_lics(arg)
    sendMessage("/me в кармане лежит пакет лицензий", 0)
    sendMessage("/me сунул руку в карман", 1500)
    sendMessage("/me лёгким движением руки достал пакет лицензий из кармана", 3000)
    sendMessage("/do Пакет лицензий в руках в руках.", 4500)
    sendMessage("/me передал пакет лицензий человеку напротив", 6000)
    sendMessage("/showlicenses " .. arg, 7000)
    lua_thread.create(function()
        wait(7500)
    end)
end
------------------------------------------------------------------------------------------------------

function cmd_medka(arg)
    sendMessage("/me в кармане лежит мед.карта")
    sendMessage("/me сунул руку в карман", 1500)
    sendMessage("/me лёгким движением руки достал мед.карту из кармана", 3000)
    sendMessage("/do Мед.карта в руках.", 4500)
    sendMessage("/me передал мед.карту человеку напротив", 6000)
    lua_thread.create(function()
        wait(7500)
        sampAddChatMessage('передайте медку вручную вручную.', -1)
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
        imgui.Begin(u8'Пример', WinState, imgui.WindowFlags.NoResize)
        for numberTab,nameTab in pairs({'Основное','Собеседование','Настройки','Инфа'}) do -- создаём и парсим таблицу с названиями будущих вкладок
            if imgui.Button(u8(nameTab), imgui.ImVec2(100,50)) then -- 2ым аргументом настраивается размер кнопок (подробнее в гайде по мимгуи)
                tab = numberTab -- меняем значение переменной tab на номер нажатой кнопки
            end
        end
        imgui.SetCursorPos(imgui.ImVec2(120, 28)) -- [Для декора] Устанавливаем позицию для чайлда ниже
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(555, 250), true) then -- [Для декора] Создаём чайлд в который поместим содержимое
            -- == [Основное] Содержимое вкладок == --

            
            if tab == 1 then -- если значение tab == 1
                -- == Содержимое вкладки №1
                imgui.Text(u8'Открыта первая вкладка "Основное"')
                imgui.Text(u8"Ваш ник (RUS): ")
                if imgui.InputText(u8'', rusname, imgui.InputTextFlags.None, nil, nil, maxChars) then
                    mainIni.config.rusname = u8:decode(rusname.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA.ini")
                end
            imgui.Text(u8"Ваша должность: ")
        if imgui.InputText(u8' ', rang, imgui.InputTextFlags.None, nil, nil, maxChars) then
            mainIni.config.rang = u8:decode(rang.v)
            inicfg.save(mainIni, "pdhelperManstikosUA.ini")
        end
        if imgui.Button(u8"Сохранить", imgui.ImVec2(100, 20)) then
            mainIni.config.rusname = u8:decode(rusname.v)
            mainIni.config.rang = u8:decode(rang.v)
            sampAddChatMessage("{FFFFFF}Вы успешно изменили ник на:{00BFFF} " .. u8:decode(rusname.v), -1)
            sampAddChatMessage("{FFFFFF}Ваш ранг:{00BFFF} " .. u8:decode(rang.v), -1)
            if inicfg.save(mainIni, directIni) then
                sampAddChatMessage("Сохранено! 2", -1)
            end
        end
                if imgui.Button(u8'Кнопка') then
                    sampAddChatMessage('Вы нажали кнопку во вкладке номер '..tab, -1)
                end
    
    -------------------вкладка 3
            elseif tab == 2 then
                imgui.CenterText("Настройка текста для собеседования")
                imgui.Text(u8"Введите текст для приветствия:")
                if imgui.InputText("  ", sobes_privet, imgui.InputTextFlags.None, nil, nil, maxChars) then
                    mainIni.sobes.sobes_privet = u8:decode(sobes_privet.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA.ini")
                end
                if imgui.Button(u8"Вывести в чат") then
                    sampSendChat(u8:decode(sobes_privet.v))
                end
                imgui.Text(u8"Текст для документов:")
                imgui.Text(u8"Это уже для большого количества текста")
                if imgui.InputTextMultiline('#sobes_dokitext', sobes_doki) then
                    mainIni.sobes.sobes_doki = u8:decode(sobes_doki.v)
                    inicfg.save(mainIni, "pdhelperManstikosUA")
                end
                
                if imgui.Button(u8"Сохранить") then
                    mainIni.sobes.sobes_privet = u8:decode(sobes_privet.v)
                    mainIni.sobes.sobes_doki = u8:decode(sobes_doki.v)
                    if inicfg.save(mainIni, directIni) then
                        sampAddChatMessage('Успешно сохранено!', -1)
                    end
                    
                end
                
            elseif tab == 3 then -- если значение tab == 2
                -- == Содержимое вкладки №2
                imgui.Text(u8'Открыта первая вкладка "Настройки"')
                imgui.BeginChild("themespon", imgui.ImVec2(200, 175), true)
                    for i, value in ipairs(themes.colorThemes) do
                        if imgui.RadioButton(value, checked_radio, i) then
                            themes.SwitchColorTheme(i)
                        end
                    end
                    imgui.EndChild()
                if imgui.Button(u8'Кнопка') then
                    sampAddChatMessage('Вы нажали кнопку во вкладке номер '..tab, -1)
                end
            elseif tab == 4 then -- если значение tab == 3
                -- == Содержимое вкладки №3
                imgui.Text(u8'Открыта первая вкладка "Инфа"')
                imgui.Text(u8"Команда /pas - показывает паспорт (/pas ID)")
                imgui.Text(u8"Команда /lics - показывает лицензии(/lics ID)")
                imgui.Text(u8"Команда /medka - отыгрывает рп для мед.карты(передавать нужно вручную)")
                imgui.Text(u8"Команда /udost - отыгрывает рп для удостоверения(передавать нужно вручную)")
                imgui.Text(u8"Команда /cuff - надеть на игрока наручники, есть отыгровка(/cuff ID)")
                imgui.Text(u8"Команда /gotome - потащить игрока за собой, есть отыгровка(/gotome ID)")
                imgui.Text(u8"Команда /cput - посадить игрока в машину, есть отыгровка(/cput ID)")
                imgui.Text(u8"Команда /bodycam - включает отыгровку фрапса")
                imgui.Text(u8"Команда /ticket - отыгровка рп для штарафа + выписка штрафа(/ticket ID)")
                imgui.Text(u8"Команда /frisk - отыгровка рп для обыска + обыск(/frisk ID)")
                imgui.Text(u8"Команда /arrest - отыгровка ареста + арест(/arrest ID)")
                imgui.Text(u8"Команда /uncuff - снять наручники + отыгровка(/uncuff ID)")
                imgui.Text(u8"Команда /su - выдать розыск + отыгровка(/su ID)")
                imgui.Text(u8"Команда /clear - очистить розыск + отыгровка(/clear ID)")
                imgui.Text(u8"Команда /doki - запросить документы(/doki ID)")
                imgui.Text(u8"Команда /meg - просьба остановить машину в мегафон(/meg)")
                imgui.Text(u8"Команда /setpaswrld - установить пароль для быстрого захода")
                imgui.Text(u8"Команда /chatclear - визуально очистить чат")
                imgui.Text(u8"Команда /ecspertiza - отыгровка рп экспертизы")
                imgui.Text(u8"Команда /drug количество - употребить наркотики с рп")
                imgui.Text(u8"Зажать клавишу L.ALT - сирена+стробоскопы")
                imgui.Text(u8"Команда /statistiko - вывести статистику персонажа")
    
                if imgui.Button(u8'Кнопка') then
                    sampAddChatMessage('Вы нажали кнопку во вкладке номер '..tab, -1)
                end
            end
            -- == [Основное] Содержимое вкладок закончилось == --
            imgui.EndChild()
        end
        imgui.End()   
    end
    

    if sobes_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(1100, 800), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 300), imgui.Cond.Always)
        imgui.Begin(u8'Меню собеседований', WinState, imgui.WindowFlags.NoResize)
        imgui.CenterText(u8"Как использовать?")
        imgui.PushFont(fontsize)
            imgui.Text(u8'Нажмите на вкладку "Приветствие", \nчтобы открыть меню с приветствием. \nЧтобы послать уведомление - "Послать"')
        imgui.PopFont()
        imgui.Separator()
        -----------------------------------------------
        if imgui.Button(u8'Приветствие', imgui.ImVec2(0,0)) then
            sobestab = 1
        end
    
        imgui.SameLine()
        if imgui.Button(u8'sobestipo', imgui.ImVec2(0,0)) then
            sobestab = 2
        end

        if imgui.Button(u8"Тесты", imgui.ImVec2(0,0)) then
            sobestab = 3
        end

        imgui.SameLine()
        if imgui.Button(u8"Принятие", imgui.ImVec2(0,0)) then
            sobestab = 4
        end


        imgui.Separator()
        ------------------------------------------------
        for numberTab,nameTab in pairs({'Приветствие', 'Документы', 'Тесты', 'Принятие'}) do -- создаём и парсим таблицу с названиями будущих вкладок
            if imgui.Button(u8(nameTab), imgui.ImVec2(0.1,0.1)) then
                sobestab = numberTab -- меняем значение переменной tab на номер нажатой кнопки
            end
        end

            -- == [Основное] Содержимое вкладок == --
        if sobestab == 1 then -- если значение tab == 1
            imgui.PushFont(fontsize)
            imgui.Text(u8"Текст, который будет отправлен:")
            imgui.Text(u8(mainIni.sobes.sobes_privet))
            imgui.PopFont()

            
        -----2 вкладка
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
    sendMessage("/me снял с пояса наручники и надел их на преступника", 0)
    sendMessage("/cuff " .. arg, 1000)
    lua_thread.create(function()
        wait(7500)
    end)
end

---------------------------------------------------------------------------------------------------------

function cmd_gotome(arg)
    sendMessage("/me схватил преступника за руку, и повёл за собой", 0)
    sendMessage("/gotome " .. arg, 1000)
    lua_thread.create(function()
        wait(7500)        
    end)
end

function cmd_cput(arg)
    sendMessage("/me открыл дверь в автомобиле", 0)
    sendMessage("/do Дверь автомобиля открыта.", 1500)
    sendMessage("/me прижал голову преступника вниз, после чего посадил его в автомобиль", 2500)
    sendMessage("/cput " .. arg, 3500)
end


function cmd_bodycam()
    sendMessage("/do На груди висит скрытая боди-камера.", 0)
    sendMessage("/do На боди-камере находится кнопка включения записи.", 1500)
    sendMessage("/me засунув руку, резким движением пальцев нажал на кнопку записи", 2500)
    sendMessage("/do Боди-камера ведёт запись.", 3500)
end

function cmd_ticket(arg)

    sendMessage("/do Бланк с ручкой в руках.", 0)
    sendMessage("/me заполняет бланк, передает его нарушителю", 1500)
    sendMessage("/todo Распишитесь.*передавая бланк человеку", 2500)
    sendMessage("/do Талон на штраф в подсумке.", 3500)
    sendMessage("/todo Берите*передавая талон нарушителю", 4500)
    sendMessage("/ticket " .. arg, 5500)
end

function cmd_frisk(arg)
    sendMessage("/me надел перчатки, и начал обыскивать тело подозреваемого", 0)
    sendMessage("/frisk " .. arg, 1500)
end

function cmd_arrest(arg) 
    sendMessage("/do Рация на поясе.", 0)
    sendMessage("/me достал рацию с пояса, начали о доставке преступника.", 1500)
    sendMessage("/do Департамент: Принято, ожидайте двух офицеров.", 2500)
    sendMessage("/do Из участка выходят 2 офицера, после забирают преступника.", 3500)
    sendMessage("/me провожает взглядом преступника", 4500)
    sendMessage("/arrest " .. arg, 5500)
end

function cmd_mask()
    sendMessage("/me снял сумку с плеча, расстегнул молнию сумки, и начал обшаривать её в поисках балаклавы", 0)
    sendMessage("/me обшарив сумку, нащупал тонкую ткань, затем вытщаил её из сумки", 1500)
    sendMessage("/me расстегнул молнию, положил обратно на плечо сумку", 2500)
    sendMessage("/do В руке балаклава чёрного цвета.", 3500)
    sendMessage("/me надел на голову балаклаву", 4500)
    sendMessage("/mask", 5500)
end

function cmd_uncuff(arg)
    sendMessage("/do Наручники закреплены на человеке напротив.", 0)
    sendMessage("/do Ключ в правом кармане.", 1500)
    sendMessage("/me легким движением руки вытащил ключ из кармана", 2500)
    sendMessage("/do Ключ в руках.", 3500)
    sendMessage("/me вставил ключ в наручники", 4500)
    sendMessage("/do Ключ в замке.", 5500)
    sendMessage("/me прокрутил ключ и открыл замок", 6500)
    sendMessage("/uncuff " .. arg, 7500)
    sendMessage("/do Наручники откреплены.", 8500)
end

function cmd_su(arg)
    sendMessage("/su " .. arg, 0)
    sendMessage("/do Мини КПК в руках.", 1500)
    sendMessage("/me вошел в базу данных штата", 2500)
    sendMessage("/me обьявил человека в розыск", 3500)
    sendMessage("/me убрал Мини КПК", 4500)
end

function cmd_clear(arg)
    sendMessage("/do Мини КПК закреплен на поясе.", 0)
    sendMessage("/me снял мини КПК с пояса", 1500)
    sendMessage("/do Мини КПК в руках.", 2500)
    sendMessage("/me вошел в базу данных штата", 3500)
    sendMessage("/me осущетсвляет поиск информации о нарушителе", 4500)
    sendMessage("/do Процесс...", 5500)
    sendMessage("/do Данные найдены.", 6500)
    sendMessage("/me стирает объявление о розыске", 7500)
    sendMessage("/do Процесс...", 8500)
    sendMessage("/clear " .. arg, 9500)
    sendMessage("/do Объявление о розыске стёрто.", 10500)
end

function cmd_doki(arg)
    sendMessage("Здравствуйте, я сотрудник " .. "*" .. mainIni.config.city .. "*" ..  " - *" .. mainIni.config.namesurname .. "*.", 0)
    sendMessage("/do Удостоверение в левом кармане брюк.", 1500)
    sendMessage("/me достал удостоверение, раскрыл его перед человеком", 2500)
    sendMessage("/showudost " .. arg, 3500)
    sendMessage("Можете предоставить ваши документы для подтверждения вашей личности?", 4500)
end

function cmd_setcity(arg)
    mainIni.config.city = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('Город успешно установлен на {10a2e0}' .. mainIni.config.city, -1)
    end
end

function cmd_setnamesurname(arg)
    mainIni.config.namesurname = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('Имя и Фамилия успешно установлено на {10a2e0}' .. mainIni.config.namesurname, -1)
    end
end

function cmd_meg()
    sendMessage("/m Водитель автомобиля!", 0)
    sendMessage("/m Немедленно остановите машину и заглушите двигатель!", 1500)
    sendMessage("/m В случаи недпочинения - мы откроем огонь!", 2500)
end

function cmd_statistiko()
    notf.addNotification("              Untitled-1.LUA     \n   Ваш ник: " .. nick .. "  " .. "\n   Ваш ID: " .. id .. " ", 99999999, 4)
end

function cmd_setz(arg)
    mainIni.config.z = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('+', -1)
    end
end

function cmd_drugs(arg)
    sendMessage("/usedrugs " .. arg, 0)
    sendMessage("/do В кармане лежит таблетка от головы", 1500)
    sendMessage("/me сунул руку в карман, достал таблетку", 2500)
    sendMessage("/me глотнул таблетку", 3500)
end

function cmd_ecspertiza()
    sendMessage("/me подойдя к шкафу, открыл его и осмотрел содержимое полок", 0)
    sendMessage("/do В шкафу находятся разные растворы и пробирки для проведения химического анализа.", 1500)
    sendMessage("/me протянув руки к шкафу, взял с полки пару пробирок и раствор HNO3", 2500)
    sendMessage("/me подойдя к столу, положил пробирки с раствором на стол, и потянувшись за подставкой взял ее", 3500)
    sendMessage("/me поставив подставку, взял пробирки и вставил их в отверстия подставки", 4500)
    sendMessage("/me взяв раствор аккуратно открутил крышку и влив немного раствора HNO3 в пробирку, закрутил обратно", 5500)
    sendMessage("/do В пробирке налит раствор темно-красного цвета.", 6500)
    sendMessage("/do На столе лежал пакетик с белым веществом, в виде порошка.", 7500)
    sendMessage("/me взяв пакет с веществом со стола, поднял его на уровень глаз и немного встряхнул", 8500)
    sendMessage("/me открыв пакетик высыпал небольшое количество вещества в раствор HNO3", 9500)
    sendMessage("/me наклонился к пробирке, внимательно смотря за реакцией", 10500)
    sendMessage("/do Спустя пару минут жидкость в пробирке была кроваво-красного цвета.", 11500)
    sendMessage("/do В подсумке сотрудника лежит авторучка и мини-журнальчик.", 12500)
    sendMessage("/me достал оттуда журнальчик и авторучку", 13500)
    sendMessage("/me увидев реакцию кивнул, и сделал в запись в журнальчике", 14500)
    sendMessage("/do Запись в журнале: вещество является наркотическим.", 15500)
end


function cmd_chatclear()
    for i =1, 25 do
        sampAddChatMessage("", -1)
    end
    sampAddChatMessage('ChatClear -------ManstikosUA', -1)
end


function cmd_prin()
    sendMessage("Здравствуйте, Вы пришли на собеседование?", 0)
end

function cmd_prin1()
    sendMessage("Отлично, тогда мне потребуется ваш паспорт и лицензии", 0)
    sendMessage("Но уверяю вас, в случаи если с документами будут проблемы,", 1500)
    sendMessage("то я вправе отказать вам", 2500)
    sendMessage("/b передавать нужно по РП (/pass | /sl)", 3500)
end

function cmd_prin2()
    sendMessage("Хорошо ,с документами всё в порядке.", 0)
    sendMessage("Теперь скажите пожалуйста, почему вы решили вступить к нам?", 1500)
end

function cmd_prin3()
    sendMessage("Окей, как вы понимаете слово ДМ", 0)
    sendMessage("Это последний вопрос, после которого я смогу вас принять", 1500)
end

function cmd_prin4()
    sendMessage("Отлично! Я думаю, вы нам подходите!", 0)
    sendMessage("Подождите секунду, сейчас я выдам вам одежду", 1500)
end

----------------------------------------------------------------------------------------------------------------------------
function cmd_vig(arg)
    sendMessage("/do Блокнот с ручкой в правом кармане.", 0)
    sendMessage("/me легким движением руки вытащил блокнот с ручкой из кармана", 1500)
    sendMessage("/do Блокнот и ручка в руках.", 2550)
    sendMessage("/me вписал имя нарушителя в блокнот", 3550)
    sendMessage("/do Процесс...", 4550)
    sendMessage("/vig " .. arg, 5600)
    sendMessage("/do Данные вписаны.", 6550)
    sendMessage("/me убрал блокнот и ручку в карман",7550)
    sendMessage("/do Принадлежности убраны.", 8550)
end

function cmd_uninvite(arg) 
    sendMessage("/do Мини КПК закреплен на поясе.", 0)
    sendMessage("/me снял мини КПК с пояса", 1550)
    sendMessage("/do Мини КПК в руках.", 2550)
    sendMessage("/me вошёл в базу данных и начал изменять данные о сотруднике", 3550)
    sendMessage("/do Процесс...", 4550)
    sendMessage("/uninvite " .. arg, 5550)
    sendMessage("/do Данные о сотруднике изменены.", 6550)
    sendMessage("/me закрепил мини КПК на поясе", 7550)
end

function cmd_invite(arg) 
    sendMessage("/me достал форму и нужные преднадлежности", 0)
    sendMessage("/me передал их человеку навпротив", 1500)
    sendMessage("/invite " .. arg, 2500)
end
