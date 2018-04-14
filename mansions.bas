declare sub end.game ()
declare function initialize ()
declare sub load.a.game ()
declare function loadfile (filename$, lenth&, segment!, offset!, flag%)
declare sub menu ()
declare sub new.level (level%)
declare sub save.this.game ()
declare sub start.new.game ()
defint a-z
common shared mapx%, mapy%, x%, y%, direction%, keyb%, now.shooting%, counter%
common shared item&, distance%, notup%, notdown%, notleft%, notright%, go%
common shared shoot.vector%, shotx%, shoty%, bad.health%, bad.right%, bad.left%
common shared bad.up%, bad.down%, whats.ahead%
common shared info.key%, info.coin%, info.health%, info.shield%, info.time%, info.gun%
common shared info.trap%, info.disk%, shoot.counter%, get.me%, ouch%, ouch.count%
common shared retry.key%, retry.coin%, retry.score%, retry.shield%
common shared retry.health%, retry.gun%, retry.disk%, retry.time%
common shared level%
common shared abort%, game.open%
dim shared chart&(0 to 20, 0 to 23)
dim shared image&(0 to 4160)
abort% = initialize
if abort% then system
menu
screen 0
width 80, 25
clear
system

missing.file:
abort% = 1
resume next
system

sub end.game
    mapx% = 0: mapy% = 0: x% = 0: y% = 0: direction% = 0: keyb% = 0: now.shooting% = 0
    counter% = 0: item& = 0: distance% = 0: notup% = 0: notdown% = 0: notleft% = 0
    notright% = 0: go% = 0: shoot.vector% = 0: shotx% = 0: shoty% = 0
    bad.health% = 0: bad.right% = 0: bad.left% = 0: bad.up% = 0: bad.down% = 0: whats.ahead% = 0
    info.key% = 0: info.coin% = 0: info.health% = 0: info.shield% = 0: info.time% = 0: info.gun% = 0
    info.trap% = 0: info.disk% = 0: shoot.counter% = 0: get.me% = 0: ouch% = 0: ouch.count% = 0
    retry.key% = 0: retry.coin% = 0: retry.score% = 0: retry.shield% = 0
    retry.health% = 0: retry.gun% = 0: retry.disk% = 0: retry.time% = 0
    level% = 0
    game.open% = 0
    def seg = varseg(chart&(0, 0))
    for null% = 0 to varptr(chart&(20, 23))
        poke null%, 0
    next null%
end sub

function initialize
    dim colors&(0 to 51)
    abort% = 0
    do: loop until inkey$ = ""
    cls
    print "loading..."
    initialize% = loadfile("images.0", 12008, varseg(image&(0)), 0, 3)
    if initialize% = 1 then exit function
    initialize% = loadfile("pal.0", 212, varseg(colors&(0)), 0, 3)
    if initialize% = 1 then exit function
    initialize% = loadfile("menu.0", 64008, &ha000, 0, 3)
    if initialize% = 1 then exit function
    initialize% = loadfile("loadmenu.0", 30008, &ha000, 0, 2)
    if initialize% = 1 then exit function
    initialize% = loadfile("savemenu.0", 30008, &ha000, 0, 2)
    if initialize% = 1 then exit function
    initialize% = loadfile("message.1", 15008, &ha000, 0, 2)
    if initialize% = 1 then exit function
    initialize% = loadfile("message.2", 15008, &ha000, 0, 2)
    if initialize% = 1 then exit function
    initialize% = loadfile("message.3", 15008, &ha000, 0, 2)
    if initialize% = 1 then exit function
    screen 13
    for colorset% = 0 to 50
        palette colorset%, colors&(colorset%)
    next colorset%
end function

sub load.a.game
    select.game:
    cls
    abort% = loadfile("loadmenu.0", 30008, &ha000, 19200, 1)
    if abort% = 1 then exit sub
    do
        do
            keyb$ = inkey$
        loop until keyb$ <> ""
    loop until (asc(keyb$) < 58 and asc(keyb$) > 48) or keyb$ = chr$(27)
    if keyb$ = chr$(27) then exit sub
    filename$ = "saved." + keyb$
    abort% = loadfile(filename$, 2020, varseg(chart&(0, 0)), 0, 1)
    if abort% = 1 then
        abort% = 0
        cls
        abort% = loadfile("message.1", 15008, &ha000, 19200, 1)
        if abort% = 1 then exit sub
        do: loop until inkey$ = ""
        do: loop until inkey$ <> ""
        goto select.game
    end if
    bad.left% = chart&(0, 22): bad.right% = chart&(1, 22): bad.up% = chart&(2, 22)
    bad.down% = chart&(3, 22): badx% = chart&(4, 22): bady% = chart&(5, 22)
    bad.health% = chart&(6, 22): counter% = chart&(7, 22): direction% = chart&(8, 22)
    erase.flag% = chart&(9, 22): go% = chart&(10, 22): get.me% = chart&(11, 22)
    item& = chart&(12, 22): info.key% = chart&(13, 22): info.coin% = chart&(14, 22)
    info.health% = chart&(15, 22): info.shield% = chart&(16, 22): info.time% = chart&(17, 22)
    info.gun% = chart&(18, 22): info.trap% = chart&(19, 22): info.disk% = chart&(20, 22)
    keyb% = chart&(0, 23): level% = chart&(1, 23): mapx% = chart&(2, 23)
    mapy% = chart&(3, 23): now.shooting% = chart&(4, 23): notup% = chart&(5, 23)
    notdown% = chart&(6, 23): notleft% = chart&(7, 23): notright% = chart&(8, 23)
    ouch% = chart&(9, 23): ouch.count% = chart&(10, 23): shoot.vector% = chart&(11, 23)
    shotx% = chart&(12, 23): shoty% = chart&(13, 23): shoot.counter% = chart&(14, 23)
    whats.ahead% = chart&(15, 23): x% = chart&(16, 23): y% = chart&(17, 23)
    score% = chart&(18, 23)
    retry.key% = chart&(1, 0): retry.coin% = chart&(2, 0)
    retry.score% = chart&(3, 0): retry.shield% = chart&(4, 0)
    retry.health% = chart&(5, 0): retry.gun% = chart&(6, 0)
    retry.disk% = chart&(7, 0): retry.time% = chart&(8, 0)
    game.open% = 1
    start.new.game
end sub

function loadfile% (filename$, length&, segment!, offset!, flag%)
    abort% = 0
    on error goto missing.file
    close #1
    open filename$ for input as #1
    close #1
    if abort% = 1 then
        if (flag% and 2) then
            screen 0
            width 80, 25
            print "file " + filename$ + " is missing!"
        end if
        loadfile% = 1
        exit function
    end if
    close #1
    open filename$ for append as #1
    if seek(1) <> length& then problem% = 1
    close #1
    if problem% then
        if (flag% and 2) then
            screen 0
            width 80, 25
            print "file " + filename$ + " has wrong lenth!"
        end if
        loadfile% = 1
        exit function
    end if
    close #1
    if (flag% and 1) = 0 then exit sub
    def seg = segment!
    bload filename$, offset!
    if problem% then
        if (flag% and 2) then
            screen 0
            width 80, 25
            print "file " + filename$ + " is corrupt!"
        end if
        loadfile% = 1
        exit function
    end if
    loadfile% = 0
end function

sub menu
    static location%
    movecursor% = 1
    load.menu:
    def seg = &ha000
    bload "menu.0", 0
    do: do: loop until inkey$ = "": loop until inp(96) <> 28 and inp(96) <> 1
    menu.loop:
    slocation% = location%
    keyb$ = inkey$
    if keyb$ = chr$(0) + "H" and location% > 0 then
        location% = location% - 1
        movecursor% = 1
    end if
    if keyb$ = chr$(0) + "P" and location% < 4 then
        location% = location% + 1
        movecursor% = 1
    end if
    if game.open% = 1 and keyb$ = chr$(27) then keyb$ = chr$(13): location% = 0
    if keyb$ = chr$(13) or keyb$ = chr$(32) then: goto select.an.option
    if movecursor% = 1 then
        line (60, (slocation% * 40) + 6)-(245, (slocation% * 40) + 34), 0, b
        line (60, (location% * 40) + 6)-(245, (location% * 40) + 34), 7, b
        movecursor% = 0
    end if
    goto menu.loop
    select.an.option:
    if location% = 0 then start.new.game
    if location% = 1 then load.a.game
    if location% = 2 then save.this.game
    if location% = 3 then end.game
    if location% = 4 then exit sub
    if abort% = 1 then exit sub
    movecursor% = 1
    goto load.menu
end sub

defsng a-z
sub new.level (level%)
    static slevel%
    abort% = 0
    filename$ = "level." + ltrim$(rtrim$(str$(level%)))
    abort% = loadfile(filename$, 1852, varseg(chart&(0, 0)), 0, 3)
    if slevel% < level% then
        retry.key% = info.key%: retry.coin% = info.coin%
        retry.score% = info.score%: retry.shield% = info.shield%
        retry.health% = info.health%: retry.gun% = info.gun%
        retry.disk% = info.disk%: retry.time% = info.time%
    else
        info.key% = retry.key: info.coin% = retry.coin%
        info.score% = retry.score%: info.shield% = retry.shield%
        info.health% = retry.health%: info.gun% = info.gun%
        info.disk% = retry.disk%: info.time% = retry.time%
    end if
    slevel% = level%
end sub

defint a-z
sub save.this.game
    if game.open% = 0 then
        cls
        abort% = loadfile("message.3", 15008, &ha000, 19200, 1)
        do: loop until inkey$ = ""
        do: loop until inkey$ <> ""
        exit sub
    end if
    get.save.name:
    cls
    abort% = loadfile("savemenu.0", 30008, &ha000, 19200, 1)
    do
        keyb$ = inkey$
    loop until (keyb$ < chr$(58) and keyb$ > chr$(48)) or keyb$ = chr$(27)
    if keyb$ = chr$(27) then exit sub
    filename$ = "saved." + keyb$
    abort% = loadfile(filename$, 2020, varseg(chart&(0, 0)), 0, 0)
    if abort% = 0 then
        cls
        abort% = loadfile("message.2", 15008, &ha000, 19200, 1)
        if abort% = 1 then exit sub
        do
            keyb$ = ucase$(inkey$)
        loop until keyb$ = "y" or keyb$ = "n"
        if keyb$ = "n" then goto get.save.name
    end if
    abort% = 0
    chart&(0, 22) = bad.left%: chart&(1, 22) = bad.right%: chart&(2, 22) = bad.up%
    chart&(3, 22) = bad.down%: chart&(4, 22) = badx%: chart&(5, 22) = bady%
    chart&(6, 22) = bad.health%: chart&(7, 22) = counter%: chart&(8, 22) = direction%
    chart&(9, 22) = erase.flag%: chart&(10, 22) = go%: chart&(11, 22) = get.me%
    chart&(12, 22) = item&: chart&(13, 22) = info.key%: chart&(14, 22) = info.coin%
    chart&(15, 22) = info.health%: chart&(16, 22) = info.shield%: chart&(17, 22) = info.time%
    chart&(18, 22) = info.gun%: chart&(19, 22) = info.trap%: chart&(20, 22) = info.disk%
    chart&(0, 23) = keyb%: chart&(1, 23) = level%: chart&(2, 23) = mapx%
    chart&(3, 23) = mapy%: chart&(4, 23) = now.shooting%: chart&(5, 23) = notup%
    chart&(6, 23) = notdown%: chart&(7, 23) = notleft%: chart&(8, 23) = notright%
    chart&(9, 23) = ouch%: chart&(10, 23) = ouch.count%: chart&(11, 23) = shoot.vector%
    chart&(12, 23) = shotx%: chart&(13, 23) = shoty%: chart&(14, 23) = shoot.counter%
    chart&(15, 23) = whats.ahead%: chart&(16, 23) = x%: chart&(17, 23) = y%
    chart&(18, 23) = score%
    chart&(1, 0) = retry.key%: chart&(2, 0) = retry.coin%
    chart&(3, 0) = retry.score%: chart&(4, 0) = retry.shield%
    chart&(5, 0) = retry.health%: chart&(6, 0) = retry.gun%
    chart&(7, 0) = retry.disk%: chart&(8, 0) = retry.time%

    def seg = varseg(chart&(0, 0))
    bsave filename$, 0, varptr(chart&(20, 23))
end sub

sub start.new.game
    if mapx% = 0 then
        level% = 0
        new.level level%
        if abort% then exit sub
        mapx% = chart&(0, 6)
        mapy% = chart&(0, 7)
        x% = 149
        y% = 89
        direction% = 1
        info.health% = 5
        game.open% = 1
    end if
    line (0, 0)-(319, 199), 1, bf
    gosub newroom
    do: do: loop until inkey$ = "": loop until inp(96) <> 28 and inp(96) <> 1
    playloop:
    do: loop until inkey$ = ""
    keyb% = inp(96)
    if item& = 512 then
        if ouch.count% < 300 then ouch.count% = ouch.count% + 1
        counter% = counter% + 1
        if counter% = 3 or now.shooting% = 1 then gosub monster: if info.health% = 0 then end.game: exit sub
    end if
    if shoot.counter% < 200 then shoot.counter% = shoot.counter% + 1
    if now.shooting% = 1 then distance% = 1: gosub shoot
    select case keyb%
        case 1: exit sub
        case 29
            if shoot.counter% = 200 and now.shooting% = 0 and info.gun% > 0 then gosub shoot
        case 72
            if notup% = 0 then
                y% = y% - 1
                put (x%, y%), image&(391), pset
                go% = 1
                direction% = 1
            end if
        case 80
            if notdown% = 0 then
                y% = y% + 1
                put (x%, y% - 1), image&(131), pset
                go% = 1
                direction% = 2
            end if
        case 75
            if notleft% = 0 then
                x% = x% - 1
                put (x%, y%), image&(261), pset
                go% = 1
                direction% = 3
            end if
        case 77
            if notright% = 0 then
                x% = x% + 1
                put (x% - 1, y%), image&(0), pset
                go% = 1
                direction% = 4
            end if
    end select
    notup% = point(x%, y% - 1) + point(x% + 20, y% - 1)
    notdown% = point(x%, y% + 21) + point(x% + 20, y% + 21)
    notleft% = point(x% - 1, y%) + point(x% - 1, y% + 20)
    notright% = point(x% + 21, y%) + point(x% + 21, y% + 20)
    if go% = 1 then
        if y% = 0 then mapy% = mapy% - 1: y% = 178: gosub newroom
        if y% = 179 then mapy% = mapy% + 1: y% = 1: gosub newroom
        if x% = 0 then mapx% = mapx% - 1: x% = 298: gosub newroom
        if x% = 299 then mapx% = mapx% + 1: x% = 1: gosub newroom
    end if
    select case get.me%
        case 1
            if x% > 127 and x% < 171 and y% > 67 and y% < 111 then gosub react
            if abort% then exit sub
        case 2
            if (info.key% > 0) and (x% = 108 or x% = 210 or y% = 28 or y% = 140) then
                for a = 150 to 0 step -1
                    if a mod 2 then sound (a * 20) + 50, .0227275 else sound (a * (20 + 10)) + 50, .0227275
                next a
                info.key% = info.key% - 1
                get.me% = 0
                go% = 1
                line (129, 69)-(189, 139), 0, bf
                chart&(mapx%, mapy%) = chart&(mapx%, mapy%) and 15
            end if
        case 3
            if (info.trap% and 16) = 0 and x% > 98 and x% < 200 and y% > 38 and y% < 150 then
                info.trap% = info.trap% + 16
            end if
            if (info.trap% and 16) = 16 then
                if (x% < 99 and (info.trap% and 8) = 0) or (x% > 199 and (info.trap% and 4) = 0) or (y% < 39 and (info.trap% and 2) = 0) or (y% > 149 and (info.trap% and 1) = 0) then
                    line (119, 59)-(199, 149), 5, bf
                    chart&(mapx%, mapy%) = (chart&(mapx%, mapy%) and 15) + 131072
                    get.me% = 0
                end if
            end if
    end select
    _delay 0.002
    goto playloop
    react:
    go% = 0
    select case item&
        case 16: info.key% = info.key% + 1: go% = 1: play "mbmlt255l64o5bababa"
        case 32: info.coin% = info.coin% + 1: go% = 1: info.score% = info.score% + 10: play "mbt200l64o3defgabagfedc"
        case 64: info.health% = info.health% + 1: go% = 1: play "mbmlt255l32o1co4do1co4do1co4do1co4do1co4do1co4d"
        case 128: info.shield% = info.shield% + 1: go% = 1: play "mbmlt255l64o2cdefgab"
        case 256: info.time% = info.time% + 1: go% = 1: play "mbmlt255l64o2cdefgab"
        case 1024: info.gun% = info.gun% + 5: go% = 1: play "mbmlt255l64o2cdefgab"
        case 8192: info.disk% = info.disk% + 1: play "mbmlt255l64o2cdefgab"
            if info.disk% = 4 then
                level% = level% + 1: new.level level%: if abort% = 1 then return
                item& = 0: mapx% = chart&(0, 6): mapy% = chart&(0, 7)
                x% = 149: y% = 89: gosub newroom: notup% = 0
                notdown% = 0: notleft% = 0: notright% = 0: info.disk% = 0
            else
                go% = 1
            end if
        case 16384:
            new.level level%: item& = 0: mapx% = chart&(0, 6): mapy% = chart&(0, 7)
            x% = 149: y% = 89: gosub newroom: notup% = 0: notdown% = 0: notleft% = 0: notright% = 0
        case 32768
            if keyb% = 57 then
                for a = 0 to 150 step 1
                    if a mod 2 then sound (a * 20) + 50, .0227275 else sound (a * (20 + 10)) + 50, .0227275
                next a
                mapx% = chart&(0, 4)
                mapy% = chart&(0, 5)
                go% = 2
                gosub newroom
                gosub letgo
            end if
        case 65536
            if go% = 0 and keyb% = 57 then
                for a = 0 to 150 step 1
                    if a mod 2 then sound (a * 20) + 50, .0227275 else sound (a * (20 + 10)) + 50, .0227275
                next a
                mapx% = chart&(0, 2)
                mapy% = chart&(0, 3)
                gosub newroom
                gosub letgo
            end if
    end select
    if go% = 1 then
        chart&(mapx%, mapy%) = chart&(mapx%, mapy%) and 15
        line (149, 89)-(169, 109), 0, bf
        item& = 0
    end if
    get.me& = 0
    return
    newroom:
    if been.here% = 1 then
        now.shooting% = 0
        counter% = 0
        ready.to.place = 0
    end if
    badx% = 149
    bady% = 89
    ouch.count% = 300
    bad.health% = 3
    if (chart&(mapx%, mapy%) and 1) = 0 then
        line (119, 0)-(199, 58), 1, bf
    else
        line (119, 0)-(199, 149), 0, bf
    end if
    if (chart&(mapx%, mapy%) and 2) = 0 then
        line (0, 59)-(118, 149), 1, bf
    else
        line (0, 59)-(199, 149), 0, bf
    end if
    if (chart&(mapx%, mapy%) and 4) = 0 then
        line (200, 59)-(319, 149), 1, bf
    else
        line (119, 59)-(319, 149), 0, bf
    end if
    if (chart&(mapx%, mapy%) and 8) = 0 then
        line (119, 150)-(199, 199), 1, bf
    else
        line (119, 59)-(199, 199), 0, bf
    end if
    item& = chart&(mapx%, mapy%) - (chart&(mapx%, mapy%) and 15)
    select case direction%
        case 1
            put (x%, y%), image&(391), pset
        case 2
            put (x%, y% - 1), image&(131), pset
        case 3
            put (x%, y%), image&(261), pset
        case 4
            put (x% - 1, y%), image&(0), pset
    end select
    get.me% = 0
    select case item&
        case 16: put (149, 89), image&(781), pset: get.me% = 1
        case 32: put (149, 89), image&(651), pset: get.me% = 1
        case 64: put (149, 89), image&(1041), pset: get.me% = 1
        case 128: put (149, 89), image&(911), pset: get.me% = 1
        case 256: put (149, 89), image&(1171), pset: get.me% = 1
        case 512: put (149, 89), image&(521), pset: get.me% = 0
        case 1024: put (149, 89), image&(1431), pset: get.me% = 1
        case 2048
            get.me% = 3
            line (149, 89)-(169, 109), 3, bf
            if been.here% = 1 then
                select case direction%
                    case 1
                        info.trap% = 1
                    case 2
                        info.trap% = 2
                    case 3
                        info.trap% = 4
                    case 4
                        info.trap% = 8
                end select
            end if
        case 4096: line (129, 69)-(189, 139), 3, bf: get.me% = 2
        case 8192: put (149, 89), image&(1561), pset: get.me% = 1
        case 16384: put (149, 89), image&(1821), pset: get.me% = 1
        case 32768, 65536: put (149, 89), image&(1691), pset: get.me% = 1
        case 131072: line (119, 59)-(199, 149), 5, bf
    end select
    been.here% = 1
    return
    monster:
    counter% = 0
    go% = 0
    if bad.health% = 0 then
        go% = 1
        item& = 0
        chart&(mapx%, mapy%) = (chart&(mapx%, mapy%) and 15)
        line (badx%, bady%)-(badx% + 20, bady% + 20), 0, bf
        return
    end if
    badup% = point(badx%, bady% - 1) + point(badx% + 20, bady% - 1)
    baddown% = point(badx%, bady% + 21) + point(badx% + 20, bady% + 21)
    badleft% = point(badx% - 1, bady%) + point(badx% - 1, bady% + 20)
    badright% = point(badx% + 21, bady%) + point(badx% + 21, bady% + 20)
    if badx% = x% - 21 and bady% > y% - 21 and bady% < y% + 21 then ouch% = 1
    if badx% = x% + 21 and bady% > y% - 21 and bady% < y% + 21 then ouch% = 1
    if bady% = y% - 21 and badx% > x% - 21 and badx% < x% + 21 then ouch% = 1
    if bady% = y% + 21 and badx% > x% - 21 and badx% < x% + 21 then ouch% = 1
    if ouch% = 1 and ouch.count% = 300 then
        ouch.count% = 0
        if info.shield% > 0 then
            info.shield% = info.shield% - 1
            play "mbp1"
        else
            info.health% = info.health% - 1
            for a = 200 to 0 step -1
                sound (a * 40) + 50, .0227275
            next a
        end if
    end if
    ouch% = 0
    if badx% < x% and badright% = 0 then
        badx% = badx% + 1
        go% = 1
        line (badx% - 1, bady%)-(badx% - 1, bady% + 20), 0
    end if
    if badx% > x% and badleft% = 0 then
        badx% = badx% - 1
        go% = 1
        line (badx% + 21, bady%)-(badx% + 21, bady% + 20), 0
    end if
    if bady% < y% and baddown% = 0 then
        bady% = bady% + 1
        go% = 1
        line (badx%, bady% - 1)-(badx% + 20, bady% - 1), 0
    end if
    if bady% > y% and badup% = 0 then
        bady% = bady% - 1
        go% = 1
        line (badx%, bady% + 21)-(badx% + 20, bady% + 21), 0
    end if
    if go% = 1 then put (badx%, bady%), image&(521), pset
    return
    shoot:
    if now.shooting% = 0 then
        info.gun% = info.gun% - 1
        now.shooting% = 1
        shotx% = x%
        shoty% = y%
        shoot.vector% = direction%
        shoot.counter% = 0
        distance% = 0
    end if
    select case shoot.vector%
        case 1
            shoty% = shoty% - 1
            whats.ahead% = point(shotx% + 5, shoty% - 10) + point(shotx% + 15, shoty% - 10)
            if distance% = 1 then line (shotx% + 5, shoty% - 9)-(shotx% + 15, shoty% + 1), 0, b
            if whats.ahead% = 0 then
                line (shotx% + 5, shoty% - 10)-(shotx% + 15, shoty%), 8, b
            else
                now.shooting% = 0
                if item& = 512 and bady% - 1 < shoty% and bady% + 71 > shoty% and badx% - 31 < shotx% and badx% + 31 > shotx% then
                    bad.health% = bad.health% - 1
                    play "mbmlt255l64o6bagfo5bagfo4bagfo3bagfo2bagfo1bagf"
                else
                    play "mbt100l64o1ao2ao3ao4ao5ao6a"
                end if
            end if
        case 2
            shoty% = shoty% + 1
            whats.ahead% = point(shotx% + 5, shoty% + 30) + point(shotx% + 15, shoty% + 30)
            if distance% = 1 then line (shotx% + 5, shoty% + 19)-(shotx% + 15, shoty% + 29), 0, b
            if whats.ahead% = 0 then
                line (shotx% + 5, shoty% + 20)-(shotx% + 15, shoty% + 30), 8, b
            else
                now.shooting% = 0
                if item& = 512 and bady% - 41 < shoty% and bady% + 21 > shoty% and badx% - 31 < shotx% and badx% + 21 > shotx% then
                    bad.health% = bad.health% - 1
                    play "mbmlt255l64o6bagfo5bagfo4bagfo3bagfo2bagfo1bagf"
                else
                    play "mbt100l64o1ao2ao3ao4ao5ao6a"
                end if
            end if
        case 3
            shotx% = shotx% - 1
            whats.ahead% = point(shotx% - 11, shoty% + 5) + point(shotx% - 11, shoty% + 15)
            if distance% = 1 then line (shotx% - 10, shoty% + 5)-(shotx%, shoty% + 15), 0, b
            if whats.ahead% = 0 then
                line (shotx% - 11, shoty% + 5)-(shotx% - 1, shoty% + 15), 8, b
            else
                now.shooting% = 0
                if item& = 512 and bady% - 21 < shoty% and bady% + 31 > shoty% and badx% - 11 < shotx% and badx% + 32 > shotx% then
                    bad.health% = bad.health% - 1
                    play "mbmlt255l64o6bagfo5bagfo4bagfo3bagfo2bagfo1bagf"
                else
                    play "mbt100l64o1ao2ao3ao4ao5ao6a"
                end if
            end if
        case 4
            shotx% = shotx% + 1
            whats.ahead% = point(shotx% + 31, shoty% + 5) + point(shotx% + 31, shoty% + 15)
            if distance% = 1 then line (shotx% + 20, shoty% + 5)-(shotx% + 30, shoty% + 15), 0, b
            if whats.ahead% = 0 then
                line (shotx% + 21, shoty% + 5)-(shotx% + 31, shoty% + 15), 8, b
            else
                now.shooting% = 0
                if item& = 512 and bady% - 31 < shoty% and bady% + 31 > shoty% and badx% - 41 < shotx% and badx% + 32 > shotx% then
                    bad.health% = bad.health% - 1
                    play "mbmlt255l64o6bagfo5bagfo4bagfo3bagfo2bagfo1bagf"
                else
                    play "mbt100l64o1ao2ao3ao4ao5ao6a"
                end if
            end if
    end select
    return
    letgo:
    do
        do: loop until inkey$ = ""
        look% = inp(96)
    loop until look% <> keyb% and look% <> 224
    return
end sub

