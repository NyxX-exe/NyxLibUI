local library = {}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

function library:CreateWindow(titleText)
	local Window = {}

	local Screen = Instance.new("ScreenGui")
	Screen.Name = "NyxUI"
	Screen.Parent = Player:WaitForChild("PlayerGui")

	local TopBar = Instance.new("ImageLabel")
	TopBar.Name = "TopBar"
	TopBar.Parent = Screen
	TopBar.AnchorPoint = Vector2.new(0.5, 0.5)
	TopBar.Position = UDim2.new(0.5, 0, 0.2, 0)
	TopBar.Size = UDim2.new(0, 500, 0, 25)
	TopBar.Image = "rbxassetid://3570695787"
	TopBar.ImageColor3 = Color3.fromRGB(33, 32, 49)
	TopBar.SliceCenter = Rect.new(100, 100, 100, 100)
	TopBar.SliceScale = 0.03
	TopBar.Draggable = true

	local Title = Instance.new("TextLabel")
	Title.Parent = TopBar
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0.05, 0, 0, 0)
	Title.Size = UDim2.new(0, 400, 0, 25)
	Title.Font = Enum.Font.SourceSansSemibold
	Title.Text = titleText or "Nyx Library"
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.TextSize = 14

	local ToggleButton = Instance.new("ImageButton")
	ToggleButton.Parent = TopBar
	ToggleButton.Size = UDim2.new(0, 20, 0, 20)
	ToggleButton.Position = UDim2.new(0, 5, 0, 2)
	ToggleButton.Image = "rbxassetid://4731371541"
	ToggleButton.ImageColor3 = Color3.new(1, 1, 1)
	ToggleButton.Rotation = 90

	local MainFrame = Instance.new("ImageLabel")
	MainFrame.Parent = TopBar
	MainFrame.Position = UDim2.new(0.5, 0, 6.5, 0)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Size = UDim2.new(0, 500, 0, 300)
	MainFrame.Image = "rbxassetid://3570695787"
	MainFrame.ImageColor3 = Color3.fromRGB(20, 20, 20)
	MainFrame.SliceCenter = Rect.new(100, 100, 100, 100)
	MainFrame.SliceScale = 0.03

	local Tabs = Instance.new("Frame")
	Tabs.Parent = MainFrame
	Tabs.Position = UDim2.new(0, 0, 0, 0)
	Tabs.Size = UDim2.new(0, 120, 0, 300)
	Tabs.BackgroundTransparency = 1

	local UIGrid = Instance.new("UIGridLayout")
	UIGrid.Parent = Tabs
	UIGrid.SortOrder = Enum.SortOrder.LayoutOrder
	UIGrid.CellSize = UDim2.new(0, 120, 0, 30)

	local Items = Instance.new("Frame")
	Items.Parent = MainFrame
	Items.Position = UDim2.new(0, 130, 0, 0)
	Items.Size = UDim2.new(0, 360, 0, 300)
	Items.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	local isOpen = true
	ToggleButton.MouseButton1Click:Connect(function()
		if isOpen then
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 0)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Rotation = -90}):Play()
			task.wait(0.3)
			MainFrame.Visible = false
		else
			MainFrame.Visible = true
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 300)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Rotation = 90}):Play()
		end
		isOpen = not isOpen
	end)

	function Window:CreateTab(tabName)
		local Tab = {}

		local TabButton = Instance.new("TextButton")
		TabButton.Parent = Tabs
		TabButton.Text = tabName
		TabButton.Size = UDim2.new(0, 120, 0, 30)
		TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		TabButton.TextColor3 = Color3.new(1, 1, 1)

		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Parent = Items
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.BackgroundTransparency = 1
		TabFrame.ScrollBarThickness = 5
		TabFrame.Visible = false

		local Layout = Instance.new("UIListLayout")
		Layout.Parent = TabFrame
		Layout.Padding = UDim.new(0, 5)

		TabButton.MouseButton1Click:Connect(function()
			for _, child in ipairs(Items:GetChildren()) do
				if child:IsA("ScrollingFrame") then
					child.Visible = false
				end
			end
			TabFrame.Visible = true
		end)

		function Tab:Button(text, callback)
			local Btn = Instance.new("TextButton")
			Btn.Parent = TabFrame
			Btn.Size = UDim2.new(1, -10, 0, 30)
			Btn.Text = text
			Btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Btn.TextColor3 = Color3.new(1, 1, 1)

			Btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		function Tab:Toggle(text, default, callback)
			local state = default or false
			local Btn = Instance.new("TextButton")
			Btn.Parent = TabFrame
			Btn.Size = UDim2.new(1, -10, 0, 30)
			Btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Btn.TextColor3 = Color3.new(1, 1, 1)
			Btn.Text = text .. ": " .. tostring(state)

			Btn.MouseButton1Click:Connect(function()
				state = not state
				Btn.Text = text .. ": " .. tostring(state)
				if callback then callback(state) end
			end)
		end

		return Tab
	end

	return Window
end

return library
