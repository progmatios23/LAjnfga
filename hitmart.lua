local notifications = {}
local center = (workspace.CurrentCamera.ViewportSize / 2)
local function hitmarker_update()
   for i = 1, #notifications do
       notifications[i].Position = Vector2.new(center.X,(center.Y + 150) + (i * 18))
   end
end
local function hitmarker(Name, Distance, Damage, Duration)
   task.spawn(function()
       local hitlog = Drawing.new('Text')
       hitlog.Size = 8
       hitlog.Font = 2
       hitlog.Text = "[King o melhor] Hit: "..Name.." / Distance: "..Distance.."s / Damage: "..math.floor(Damage).."Hp"
       hitlog.Visible = true
       hitlog.ZIndex = 3
       hitlog.Center = true
       hitlog.Color = Color3.fromRGB(255, 255, 255)
       hitlog.Outline = true
       table.insert(notifications, hitlog)
       hitmarker_update()
       wait(Duration)
       table.remove(notifications, table.find(notifications, hitlog))
       hitmarker_update()
       hitlog:Remove()
   end)
end

game:GetService("LogService").MessageOut:Connect(function(message)
    local Name = message:match("->([%w_]+)");
    local HealthBfr, HealthAfr = message:match("(%d+%.?%d*)->(%d+%.?%d*)hp");
    local Dist = message:match("(%d+%.?%d*)s")
    local Damage = tonumber(HealthBfr) - tonumber(HealthAfr)
    if Name and HealthBfr and HealthAfr and Dist and Damage then
        hitmarker(Name, Dist, Damage, 4)
    end
end