local cursor = kiwmi:cursor()

cursor:on("motion", function ()
    local view = cursor:view_at_pos()

    if view then
        view:focus()
    end
end)

cursor:on("button_up", function ()
    kiwmi:stop_interactive()
end)

kiwmi:on("view", function (view)
    view:focus()
    view:show()

    view:on("request_move", function ()
        view:imove()
    end)

    view:on("request_resize", function (ev)
        view:iresize(ev.edges)
    end)
end)

keybinds = {
    Escape = function () kiwmi:quit() end,
    Return = function () kiwmi:spawn("weston-terminal") end,
    w = function () local view = kiwmi:focused_view() if view then view:close() end end,
}

kiwmi:on("keyboard", function (keyboard)
    keyboard:on("key_down", function (ev)
        if ev.keyboard:modifiers().alt then
            local bind = keybinds[ev.key]
            if bind then
                bind(ev)
                return true
            end
        end

        return false
    end)
end)

kiwmi:spawn("swaybg -c '#333333'")
