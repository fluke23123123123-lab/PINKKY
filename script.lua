repeat task.wait() until game:IsLoaded()

local p = game.Players.LocalPlayer
local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
g.ResetOnSpawn = false

local function createMain()
    local m = Instance.new("Frame", g)
    m.Size = UDim2.new(0,260,0,320)
    m.Position = UDim2.new(0.5,-130,0.5,-160)
    m.BackgroundColor3 = Color3.fromRGB(0,0,0)
    m.BackgroundTransparency = 0
    m.Active = true
    m.Draggable = true

    local t = Instance.new("TextLabel", m)
    t.Size = UDim2.new(1,0,0,35)
    t.Text = "PINKKY"
    t.TextColor3 = Color3.fromRGB(0,0,0)
    t.BackgroundTransparency = 1

    local function createBtn(parent, text, posY)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(0.7,0,0,40)
        b.Position = UDim2.new(0.15,0,posY,0)
        b.Text = text
        b.BackgroundColor3 = Color3.fromRGB(180,180,180)
        b.TextColor3 = Color3.fromRGB(0,0,0)
        return b
    end

    local v1 = createBtn(m,"V1",0.2)
    local v2 = createBtn(m,"V2",0.4)

    -- ================= V1 =================
    local p1 = Instance.new("Frame", m)
    p1.Size = UDim2.new(1,0,1,0)
    p1.BackgroundColor3 = Color3.fromRGB(0,0,0)
    p1.Visible = false

    local back1 = createBtn(p1,"<",0)
    back1.Size = UDim2.new(0,35,0,35)

    local saveBtn = createBtn(p1,"SAVE",0.2)

    local list = Instance.new("Frame", p1)
    list.Size = UDim2.new(0.7,0,0.4,0)
    list.Position = UDim2.new(0.15,0,0.4,0)
    list.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", list)

    local run = createBtn(p1,"RUN",0.85)
    run.Size = UDim2.new(0,60,0,35)
    run.Position = UDim2.new(0,5,1,-40)

    local delAll = createBtn(p1,"DELETE",0.85)
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
            b.BackgroundColor3 = Color3.fromRGB(180,180,180)
            b.TextColor3 = Color3.fromRGB(0,0,0)
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

    -- ================= V2 =================
    local p2 = Instance.new("Frame", m)
    p2.Size = UDim2.new(1,0,1,0)
    p2.BackgroundColor3 = Color3.fromRGB(0,0,0)
    p2.Visible = false

    local back2 = createBtn(p2,"<",0)
    back2.Size = UDim2.new(0,35,0,35)

    local delMap = createBtn(p2,"DELETE MAP",0.3)

    delMap.MouseButton1Click:Connect(function()
        -- พื้นกันตก
        local base = Instance.new("Part", workspace)
        base.Size = Vector3.new(500,10,500)
        base.Position = Vector3.new(0,-10,0)
        base.Anchored = true
        base.Name = "SafeFloor"

        -- ลบแมพ
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("Model") or v:IsA("Part") then
                if not v:FindFirstChild("Humanoid") and v.Name ~= "SafeFloor" then
                    v:Destroy()
                end
            end
        end
    end)

    -- ================= ปุ่มสลับ =================
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
