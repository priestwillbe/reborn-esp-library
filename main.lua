local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CharacterHeightScale = 6

local EspLibrary = {}
EspLibrary.__index = EspLibrary

EspLibrary.EspTable = {}

function AnimateGradient(Gradient)
	TweenService:Create(Gradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Rotation = 180}):Play()
end

function EspLibrary:CreateBoxEsp(Player, Gradient1, Gradient2)
	if Player.Character == nil then 
		return 
	end

	local Root = Player.Character:WaitForChild("HumanoidRootPart")

	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "BoxEsp"
	Billboard.Adornee = Root
	Billboard.Size = UDim2.fromScale(4, CharacterHeightScale)
	Billboard.AlwaysOnTop = true
	Billboard.LightInfluence = 0
	Billboard.Parent = Player.Character

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Billboard

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1.25
	Stroke.Color = Color3.fromRGB(255, 255, 255)
	Stroke.Parent = Frame

	local Gradient = Instance.new("UIGradient")
	Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Gradient1), ColorSequenceKeypoint.new(1, Gradient2)})
	Gradient.Parent = Stroke

	AnimateGradient(Gradient)

	self.EspTable[Player] = self.EspTable[Player] or {}
	self.EspTable[Player].Box = Billboard
end

function EspLibrary:CreateHealthBar(Player, Gradient1, Gradient2)
	if Player.Character == nil then 
		return 
	end

	local Character = Player.Character
	local Humanoid = Character:WaitForChild("Humanoid")
	local Root = Character:WaitForChild("HumanoidRootPart")

	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "HealthEsp"
	Billboard.Adornee = Root
	Billboard.Size = UDim2.fromScale(0.15, CharacterHeightScale)
	Billboard.StudsOffset = Vector3.new(-2.3, 0, 0)
	Billboard.AlwaysOnTop = true
	Billboard.LightInfluence = 0
	Billboard.Parent = Character

	local Outline = Instance.new("Frame")
	Outline.Size = UDim2.fromScale(1, 1)
	Outline.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Outline.BorderSizePixel = 0
	Outline.Parent = Billboard

	local Padding = Instance.new("UIPadding")
	Padding.PaddingTop = UDim.new(0, 1)
	Padding.PaddingBottom = UDim.new(0, 1)
	Padding.PaddingLeft = UDim.new(0, 1)
	Padding.PaddingRight = UDim.new(0, 1)
	Padding.Parent = Outline

	local Background = Instance.new("Frame")
	Background.Size = UDim2.fromScale(1, 1)
	Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Background.BorderSizePixel = 0
	Background.Parent = Outline

	local Fill = Instance.new("Frame")
	Fill.AnchorPoint = Vector2.new(0, 1)
	Fill.Position = UDim2.fromScale(0, 1)
	Fill.Size = UDim2.fromScale(1, 1)
	Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Fill.BorderSizePixel = 0
	Fill.Parent = Background

	local Gradient = Instance.new("UIGradient")
	Gradient.Rotation = 90
	Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Gradient1), ColorSequenceKeypoint.new(1, Gradient2)})
	Gradient.Parent = Fill

	Humanoid.HealthChanged:Connect(function()
		local Alpha = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
		TweenService:Create(Fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, Alpha)}):Play()
	end)
	local Alpha = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
	TweenService:Create(Fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, Alpha)}):Play()

	self.EspTable[Player] = self.EspTable[Player] or {}
	self.EspTable[Player].Health = Billboard
end

function EspLibrary:CreateNameEsp(Player)
	if Player.Character == nil then 
		return 
	end

	local Character = Player.Character
	local Root = Character:WaitForChild("HumanoidRootPart")

	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "NameEsp"
	Billboard.Adornee = Root
	Billboard.Size = UDim2.fromScale(4, 1)
	Billboard.StudsOffset = Vector3.new(0, CharacterHeightScale / 2 + 0.6, 0)
	Billboard.AlwaysOnTop = true
	Billboard.LightInfluence = 0
	Billboard.Parent = Character

	local Text = Instance.new("TextLabel")
	Text.Size = UDim2.fromScale(1, 1)
	Text.BackgroundTransparency = 1
	Text.Text = Player.Name
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.Font = Enum.Font.GothamBold
	Text.TextScaled = false 
	Text.TextSize = 10
	Text.Parent = Billboard

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1
	Stroke.Color = Color3.fromRGB(0, 0, 0)
	Stroke.Parent = Text

	local Con
	Con = RunService.RenderStepped:Connect(function()
		if not Root.Parent then
			Con:Disconnect()
			return
		end

		local Distance = (Camera.CFrame.Position - Root.Position).Magnitude
		Text.TextSize = 10 - 0 * math.clamp((Distance - 10) / (math.huge - 10), 0, 1)
	end)

	self.EspTable[Player] = self.EspTable[Player] or {}
	self.EspTable[Player].Name = Billboard
end
return EspLibrary
