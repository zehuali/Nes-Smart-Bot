
map = {
    [0]={A=false, up=true, left=false, B=false, select=false, right=false, down=false, start=false},
    [1]={A=false, up=false, left=false, B=false, select=false, right=false, down=true, start=false},
    [2]={A=false, up=false, left=true, B=false, select=false, right=false, down=false, start=false},
    [3]={A=false, up=false, left=false, B=false, select=false, right=true, down=false, start=false},
    [4]={A=true, up=false, left=false, B=false, select=false, right=false, down=false, start=false},
    [5]={A=false, up=false, left=false, B=true, select=false, right=false, down=false, start=false},
    [6]={A=true, up=false, left=false, B=false, select=false, right=true, down=false, start=false},
    [7]={A=false, up=false, left=false, B=true, select=false, right=true, down=false, start=false},
    [8]={A=true, up=false, left=false, B=true, select=false, right=true, down=false, start=false},
    [9]={A=true, up=false, left=true, B=false, select=false, right=false, down=false, start=false},
    [10]={A=false, up=false, left=true, B=true, select=false, right=false, down=false, start=false},
    [11]={A=true, up=false, left=true, B=true, select=false, right=false, down=false, start=false},
    [12]={A=false, up=false, left=true, B=false, select=false, right=false, down=true, start=false},
    [13]={A=false, up=false, left=false, B=false, select=false, right=true, down=true, start=false},
    [14]={A=false, up=false, left=false, B=false, select=true, right=false, down=false, start=true},
    [15]={A=false, up=false, left=false, B=false, select=false, right=false, down=false, start=false}
}

function mapjoypad(input)
    -- if input['right'] and input['a']
    for k,v in pairs(map) do
        if compare(v, input) then
            return k
        end
    end
    return 16
end

function compare(mapslice,input)
    for k,v in pairs(input) do
        if not mapslice[k] == input[k] then
            return false
        end
    end
    return true
end


fcnt = 0;

file = io.open("labels.lua", "w")
io.output(file)

while (true) do
    if fcnt > 100 then

        input = joypad.get(1)
        print(input)
        -- stop record when press "up" and "down"
        if input['up'] and input['down'] then 
            print("stop")
            break
        end
        -- gui.savescreenshot("mario-"..(fcnt-500)..".png")
        
        key = mapjoypad(input)
        io.write(key..'\n')

        print("mario-"..(fcnt-100)..".png saved "..key)

    end
    fcnt = emu.framecount();
    gui.text(50,50,fcnt);

    emu.frameadvance();
end;

io.close(file)

-- 0 == up
-- 1 == down
-- 2 == left
-- 3 == right
-- 4 == a
-- 5 == b
-- 6 == right + a
-- 7 == right + b
-- 8 == right + a + b
-- 9 == left + a
-- 10 == left + b
-- 11 == left + a + b
-- 12 == left + down
-- 13 == right + down
-- 14 == start
-- 15 == select
