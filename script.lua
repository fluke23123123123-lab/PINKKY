repeat task.wait() until game:IsLoaded()

local p = game.Players.LocalPlayer
local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
g.ResetOnSpawn = false

local function createMain()
    local m = Instance.new("Frame", g)
    m.Size = UDim2.new(0,260,0,320)
    m.Position = UDim2.new(0.5,-130,0.5,-160)
    m.BackgroundColor3 = Color3.fromRGB(0,0,0)
    m.BackgroundTransparency = 0.2
    m.Active = true
    m.Draggable = true

    local t = Instance.new("TextLabel", m)
    t.Size = UDim2.new(1,0,0,35)
    t.Text = "PINKKY"
    t.TextColor3 = Color3.new(1,1,1)
    t.BackgroundTransparency = 1

    local v1 = Instance.new("TextButton", m)
    v1.Size = UDim2.new(0.7,0,0,40)
    v1.Position = UDim2.new(0.15,0,0.2,0)
    v1.Text = "V1"

    local v2 = Instance.new("TextButton", m)
    v2.Size = UDim2.new(0.7,0,0,40)
    v2.Position = UDim2.new(0.15,0,0.4,0)
    v2.Text = "V2"

    -- V1 PAGE
    local p1 = Instance.new("Frame", m)
    p1.Size = UDim2.new(1,0,1,0)
    p1.Visible = false

    local back1 = Instance.new("TextButton", p1)
    back1.Text = "<"
    back1.Size = UDim2.new(0,35,0,35)

    local saveBtn = Instance.new("TextButton", p1)
    saveBtn.Text = "SAVE"
    saveBtn.Size = UDim2.new(0.7,0,0,40)
    saveBtn.Position = UDim2.new(0.15,0,0.2,0)

    local list = Instance.new("Frame", p1)
    list.Size = UDim2.new(0.7,0,0.4,0)
    list.Position = UDim2.new(0.15,0,0.4,0)

    local layout = Instance.new("UIListLayout", list)

    local run = Instance.new("TextButton", p1)
    run.Text = "RUN"
    run.Size = UDim2.new(0,60,0,35)
    run.Position = UDim2.new(0,5,1,-40)

    local delAll = Instance.new("TextButton", p1)
    delAll.Text = "DELETE"
    delAll.Size = UDim2.new(0,80,0,35)
    delAll.Position = UDim2.new(1,-85,1,-40)

    local pts = {}
    local looping = false

    local function tp(pos)
        local c = p.Character or p.CharacterAdded:Wait()
        local hrp = c:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
    end

    local function refresh()
        list:ClearAllChildren()
        layout.Parent = list
        for i,pos in ipairs(pts) do
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1,0,0,30)
            b.Text = tostring(i)
            b.MouseButton1Click:Connect(function()
                tp(pos)
            end)
        end
    end

    saveBtn.MouseButton1Click:Connect(function()
        if #pts >= 10 then return end
        local c = p.Character or p.CharacterAdded:Wait()
        local pos = c:WaitForChild("HumanoidRootPart").Position
        table.insert(pts, pos)
        refresh()
    end)

    run.MouseButton1Click:Connect(function()
        looping = not looping
        run.Text = looping and "STOP" or "RUN"

        if looping then
            task.spawn(function()
                while looping do
                    for _,pos in ipairs(pts) do
                        if not looping then break end
                        tp(pos)
                        task.wait(2)
                    end
                end
            end)
        end
    end)

    delAll.MouseButton1Click:Connect(function()
        pts = {}
        refresh()
    end)

    -- V2 PAGE (แก้ให้ครบแล้ว)
    local p2 = Instance.new("Frame", m)
    p2.Size = UDim2.new(1,0,1,0)
    p2.Visible = false

    local back2 = Instance.new("TextButton", p2)
    back2.Text = "<"
    back2.Size = UDim2.new(0,35,0,35)

    local label = Instance.new("TextLabel", p2)
    label.Size = UDim2.new(1,0,0,50)
    label.Position = UDim2.new(0,0,0.3,0)
    label.Text = "V2 COMING SOON"

    -- ปุ่มสลับหน้า
    v1.MouseButton1Click:Connect(function()
        p1.Visible = true
        p2.Visible = false
    end)

    v2.MouseButton1Click:Connect(function()
        p1.Visible = false
        p2.Visible = true
    end)

    back1.MouseButton1Click:Connect(function()
        p1.Visible = false
    end)

    back2.MouseButton1Click:Connect(function()
        p2.Visible = false
    end)
end

createMain()
