repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

------------------------------------------------
-- CONFIG
------------------------------------------------
local CORRECT_KEY = "1536"
local SESSION_TIME = 24 * 60 * 60

------------------------------------------------
-- SESSION
------------------------------------------------
local session = {
	start = nil
}

local function validSession()
	if not session.start then return false end
	return (os.time() - session.start) < SESSION_TIME
end

------------------------------------------------
-- UI ROOT
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "PinkkyHub_PRO"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- KEY UI
------------------------------------------------
local keyUI = Instance.new("Frame")
keyUI.Size = UDim2.new(0, 320, 0, 200)
keyUI.Position = UDim2.new(0.5, -160, 0.5, -100)
keyUI.BackgroundColor3 = Color3.fromRGB(10,10,10)
keyUI.Parent = gui

local box = Instance.new("TextBox")
box.Size = UDim2.new(0, 220, 0, 40)
box.Position = UDim2.new(0.5, -110, 0.4, 0)
box.PlaceholderText = "ENTER KEY"
box.Parent = keyUI

local enter = Instance.new("TextButton")
enter.Size = UDim2.new(0, 120, 0, 35)
enter.Position = UDim2.new(0.5, -60, 0.7, 0)
enter.Text = "UNLOCK"
enter.Parent = keyUI

local errorText = Instance.new("TextLabel")
errorText.Size = UDim2.new(1,0,0,30)
errorText.Position = UDim2.new(0,0,0.1,0)
errorText.TextColor3 = Color3.fromRGB(255,0,0)
errorText.BackgroundTransparency = 1
errorText.Parent = keyUI

------------------------------------------------
-- MAIN HUB
------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 650, 0, 380)
main.Position = UDim2.new(0.5, -325, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(20,20,35)
main.Visible = false
main.Parent = gui

local topbar = Instance.new("TextLabel")
topbar.Size = UDim2.new(1,0,0,40)
topbar.Text = "PINKKY HUB PRO"
topbar.TextColor3 = Color3.fromRGB(255,255,255)
topbar.BackgroundColor3 = Color3.fromRGB(15,15,25)
topbar.TextXAlignment = Enum.TextXAlignment.Left
topbar.Parent = main

------------------------------------------------
-- DRAG UI
------------------------------------------------
local dragging, startPos, startInput

topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startInput = input.Position
		startPos = main.Position
	end
end)

topbar.InputEnded:Connect(function()
	dragging = false
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - startInput
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

------------------------------------------------
-- LEFT MENU
------------------------------------------------
local left = Instance.new("Frame")
left.Size = UDim2.new(0,160,1,-40)
left.Position = UDim2.new(0,0,0,40)
left.BackgroundColor3 = Color3.fromRGB(15,15,25)
left.Parent = main

local right = Instance.new("Frame")
right.Size = UDim2.new(1,-160,1,-40)
right.Position = UDim2.new(0,160,0,40)
right.BackgroundColor3 = Color3.fromRGB(30,30,50)
right.Parent = main

local function clear()
	for _,v in pairs(right:GetChildren()) do
		v:Destroy()
	end
end

local function btn(text,y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,0,0,50)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(0,120,255)
	b.TextColor3 = Color3.fromRGB(0,0,0)
	b.Parent = left
	return b
end

local VIVE = btn("VIVE",0)
local TP = btn("TP",0.2)

------------------------------------------------
-- VIVE MODULE
------------------------------------------------
VIVE.MouseButton1Click:Connect(function()
	clear()

	local panel = Instance.new("Frame")
	panel.Size = UDim2.new(1,0,1,0)
	panel.BackgroundColor3 = Color3.fromRGB(35,35,60)
	panel.Parent = right

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,0,50)
	title.Text = "DELETE MAP MODULE"
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.BackgroundTransparency = 1
	title.Parent = panel

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,220,0,50)
	btn.Position = UDim2.new(0.5,-110,0.4,0)
	btn.Text = "ACTIVATE"
	btn.Parent = panel

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.LocalTransparencyModifier = 1
			end
		end
	end)
end)

------------------------------------------------
-- TP MODULE
------------------------------------------------
local points = {}
local running = false

TP.MouseButton1Click:Connect(function()
	clear()

	local save = Instance.new("TextButton")
	save.Size = UDim2.new(0,160,0,40)
	save.Position = UDim2.new(0.5,-80,0.2,0)
	save.Text = "SAVE POINT"
	save.Parent = right

	local run = Instance.new("TextButton")
	run.Size = UDim2.new(0,120,0,40)
	run.Position = UDim2.new(0.1,0,0.8,0)
	run.Text = "RUN"
	run.Parent = right

	local del = Instance.new("TextButton")
	del.Size = UDim2.new(0,120,0,40)
	del.Position = UDim2.new(0.7,0,0.8,0)
	del.Text = "RESET"
	del.Parent = right

	save.MouseButton1Click:Connect(function()
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if hrp and #points < 10 then
			table.insert(points, hrp.Position)
		end
	end)

	run.MouseButton1Click:Connect(function()
		running = not running

		if running then
			task.spawn(function()
				while running do
					for i = 1,#points do
						if not running then break end
						local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.CFrame = CFrame.new(points[i])
						end
						task.wait(1)
					end
				end
			end)
		end
	end)

	del.MouseButton1Click:Connect(function()
		running = false
		points = {}
	end)
end)

------------------------------------------------
-- KEY SYSTEM
------------------------------------------------
enter.MouseButton1Click:Connect(function()
	if box.Text == CORRECT_KEY then
		session.start = os.time()
		keyUI.Visible = false
		main.Visible = true
	else
		errorText.Text = "INVALID KEY"
	end
end)

------------------------------------------------
-- SESSION CHECK
------------------------------------------------
task.spawn(function()
	while true do
		task.wait(5)
		if main.Visible and not validSession() then
			main.Visible = false
			keyUI.Visible = true
			session.start = nil
			errorText.Text = "SESSION EXPIRED"
		end
	end
end)
