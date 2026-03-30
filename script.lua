local p=game.Players.LocalPlayer local g=Instance.new("ScreenGui",p:WaitForChild("PlayerGui")) g.ResetOnSpawn=false local keyValid=false local expire=0 local admin=false

local function createMain()
local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,260,0,320)
m.Position=UDim2.new(0.5,-130,0.5,-160)
m.BackgroundColor3=Color3.fromRGB(0,0,0)
m.BackgroundTransparency=0.2
m.Active=true m.Draggable=true

local t=Instance.new("TextLabel",m)
t.Size=UDim2.new(1,0,0,35)
t.Text="PINKKY"
t.TextColor3=Color3.new(1,1,1)
t.BackgroundTransparency=1

local v1=Instance.new("TextButton",m)
v1.Size=UDim2.new(0.7,0,0,40)
v1.Position=UDim2.new(0.15,0,0.2,0)
v1.Text="V1"
v1.BackgroundColor3=Color3.fromRGB(150,150,150)
v1.TextColor3=Color3.fromRGB(0,0,0)

local v2=Instance.new("TextButton",m)
v2.Size=UDim2.new(0.7,0,0,40)
v2.Position=UDim2.new(0.15,0,0.4,0)
v2.Text="V2"
v2.BackgroundColor3=Color3.fromRGB(150,150,150)
v2.TextColor3=Color3.fromRGB(0,0,0)

-- V1 PAGE
local p1=Instance.new("Frame",m)
p1.Size=UDim2.new(1,0,1,0)
p1.BackgroundColor3=Color3.fromRGB(0,0,0)
p1.BackgroundTransparency=0.2
p1.Visible=false

local back1=Instance.new("TextButton",p1)
back1.Text="<"
back1.Size=UDim2.new(0,35,0,35)
back1.BackgroundColor3=Color3.fromRGB(150,150,150)
back1.TextColor3=Color3.fromRGB(0,0,0)

local saveBtn=Instance.new("TextButton",p1)
saveBtn.Text="V1."
saveBtn.Size=UDim2.new(0.7,0,0,40)
saveBtn.Position=UDim2.new(0.15,0,0.2,0)
saveBtn.BackgroundColor3=Color3.fromRGB(150,150,150)
saveBtn.TextColor3=Color3.fromRGB(0,0,0)

local list=Instance.new("Frame",p1)
list.Size=UDim2.new(0.7,0,0.4,0)
list.Position=UDim2.new(0.15,0,0.4,0)
list.BackgroundTransparency=1

local layout=Instance.new("UIListLayout",list)

local run=Instance.new("TextButton",p1)
run.Text="RUN"
run.Size=UDim2.new(0,60,0,35)
run.Position=UDim2.new(0,5,1,-40)
run.BackgroundColor3=Color3.fromRGB(150,150,150)
run.TextColor3=Color3.fromRGB(0,0,0)

local delAll=Instance.new("TextButton",p1)
delAll.Text="DELETE"
delAll.Size=UDim2.new(0,80,0,35)
delAll.Position=UDim2.new(1,-85,1,-40)
delAll.BackgroundColor3=Color3.fromRGB(150,150,150)
delAll.TextColor3=Color3.fromRGB(0,0,0)

local pts={}
local looping=false

local function tp(pos)
local c=p.Character or p.CharacterAdded:Wait()
local hrp=c:WaitForChild("HumanoidRootPart")
hrp.CFrame=CFrame.new(pos+Vector3.new(0,5,0))
end

local function refresh()
list:ClearAllChildren()
layout.Parent=list
for i,pos in ipairs(pts) do
local b=Instance.new("TextButton",list)
b.Size=UDim2.new(1,0,0,30)
b.Text=tostring(i)
b.BackgroundColor3=Color3.fromRGB(150,150,150)
b.TextColor3=Color3.fromRGB(0,0,0)
b.MouseButton1Click:Connect(function() tp(pos) end)
end
end

saveBtn.MouseButton1Click:Connect(function()
if #pts>=10 then return end
local c=p.Character or p.CharacterAdded:Wait()
local pos=c:WaitForChild("HumanoidRootPart").Position
table.insert(pts,pos)
refresh()
end)

run.MouseButton1Click:Connect(function()
looping=not looping
run.Text=looping and "STOP" or "RUN"
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
pts={}
refresh()
end)

-- V2 PAGE
local p2=Instance.new("Frame",m)
p2.Size=UDim2.new(1,0,1,0)
p2.BackgroundColor3=Color3.fromRGB(0,0,0)
p2.BackgroundTransparency=0.2
p2.Visible=false

local back2=Instance.new("TextButton",p2)
back2.Text="<"
back2.Size=UDim2.new(0,35,0,35)
back2.BackgroundColor3=Color3.fromRGB(150,150,150)

local to
