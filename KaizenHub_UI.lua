--[[
	Kaizen Hub UI Library  |  v2.0.0  |  by kaizenmeow
	Blue theme - responsive - animated components
	API-compatible with v1: CreateWindow -> CreateTab -> AddSection -> Add*
	New: AddKeybind, AddLabel, notification types, Flags + config save/load,
	     compact (icon-only) sidebar on small screens, auto-sizing cards,
	     touch-friendly sliders, inline searchable dropdowns.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local genv = (getgenv and getgenv()) or _G

local Library = {
	Version = "2.0.0",
	Flags = {},
	FlagObjects = {},
	Unloaded = false,
}
local Connections = {}

-- ============================== THEME ==============================
local Theme = {
	Background  = Color3.fromRGB(10, 14, 25),
	Topbar      = Color3.fromRGB(13, 19, 34),
	Panel       = Color3.fromRGB(15, 22, 38),
	Element     = Color3.fromRGB(21, 30, 52),
	ElementHover= Color3.fromRGB(27, 40, 70),
	Off         = Color3.fromRGB(33, 45, 77),
	Stroke      = Color3.fromRGB(38, 55, 94),
	Accent      = Color3.fromRGB(59, 130, 246),
	AccentLight = Color3.fromRGB(96, 165, 250),
	AccentDark  = Color3.fromRGB(29, 78, 216),
	Text        = Color3.fromRGB(236, 243, 255),
	SubText     = Color3.fromRGB(139, 160, 199),
	Success     = Color3.fromRGB(52, 211, 153),
	Warning     = Color3.fromRGB(251, 191, 36),
	Error       = Color3.fromRGB(248, 113, 113),
}
Library.Theme = Theme

-- ============================== ICONS ==============================
local ICON_URL = "https://raw.githubusercontent.com/biarzxc1/kaizenhub/refs/heads/main/Icons.lua"
local Icons
pcall(function()
	local result = loadstring(game:HttpGet(ICON_URL))()
	if type(result) == "table" then Icons = result end
end)
Library.Icons = Icons

function Library:SetIcons(tbl)
	Icons = tbl
	Library.Icons = tbl
end

local function ResolveIcon(v)
	if type(v) ~= "string" or v == "" then return "" end
	if v:find("rbxassetid://", 1, true) or v:find("rbxasset://", 1, true) then return v end
	if Icons and Icons.assets then
		local key = v:find("lucide-", 1, true) and v or ("lucide-" .. v)
		return Icons.assets[key] or Icons.assets[v] or ""
	end
	return ""
end

-- ============================== HELPERS ==============================
local function GetViewport()
	local cam = workspace.CurrentCamera
	return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

local function New(class, props, children)
	local inst = Instance.new(class)
	local parent
	for k, v in pairs(props or {}) do
		if k == "Parent" then parent = v else inst[k] = v end
	end
	for _, child in ipairs(children or {}) do child.Parent = inst end
	if parent then inst.Parent = parent end
	return inst
end

local function Corner(parent, r)
	return New("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = parent })
end

local function Stroke(parent, color, thickness, transparency)
	return New("UIStroke", {
		Color = color or Theme.Stroke,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function Pad(parent, l, t, r, b)
	return New("UIPadding", {
		PaddingLeft = UDim.new(0, l), PaddingTop = UDim.new(0, t or l),
		PaddingRight = UDim.new(0, r or l), PaddingBottom = UDim.new(0, b or t or l),
		Parent = parent,
	})
end

local function Gradient(parent, c0, c1, rotation)
	return New("UIGradient", {
		Color = ColorSequence.new(c0, c1),
		Rotation = rotation or 0,
		Parent = parent,
	})
end

local function Tween(obj, props, t, style, dir)
	local tw = TweenService:Create(obj, TweenInfo.new(t or 0.15, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function Connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(Connections, c)
	return c
end

local function Safe(fn, ...)
	if type(fn) ~= "function" then return end
	task.spawn(function(...)
		local ok, err = pcall(fn, ...)
		if not ok then warn("[KaizenHub] callback error: " .. tostring(err)) end
	end, ...)
end

local function IsPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

local function IsMove(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
end

local function MakeIcon(parent, name, size, color, fallback)
	local img = ResolveIcon(name)
	if img ~= "" then
		return New("ImageLabel", {
			BackgroundTransparency = 1, Image = img, ImageColor3 = color,
			Size = UDim2.fromOffset(size, size), Parent = parent,
		})
	end
	return New("TextLabel", {
		BackgroundTransparency = 1, Text = fallback or "•", Font = Enum.Font.GothamBold,
		TextSize = size, TextColor3 = color, Size = UDim2.fromOffset(size, size), Parent = parent,
	})
end

local function SetIconColor(icon, color)
	if icon:IsA("ImageLabel") then icon.ImageColor3 = color else icon.TextColor3 = color end
end

local function TweenIconColor(icon, color, t)
	Tween(icon, { [icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"] = color }, t or 0.15)
end

local function Ripple(btn, x, y)
	task.spawn(function()
		local c = New("Frame", {
			BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.85, BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y),
			Size = UDim2.fromOffset(0, 0), ZIndex = btn.ZIndex + 1, Parent = btn,
		})
		Corner(c, 999)
		local d = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.2
		Tween(c, { Size = UDim2.fromOffset(d, d), BackgroundTransparency = 1 }, 0.5)
		task.wait(0.52)
		c:Destroy()
	end)
end

local function AttachRipple(btn)
	btn.ClipsDescendants = true
	btn.InputBegan:Connect(function(input)
		if IsPress(input) then
			Ripple(btn, input.Position.X - btn.AbsolutePosition.X, input.Position.Y - btn.AbsolutePosition.Y)
		end
	end)
end

local function ClampOnScreen(obj, margin)
	task.defer(function()
		if not obj or not obj.Parent then return end
		local vp = GetViewport()
		local ap, as = obj.AbsolutePosition, obj.AbsoluteSize
		local m = margin or 40
		local dx, dy = 0, 0
		if ap.X + as.X < m + 40 then dx = m + 40 - (ap.X + as.X) elseif ap.X > vp.X - m then dx = vp.X - m - ap.X end
		if ap.Y < 0 then dy = -ap.Y elseif ap.Y > vp.Y - m then dy = vp.Y - m - ap.Y end
		if dx ~= 0 or dy ~= 0 then
			local p = obj.Position
			Tween(obj, { Position = UDim2.new(p.X.Scale, p.X.Offset + dx, p.Y.Scale, p.Y.Offset + dy) }, 0.2)
		end
	end)
end

local function MakeDraggable(handle, target, onClick)
	local dragging, moved, startMouse, startPos = false, false, nil, nil
	handle.InputBegan:Connect(function(input)
		if IsPress(input) then
			dragging, moved = true, false
			startMouse, startPos = input.Position, target.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if not moved and onClick then onClick() end
					ClampOnScreen(target)
				end
			end)
		end
	end)
	Connect(UserInputService.InputChanged, function(input)
		if dragging and IsMove(input) then
			local d = input.Position - startMouse
			if d.Magnitude > 5 then moved = true end
			if moved or not onClick then
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end
	end)
end

local function GetGuiParent()
	if RunService:IsStudio() then return Player:WaitForChild("PlayerGui") end
	if gethui then
		local ok, r = pcall(gethui)
		if ok and r then return r end
	end
	local ok, cg = pcall(function()
		return cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
	end)
	if ok and cg then return cg end
	return Player:WaitForChild("PlayerGui")
end

local function MakeGui(name, order)
	local parent = GetGuiParent()
	local old = parent:FindFirstChild(name)
	if old then old:Destroy() end
	local gui = New("ScreenGui", {
		Name = name, ResetOnSpawn = false, DisplayOrder = order or 100,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	if syn and syn.protect_gui then pcall(syn.protect_gui, gui) end
	gui.Parent = parent
	return gui
end

-- Anti-AFK (once)
function Library:EnableAFK()
	if genv.__KaizenAFK then return end
	genv.__KaizenAFK = true
	pcall(function()
		Player.Idled:Connect(function()
			local cam = workspace.CurrentCamera
			VirtualUser:Button2Down(Vector2.new(0, 0), cam and cam.CFrame or CFrame.new())
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0, 0), cam and cam.CFrame or CFrame.new())
		end)
	end)
end
Library:EnableAFK()

-- ============================== CARD ==============================
-- Card -> Row (min 44px, auto height) -> Body (padded; left text + right controls)
local function MakeCard(parent, order, title, content, rightW)
	local card = New("Frame", {
		Name = "Card", BackgroundColor3 = Theme.Element, BorderSizePixel = 0,
		LayoutOrder = order, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, Parent = parent,
	})
	Corner(card, 8)
	local stroke = Stroke(card, Theme.Stroke, 1, 0.35)
	New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = card })

	local row = New("Frame", {
		Name = "Row", BackgroundTransparency = 1, LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 44), AutomaticSize = Enum.AutomaticSize.Y, Parent = card,
	})
	local body = New("Frame", {
		Name = "Body", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = row,
	})
	Pad(body, 12, 9, 12, 9)

	local leftSize = rightW and UDim2.new(1 - rightW.Scale, -(rightW.Offset + 10), 0, 26) or UDim2.new(1, 0, 0, 26)
	local left = New("Frame", {
		Name = "Left", BackgroundTransparency = 1, Size = leftSize,
		AutomaticSize = Enum.AutomaticSize.Y, Parent = body,
	})
	New("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2),
		VerticalAlignment = Enum.VerticalAlignment.Center, Parent = left,
	})
	local titleLbl = New("TextLabel", {
		Name = "Title", Text = title or "", Font = Enum.Font.GothamMedium, TextSize = 14,
		TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = left,
	})
	local contentLbl = New("TextLabel", {
		Name = "Content", Text = content or "", Font = Enum.Font.Gotham, TextSize = 12,
		TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2,
		Visible = (content or "") ~= "", Parent = left,
	})
	return { Card = card, Row = row, Body = body, Title = titleLbl, Content = contentLbl, Stroke = stroke }
end

local function MakeOverlay(c, onClick, hover)
	local btn = New("TextButton", {
		Name = "Overlay", Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0), ZIndex = 5, Parent = c.Row,
	})
	AttachRipple(btn)
	if hover ~= false then
		btn.MouseEnter:Connect(function()
			Tween(c.Card, { BackgroundColor3 = Theme.ElementHover }, 0.12)
			Tween(c.Stroke, { Color = Theme.Accent, Transparency = 0.55 }, 0.12)
		end)
		btn.MouseLeave:Connect(function()
			Tween(c.Card, { BackgroundColor3 = Theme.Element }, 0.12)
			Tween(c.Stroke, { Color = Theme.Stroke, Transparency = 0.35 }, 0.12)
		end)
	end
	btn.Activated:Connect(onClick)
	return btn
end

-- ============================== NOTIFICATIONS ==============================
local NotifGui, NotifHolder

local function EnsureNotifHolder()
	if NotifGui and NotifGui.Parent then return end
	NotifGui = MakeGui("KaizenHub_Notify", 1000)
	NotifHolder = New("Frame", {
		Name = "Holder", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 320, 1, -32), Parent = NotifGui,
	})
	New("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8),
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		HorizontalAlignment = Enum.HorizontalAlignment.Right, Parent = NotifHolder,
	})
end

local NotifCount = 0
function Library:SetNotification(Config)
	if type(Config) == "string" then Config = { Config } end
	Config = Config or {}
	local title = Config[1] or Config.Title or ""
	local desc = Config[2] or Config.Description or ""
	local content = Config[3] or Config.Content or ""
	local animTime = tonumber(Config[5] or Config.Time) or 0.35
	local delay = tonumber(Config[6] or Config.Delay) or 5
	local kind = string.lower(tostring(Config.Type or "info"))
	local color = kind == "success" and Theme.Success or kind == "warning" and Theme.Warning
		or kind == "error" and Theme.Error or Theme.Accent
	local iconName = kind == "success" and "check-circle" or kind == "warning" and "alert-triangle"
		or kind == "error" and "x-circle" or "info"

	EnsureNotifHolder()
	local vp = GetViewport()
	NotifHolder.Size = UDim2.new(0, math.clamp(vp.X - 32, 220, 320), 1, -32)

	NotifCount += 1
	local wrap = New("Frame", {
		Name = "Notification", BackgroundTransparency = 1, LayoutOrder = NotifCount,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = NotifHolder,
	})
	local real = New("Frame", {
		BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Position = UDim2.new(0, 360, 0, 0),
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = wrap,
	})
	Corner(real, 8)
	Stroke(real, color, 1, 0.55)
	New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = real })

	local bodyF = New("Frame", {
		BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, Parent = real,
	})
	Pad(bodyF, 14, 12, 34, 10)
	New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3), Parent = bodyF })

	New("TextLabel", {
		Text = title, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = bodyF,
	})
	if desc ~= "" then
		New("TextLabel", {
			Text = desc, Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = color,
			TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2, Parent = bodyF,
		})
	end
	if content ~= "" then
		New("TextLabel", {
			Text = content, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 3, Parent = bodyF,
		})
	end

	local barBg = New("Frame", {
		BackgroundColor3 = Theme.Off, BorderSizePixel = 0, LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 3), Parent = real,
	})
	local barFill = New("Frame", { BackgroundColor3 = color, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Parent = barBg })

	local icon = MakeIcon(real, iconName, 16, color, "!")
	icon.AnchorPoint = Vector2.new(1, 0)
	icon.Position = UDim2.new(1, -12, 0, 12)

	local obj, closing = {}, false
	function obj:Close()
		if closing then return false end
		closing = true
		Tween(real, { Position = UDim2.new(0, 360, 0, 0) }, animTime, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		task.delay(animTime + 0.05, function() wrap:Destroy() end)
		return true
	end

	Tween(real, { Position = UDim2.new(0, 0, 0, 0) }, animTime, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(barFill, { Size = UDim2.new(0, 0, 1, 0) }, delay, Enum.EasingStyle.Linear)
	task.delay(delay, function() obj:Close() end)
	return obj
end
Library.Notify = Library.SetNotification

-- ============================== WINDOW ==============================
function Library:CreateWindow(Config)
	if type(Config) == "string" then Config = { Config } end
	Config = Config or {}
	local Title = Config[1] or Config.Title or "Kaizen Hub"
	local Version = Config.Version or "Version 2.0.0"
	local Author = Config.Author or "by kaizenmeow"
	local Description = Config[2] or Config.Description or (Version .. " | " .. Author)
	local TabWidth = Config[3] or Config["Tab Width"] or 140
	local SizeUi = Config[4] or Config.SizeUi or UDim2.fromOffset(580, 360)
	local ToggleKey = Config.ToggleKey or Enum.KeyCode.RightControl
	local HeaderIcon = Config.Icon or "gem"

	local Gui = MakeGui("KaizenHub_UI", 100)

	local Holder = New("Frame", {
		Name = "Holder", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0), Size = SizeUi, Parent = Gui,
	})
	local Scale = New("UIScale", { Scale = 1, Parent = Holder })
	New("ImageLabel", {
		Name = "Shadow", BackgroundTransparency = 1, Image = "rbxassetid://5028857084",
		ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 0.45,
		ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(24, 24, 276, 276),
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 48, 1, 48), ZIndex = 0, Parent = Holder,
	})
	local Main = New("Frame", {
		Name = "Main", BackgroundColor3 = Theme.Background, BorderSizePixel = 0,
		ClipsDescendants = true, Size = UDim2.new(1, 0, 1, 0), Parent = Holder,
	})
	Corner(Main, 10)
	Stroke(Main, Theme.Stroke, 1.2, 0.2)
	Gradient(Main, Color3.fromRGB(255, 255, 255), Color3.fromRGB(205, 220, 255), 90)

	-- Topbar
	local Top = New("Frame", {
		Name = "Top", BackgroundColor3 = Theme.Topbar, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 42), Parent = Main,
	})
	New("Frame", {
		BackgroundColor3 = Theme.Stroke, BackgroundTransparency = 0.35, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 1), Parent = Top,
	})
	local Logo = New("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(26, 26), Parent = Top,
	})
	Corner(Logo, 7)
	Gradient(Logo, Theme.AccentLight, Theme.AccentDark, 45)
	local LogoIcon = MakeIcon(Logo, HeaderIcon, 16, Color3.new(1, 1, 1), "K")
	LogoIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	LogoIcon.Position = UDim2.fromScale(0.5, 0.5)

	local TitleBox = New("Frame", {
		BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0, 44, 0, 0),
		Size = UDim2.new(1, -130, 1, 0), Parent = Top,
	})
	New("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), Parent = TitleBox,
	})
	local TitleLbl = New("TextLabel", {
		Text = Title, Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = Theme.Text,
		BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 1, Parent = TitleBox,
	})
	local DescLbl = New("TextLabel", {
		Text = Description, Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.AccentLight,
		BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2, Parent = TitleBox,
	})

	local function TopButton(iconName, fallback, xOff, hoverColor)
		local b = New("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundColor3 = hoverColor, BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, xOff, 0.5, 0),
			Size = UDim2.fromOffset(28, 28), Parent = Top,
		})
		Corner(b, 7)
		local ic = MakeIcon(b, iconName, 16, Theme.SubText, fallback)
		ic.AnchorPoint = Vector2.new(0.5, 0.5)
		ic.Position = UDim2.fromScale(0.5, 0.5)
		b.MouseEnter:Connect(function()
			Tween(b, { BackgroundTransparency = 0.75 }, 0.12)
			TweenIconColor(ic, Theme.Text, 0.12)
		end)
		b.MouseLeave:Connect(function()
			Tween(b, { BackgroundTransparency = 1 }, 0.12)
			TweenIconColor(ic, Theme.SubText, 0.12)
		end)
		return b
	end
	local CloseBtn = TopButton("x", "×", -8, Theme.Error)
	local MinBtn = TopButton("minus", "–", -42, Theme.Accent)

	-- Floating reopen button
	local OpenBtn = New("TextButton", {
		Name = "OpenButton", Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1),
		Position = UDim2.new(0, 16, 0, 80), Size = UDim2.fromOffset(46, 46), Visible = false, Parent = Gui,
	})
	Corner(OpenBtn, 23)
	Gradient(OpenBtn, Theme.AccentLight, Theme.AccentDark, 45)
	Stroke(OpenBtn, Theme.AccentLight, 1.2, 0.3)
	local OpenIcon = MakeIcon(OpenBtn, "menu", 22, Color3.new(1, 1, 1), "≡")
	OpenIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	OpenIcon.Position = UDim2.fromScale(0.5, 0.5)

	-- Body
	local Body = New("Frame", {
		BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 43), Size = UDim2.new(1, 0, 1, -43), Parent = Main,
	})
	local Sidebar = New("Frame", {
		Name = "Sidebar", BackgroundColor3 = Theme.Panel, BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 0, 8), Size = UDim2.new(0, TabWidth, 1, -16), Parent = Body,
	})
	Corner(Sidebar, 8)
	Stroke(Sidebar, Theme.Stroke, 1, 0.5)
	local TabScroll = New("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Size = UDim2.new(1, 0, 1, 0), Parent = Sidebar,
	})
	Pad(TabScroll, 6, 6, 6, 6)
	New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = TabScroll })

	local Content = New("Frame", {
		Name = "Content", BackgroundTransparency = 1, Position = UDim2.new(0, TabWidth + 16, 0, 8),
		Size = UDim2.new(1, -(TabWidth + 24), 1, -16), Parent = Body,
	})
	local PageTitle = New("TextLabel", {
		Text = "", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 26), Parent = Content,
	})
	local Pages = New("Frame", {
		BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0, 0, 0, 32),
		Size = UDim2.new(1, 0, 1, -32), Parent = Content,
	})

	-- ============ responsive layout ============
	local TabList, Current = {}, nil
	local Compact = false
	local function Relayout()
		local vp = GetViewport()
		local w = math.max(math.min(SizeUi.X.Offset, vp.X - 20), 260)
		local h = math.max(math.min(SizeUi.Y.Offset, vp.Y - 70), 220)
		Holder.Size = UDim2.fromOffset(w, h)
		Compact = w < 520
		local sw = Compact and 46 or TabWidth
		Sidebar.Size = UDim2.new(0, sw, 1, -16)
		Content.Position = UDim2.new(0, sw + 16, 0, 8)
		Content.Size = UDim2.new(1, -(sw + 24), 1, -16)
		DescLbl.Visible = w >= 440
		TitleBox.Size = UDim2.new(1, -90, 1, 0)
		for _, t in ipairs(TabList) do t.ApplyCompact(Compact) end
		ClampOnScreen(Holder)
	end

	local camConn
	local function HookCamera()
		if camConn then camConn:Disconnect() end
		local cam = workspace.CurrentCamera
		if cam then
			camConn = cam:GetPropertyChangedSignal("ViewportSize"):Connect(Relayout)
			table.insert(Connections, camConn)
		end
	end
	HookCamera()
	Connect(workspace:GetPropertyChangedSignal("CurrentCamera"), function() HookCamera() Relayout() end)

	-- ============ show / hide ============
	local Visible = true
	local function SetVisible(v)
		Visible = v
		if v then
			OpenBtn.Visible = false
			Holder.Visible = true
			Scale.Scale = 0.92
			Tween(Scale, { Scale = 1 }, 0.22, Enum.EasingStyle.Back)
		else
			Holder.Visible = false
			OpenBtn.Visible = true
		end
	end
	MinBtn.Activated:Connect(function() SetVisible(false) end)
	MakeDraggable(OpenBtn, OpenBtn, function() SetVisible(true) end)
	MakeDraggable(Top, Holder)
	Connect(UserInputService.InputBegan, function(input, gp)
		if not gp and input.KeyCode == ToggleKey then SetVisible(not Visible) end
	end)
	CloseBtn.Activated:Connect(function()
		Library:Destroy()
	end)

	function Library:Destroy()
		Library.Unloaded = true
		for _, c in ipairs(Connections) do pcall(function() c:Disconnect() end) end
		table.clear(Connections)
		if Gui then Gui:Destroy() end
	end

	-- ============ tabs ============
	local Window = {}
	local CountTab = 0

	local function SelectTab(rec)
		if Current == rec then return end
		Current = rec
		for _, t in ipairs(TabList) do
			local on = (t == rec)
			Tween(t.Btn, { BackgroundTransparency = on and 0.78 or 1 }, 0.18)
			Tween(t.Bar, { Size = UDim2.new(0, 3, 0, on and 16 or 0) }, 0.18)
			TweenIconColor(t.Icon, on and Theme.AccentLight or Theme.SubText, 0.18)
			Tween(t.Label, { TextColor3 = on and Theme.Text or Theme.SubText }, 0.18)
			t.Page.Visible = on
		end
		PageTitle.Text = rec.Name
		rec.Page.Position = UDim2.fromOffset(0, 12)
		Tween(rec.Page, { Position = UDim2.fromOffset(0, 0) }, 0.22, Enum.EasingStyle.Quad)
	end

	function Window:CreateTab(TabConfig)
		if type(TabConfig) == "string" then TabConfig = { TabConfig } end
		TabConfig = TabConfig or {}
		local TabName = TabConfig[1] or TabConfig.Name or "Tab"
		local TabIcon = TabConfig[2] or TabConfig.Icon or ""
		CountTab += 1

		local Btn = New("TextButton", {
			Name = "Tab", Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Accent,
			BackgroundTransparency = 1, LayoutOrder = CountTab, Size = UDim2.new(1, 0, 0, 34), Parent = TabScroll,
		})
		Corner(Btn, 7)
		AttachRipple(Btn)
		local Bar = New("Frame", {
			BackgroundColor3 = Theme.AccentLight, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(0, 3, 0, 0), Parent = Btn,
		})
		Corner(Bar, 2)
		local Icon = MakeIcon(Btn, TabIcon, 18, Theme.SubText, "•")
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.Position = UDim2.new(0, 12, 0.5, 0)
		local Label = New("TextLabel", {
			Text = TabName, Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			BackgroundTransparency = 1, Position = UDim2.new(0, 38, 0, 0), Size = UDim2.new(1, -44, 1, 0), Parent = Btn,
		})
		Btn.MouseEnter:Connect(function()
			if Current and Current.Btn ~= Btn then Tween(Btn, { BackgroundTransparency = 0.9 }, 0.12) end
		end)
		Btn.MouseLeave:Connect(function()
			if Current and Current.Btn ~= Btn then Tween(Btn, { BackgroundTransparency = 1 }, 0.12) end
		end)

		local Page = New("ScrollingFrame", {
			Name = "Page", BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
			ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent,
			AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
			Size = UDim2.new(1, 0, 1, 0), Parent = Pages,
		})
		Pad(Page, 0, 0, 6, 8)
		New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = Page })

		local rec = { Name = TabName, Btn = Btn, Bar = Bar, Icon = Icon, Label = Label, Page = Page }
		function rec.ApplyCompact(compact)
			Label.Visible = not compact
			if compact then
				Icon.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
			else
				Icon.AnchorPoint = Vector2.new(0, 0.5)
				Icon.Position = UDim2.new(0, 12, 0.5, 0)
			end
		end
		rec.ApplyCompact(Compact)
		table.insert(TabList, rec)
		Btn.Activated:Connect(function() SelectTab(rec) end)
		if CountTab == 1 then
			Current = nil
			SelectTab(rec)
		end

		-- ============ sections ============
		local Tab = {}
		local CountSection = 0

		function Tab:AddSection(SectionTitle, OpenSection)
			CountSection += 1
			local isOpen = OpenSection and true or false

			local Section = New("Frame", {
				Name = "Section", BackgroundTransparency = 1, LayoutOrder = CountSection,
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = Page,
			})
			New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = Section })

			local Header = New("TextButton", {
				Name = "Header", Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Panel,
				BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 36), Parent = Section,
			})
			Corner(Header, 8)
			local HStroke = Stroke(Header, Theme.Stroke, 1, 0.4)
			AttachRipple(Header)
			local HBar = New("Frame", {
				BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.new(0, 3, 0, 16), Parent = Header,
			})
			Corner(HBar, 2)
			New("TextLabel", {
				Text = SectionTitle or "", Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.Text,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
				BackgroundTransparency = 1, Position = UDim2.new(0, 22, 0, 0), Size = UDim2.new(1, -52, 1, 0), Parent = Header,
			})
			local Chevron = MakeIcon(Header, "chevron-down", 16, Theme.AccentLight, "v")
			Chevron.AnchorPoint = Vector2.new(0.5, 0.5)
			Chevron.Position = UDim2.new(1, -18, 0.5, 0)
			Chevron.Rotation = isOpen and 0 or -90

			local SBody = New("Frame", {
				Name = "SectionBody", BackgroundTransparency = 1, LayoutOrder = 2, Visible = isOpen,
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = Section,
			})
			New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), Parent = SBody })

			Header.MouseEnter:Connect(function() Tween(HStroke, { Color = Theme.Accent, Transparency = 0.5 }, 0.12) end)
			Header.MouseLeave:Connect(function() Tween(HStroke, { Color = Theme.Stroke, Transparency = 0.4 }, 0.12) end)
			Header.Activated:Connect(function()
				isOpen = not isOpen
				SBody.Visible = isOpen
				Tween(Chevron, { Rotation = isOpen and 0 or -90 }, 0.18)
			end)

			local Item = {}
			local counter = 0
			local function order() counter += 1 return counter end

			-- ---------------- Paragraph / Label ----------------
			function Item:AddParagraph(C)
				if type(C) == "string" then C = { C } end
				C = C or {}
				local c = MakeCard(SBody, order(), C[1] or C.Title or "", C[2] or C.Content or "", nil)
				c.Title.Font = Enum.Font.GothamBold
				local F = {}
				function F:Set(N)
					N = N or {}
					c.Title.Text = N[1] or N.Title or c.Title.Text
					local ct = N[2] or N.Content
					if ct ~= nil then c.Content.Text = ct c.Content.Visible = ct ~= "" end
				end
				return F
			end

			function Item:AddLabel(text)
				local c = MakeCard(SBody, order(), text or "", "", nil)
				c.Title.Font = Enum.Font.Gotham
				c.Title.TextColor3 = Theme.SubText
				local F = {}
				function F:Set(t) c.Title.Text = tostring(t) end
				return F
			end

			-- ---------------- Separator / Line ----------------
			function Item:AddSeperator(C)
				if type(C) == "string" then C = { C } end
				C = C or {}
				local f = New("Frame", {
					Name = "Separator", BackgroundTransparency = 1, LayoutOrder = order(),
					Size = UDim2.new(1, 0, 0, 24), Parent = SBody,
				})
				local lbl = New("TextLabel", {
					Text = C[1] or C.Title or "", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.AccentLight,
					TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
					Position = UDim2.new(0, 4, 0, 0), Size = UDim2.new(1, -4, 1, -4), Parent = f,
				})
				local line = New("Frame", {
					BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.6, BorderSizePixel = 0,
					AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 1), Parent = f,
				})
				Gradient(line, Theme.Accent, Theme.Background, 0)
				local F = {}
				function F:Set(N) lbl.Text = (type(N) == "table" and (N[1] or N.Title)) or tostring(N) end
				return F
			end
			Item.AddSeparator = Item.AddSeperator

			function Item:AddLine()
				local line = New("Frame", {
					Name = "Line", BackgroundColor3 = Theme.Stroke, BackgroundTransparency = 0.3, BorderSizePixel = 0,
					LayoutOrder = order(), Size = UDim2.new(1, 0, 0, 1), Parent = SBody,
				})
				Gradient(line, Theme.Accent, Theme.Background, 0)
				return {}
			end

			-- ---------------- Button ----------------
			function Item:AddButton(C)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local icon = C[3] or C.Icon or "mouse-pointer-click"
				local callback = C[4] or C.Callback or function() end
				local primary = C.Primary

				local c = MakeCard(SBody, order(), title, content, UDim.new(0, 30))
				local chip = New("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.fromOffset(28, 28), BackgroundColor3 = Theme.Background, Parent = c.Body,
				})
				Corner(chip, 7)
				local ic = MakeIcon(chip, icon, 16, Theme.AccentLight, "›")
				ic.AnchorPoint = Vector2.new(0.5, 0.5)
				ic.Position = UDim2.fromScale(0.5, 0.5)

				if primary then
					c.Card.BackgroundColor3 = Color3.new(1, 1, 1)
					Gradient(c.Card, Theme.Accent, Theme.AccentDark, 0)
					chip.BackgroundColor3 = Color3.new(1, 1, 1)
					chip.BackgroundTransparency = 0.8
					SetIconColor(ic, Color3.new(1, 1, 1))
					c.Stroke.Color = Theme.AccentLight
				end

				local F = {}
				local function fire()
					Tween(chip, { BackgroundColor3 = Theme.Accent }, 0.08)
					task.delay(0.15, function()
						if chip.Parent then Tween(chip, { BackgroundColor3 = primary and Color3.new(1, 1, 1) or Theme.Background }, 0.2) end
					end)
					Safe(callback)
				end
				MakeOverlay(c, fire, not primary)
				function F:Fire() fire() end
				function F:SetTitle(t) c.Title.Text = t end
				function F:SetContent(t) c.Content.Text = t c.Content.Visible = t ~= "" end
				return F
			end

			-- ---------------- Toggle ----------------
			function Item:AddToggle(C)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local default = C[3]
				if default == nil then default = C.Default end
				local callback = C[4] or C.Callback or function() end
				local flag = C.Flag or C[5]

				local c = MakeCard(SBody, order(), title, content, UDim.new(0, 48))
				local switch = New("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.fromOffset(42, 22), BackgroundColor3 = Theme.Off, Parent = c.Body,
				})
				Corner(switch, 11)
				local sStroke = Stroke(switch, Theme.Stroke, 1, 0)
				local knob = New("Frame", {
					AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0),
					Size = UDim2.fromOffset(16, 16), BackgroundColor3 = Theme.SubText, Parent = switch,
				})
				Corner(knob, 8)

				local F = { Value = false }
				function F:Set(v, silent)
					v = v and true or false
					F.Value = v
					Tween(switch, { BackgroundColor3 = v and Theme.Accent or Theme.Off }, 0.2)
					Tween(sStroke, { Color = v and Theme.AccentLight or Theme.Stroke }, 0.2)
					Tween(knob, {
						Position = v and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
						BackgroundColor3 = v and Color3.new(1, 1, 1) or Theme.SubText,
					}, 0.2, Enum.EasingStyle.Back)
					Tween(c.Title, { TextColor3 = v and Color3.new(1, 1, 1) or Theme.Text }, 0.2)
					if flag then Library.Flags[flag] = v end
					if not silent then Safe(callback, v) end
				end
				MakeOverlay(c, function() F:Set(not F.Value) end)
				if flag then Library.FlagObjects[flag] = F end
				F:Set(default or false)
				return F
			end

			-- ---------------- Slider ----------------
			function Item:AddSlider(C)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local inc = C[3] or C.Increment or 1
				local minV = C[4] or C.Min or 0
				local maxV = C[5] or C.Max or 100
				local default = C[6] or C.Default or minV
				local callback = C[7] or C.Callback or function() end
				local flag = C.Flag
				if maxV == minV then maxV = minV + 1 end
				local dec = tostring(inc):match("%.(%d+)")
				dec = dec and #dec or 0
				local fmt = "%." .. dec .. "f"

				local c = MakeCard(SBody, order(), title, content, UDim.new(0, 66))
				local box = New("TextBox", {
					Text = "", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Text,
					ClearTextOnFocus = false, BackgroundColor3 = Theme.Background,
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.fromOffset(60, 26), Parent = c.Body,
				})
				Corner(box, 6)
				local bStroke = Stroke(box, Theme.Stroke, 1, 0.2)
				box.Focused:Connect(function() Tween(bStroke, { Color = Theme.Accent }, 0.12) end)

				local holder = New("Frame", {
					BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 24), Parent = c.Card,
				})
				Pad(holder, 12, 0, 12, 0)
				local track = New("Frame", {
					BackgroundColor3 = Theme.Off, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 0, 0.5, -3), Size = UDim2.new(1, 0, 0, 6), Parent = holder,
				})
				Corner(track, 3)
				local fill = New("Frame", {
					BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0), Parent = track,
				})
				Corner(fill, 3)
				Gradient(fill, Theme.AccentDark, Theme.AccentLight, 0)
				local knob = New("Frame", {
					BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(14, 14), ZIndex = 2, Parent = track,
				})
				Corner(knob, 7)
				Stroke(knob, Theme.Accent, 2, 0)

				local F = { Value = minV }
				local function snap(v)
					v = math.clamp(math.floor(v / inc + 0.5) * inc, minV, maxV)
					return tonumber(string.format(fmt, v)) or v
				end
				local function paint(v, instant)
					local a = (v - minV) / (maxV - minV)
					local t = instant and 0 or 0.07
					Tween(fill, { Size = UDim2.new(a, 0, 1, 0) }, t)
					Tween(knob, { Position = UDim2.new(a, 0, 0.5, 0) }, t)
					box.Text = string.format(fmt, v)
				end
				function F:Set(v, silent)
					v = snap(tonumber(v) or minV)
					F.Value = v
					paint(v)
					if flag then Library.Flags[flag] = v end
					if not silent then Safe(callback, v) end
				end

				local dragging = false
				local function fromX(x)
					local a = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
					local v = snap(minV + (maxV - minV) * a)
					if v ~= F.Value then
						F.Value = v
						paint(v)
						if flag then Library.Flags[flag] = v end
					end
				end
				holder.InputBegan:Connect(function(input)
					if IsPress(input) then
						dragging = true
						Page.ScrollingEnabled = false
						Tween(knob, { Size = UDim2.fromOffset(18, 18) }, 0.1)
						fromX(input.Position.X)
					end
				end)
				Connect(UserInputService.InputChanged, function(input)
					if dragging and IsMove(input) then fromX(input.Position.X) end
				end)
				Connect(UserInputService.InputEnded, function(input)
					if dragging and IsPress(input) then
						dragging = false
						Page.ScrollingEnabled = true
						Tween(knob, { Size = UDim2.fromOffset(14, 14) }, 0.1)
						Safe(callback, F.Value)
					end
				end)
				box.FocusLost:Connect(function()
					Tween(bStroke, { Color = Theme.Stroke }, 0.12)
					F:Set(tonumber(box.Text) or F.Value)
				end)

				if flag then Library.FlagObjects[flag] = F end
				F:Set(default)
				return F
			end

			-- ---------------- Input ----------------
			function Item:AddInput(C)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local default = C[3] or C.Default or ""
				local callback = C[4] or C.Callback or function() end
				local flag = C.Flag
				local placeholder = C.Placeholder or "Type here..."
				local numeric = C.Numeric

				local c = MakeCard(SBody, order(), title, content, UDim.new(0.42, 0))
				local frame = New("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0.42, 0, 0, 28), BackgroundColor3 = Theme.Background, Parent = c.Body,
				})
				New("UISizeConstraint", { MinSize = Vector2.new(96, 28), MaxSize = Vector2.new(200, 28), Parent = frame })
				Corner(frame, 6)
				local fStroke = Stroke(frame, Theme.Stroke, 1, 0.2)
				local tb = New("TextBox", {
					Text = "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(95, 112, 150),
					Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Text,
					TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, TextTruncate = Enum.TextTruncate.AtEnd,
					BackgroundTransparency = 1, Position = UDim2.new(0, 9, 0, 0), Size = UDim2.new(1, -18, 1, 0), Parent = frame,
				})
				tb.Focused:Connect(function() Tween(fStroke, { Color = Theme.Accent }, 0.12) end)

				local F = { Value = "" }
				function F:Set(v, silent)
					v = tostring(v == nil and "" or v)
					tb.Text = v
					F.Value = v
					if flag then Library.Flags[flag] = v end
					if not silent then Safe(callback, v) end
				end
				if numeric then
					tb:GetPropertyChangedSignal("Text"):Connect(function()
						local clean = tb.Text:gsub("[^%d%.%-]", "")
						if clean ~= tb.Text then tb.Text = clean end
					end)
				end
				tb.FocusLost:Connect(function()
					Tween(fStroke, { Color = Theme.Stroke }, 0.12)
					F:Set(tb.Text)
				end)
				if flag then Library.FlagObjects[flag] = F end
				F:Set(default, true)
				if default ~= "" then Safe(callback, F.Value) end
				return F
			end

			-- ---------------- Dropdown / Select ----------------
			local function BuildDropdown(C, Multi)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local options = C.Options or C[4] or {}
				local default = C.Default or C[5]
				local callback = C.Callback or C[6] or function() end
				local flag = C.Flag
				if type(default) == "string" then default = { default } end
				default = default or {}

				local c = MakeCard(SBody, order(), title, content, UDim.new(0.42, 0))
				local sel = New("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0.42, 0, 0, 28), BackgroundColor3 = Theme.Background, Parent = c.Body,
				})
				New("UISizeConstraint", { MinSize = Vector2.new(96, 28), MaxSize = Vector2.new(200, 28), Parent = sel })
				Corner(sel, 6)
				local sStroke = Stroke(sel, Theme.Stroke, 1, 0.2)
				local selLbl = New("TextLabel", {
					Text = "Select...", Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Text,
					TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
					BackgroundTransparency = 1, Position = UDim2.new(0, 9, 0, 0), Size = UDim2.new(1, -30, 1, 0), Parent = sel,
				})
				local chev = MakeIcon(sel, "chevron-down", 16, Theme.AccentLight, "v")
				chev.AnchorPoint = Vector2.new(1, 0.5)
				chev.Position = UDim2.new(1, -6, 0.5, 0)

				local panel = New("Frame", {
					Name = "Panel", BackgroundTransparency = 1, LayoutOrder = 2, Visible = false,
					Size = UDim2.new(1, 0, 0, 0), Parent = c.Card,
				})
				Pad(panel, 10, 0, 10, 10)
				local search = New("TextBox", {
					Text = "", PlaceholderText = "Search...", PlaceholderColor3 = Color3.fromRGB(95, 112, 150),
					Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Text, ClearTextOnFocus = false,
					TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Theme.Background,
					Size = UDim2.new(1, 0, 0, 26), Visible = false, Parent = panel,
				})
				Corner(search, 6)
				Stroke(search, Theme.Stroke, 1, 0.3)
				Pad(search, 9, 0, 9, 0)
				local list = New("ScrollingFrame", {
					BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
					ScrollBarImageColor3 = Theme.Accent, AutomaticCanvasSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2.new(), Size = UDim2.new(1, 0, 0, 100), Parent = panel,
				})
				New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3), Parent = list })

				local F = { Value = {}, Options = {}, Multi = Multi }
				local selected, opts = {}, {}

				local function open(state)
					panel.Visible = state
					Tween(chev, { Rotation = state and 180 or 0 }, 0.18)
					Tween(sStroke, { Color = state and Theme.Accent or Theme.Stroke }, 0.15)
				end
				MakeOverlay(c, function() open(not panel.Visible) end)

				local function resize()
					local n = #F.Options
					local sh = n > 6 and 32 or 0
					local lh = math.clamp(n * 31, 31, 155)
					search.Visible = n > 6
					list.Position = UDim2.new(0, 0, 0, sh)
					list.Size = UDim2.new(1, 0, 0, lh)
					panel.Size = UDim2.new(1, 0, 0, sh + lh + 10)
				end

				local function paint()
					for name, o in pairs(opts) do
						local on = selected[name] and true or false
						Tween(o.Btn, { BackgroundColor3 = on and Theme.Accent or Theme.Background, BackgroundTransparency = on and 0.7 or 0 }, 0.12)
						Tween(o.Label, { TextColor3 = on and Theme.Text or Theme.SubText }, 0.12)
						o.Check.Visible = on
					end
					selLbl.Text = #F.Value > 0 and table.concat(F.Value, ", ") or "Select..."
				end

				local function commit(silent)
					local v = {}
					for _, n in ipairs(F.Options) do
						if selected[n] then v[#v + 1] = n end
					end
					F.Value = v
					paint()
					local out = Multi and v or v[1]
					if flag then Library.Flags[flag] = out end
					if not silent then Safe(callback, out) end
				end

				function F:Set(value, silent)
					selected = {}
					if type(value) == "string" then value = { value } end
					for _, n in ipairs(value or {}) do
						selected[n] = true
						if not Multi then break end
					end
					commit(silent)
				end

				function F:AddOption(name)
					name = tostring(name)
					table.insert(F.Options, name)
					local btn = New("TextButton", {
						Name = "Option", Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Background,
						LayoutOrder = #F.Options, Size = UDim2.new(1, -2, 0, 28), Parent = list,
					})
					Corner(btn, 6)
					AttachRipple(btn)
					local lbl = New("TextLabel", {
						Text = name, Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.SubText,
						TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
						BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(1, -34, 1, 0), Parent = btn,
					})
					local check = MakeIcon(btn, "check", 14, Theme.AccentLight, "✓")
					check.AnchorPoint = Vector2.new(1, 0.5)
					check.Position = UDim2.new(1, -8, 0.5, 0)
					check.Visible = false
					opts[name] = { Btn = btn, Label = lbl, Check = check }
					btn.Activated:Connect(function()
						if Multi then
							selected[name] = (not selected[name]) or nil
						else
							selected = { [name] = true }
							open(false)
						end
						commit()
					end)
				end

				function F:Clear()
					for _, o in pairs(opts) do o.Btn:Destroy() end
					opts, selected = {}, {}
					F.Options, F.Value = {}, {}
					resize()
					paint()
				end

				function F:Refresh(newList, selecting, silent)
					F:Clear()
					for _, n in ipairs(newList or {}) do F:AddOption(n) end
					resize()
					F:Set(selecting or {}, silent)
				end

				search:GetPropertyChangedSignal("Text"):Connect(function()
					local q = string.lower(search.Text)
					for name, o in pairs(opts) do
						o.Btn.Visible = q == "" or string.find(string.lower(name), q, 1, true) ~= nil
					end
				end)

				if flag then Library.FlagObjects[flag] = F end
				F:Refresh(options, default, true)
				if #F.Value > 0 or Multi then Safe(callback, Multi and F.Value or F.Value[1]) end
				return F
			end

			function Item:AddDropdown(C)
				C = C or {}
				local multi = C[3]
				if multi == nil then multi = C.Multi end
				return BuildDropdown(C, multi and true or false)
			end

			function Item:AddSelect(C)
				return BuildDropdown(C, false)
			end

			-- ---------------- Keybind ----------------
			function Item:AddKeybind(C)
				C = C or {}
				local title = C[1] or C.Title or ""
				local content = C[2] or C.Content or ""
				local default = C[3] or C.Default
				local callback = C[4] or C.Callback or function() end
				local flag = C.Flag
				if type(default) == "string" then
					local ok, kc = pcall(function() return Enum.KeyCode[default] end)
					default = ok and kc or nil
				end

				local c = MakeCard(SBody, order(), title, content, UDim.new(0, 84))
				local chip = New("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.fromOffset(78, 26), BackgroundColor3 = Theme.Background, Parent = c.Body,
				})
				Corner(chip, 6)
				local cStroke = Stroke(chip, Theme.Stroke, 1, 0.2)
				local lbl = New("TextLabel", {
					Text = "None", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.AccentLight,
					BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = chip,
				})

				local F = { Value = default }
				local listening = false
				function F:Set(key, silent)
					F.Value = key
					lbl.Text = key and key.Name or "None"
					if flag then Library.Flags[flag] = key and key.Name or nil end
				end
				MakeOverlay(c, function()
					listening = true
					lbl.Text = "..."
					Tween(cStroke, { Color = Theme.Accent }, 0.12)
				end)
				Connect(UserInputService.InputBegan, function(input, gp)
					if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
					if listening then
						listening = false
						Tween(cStroke, { Color = Theme.Stroke }, 0.12)
						if input.KeyCode == Enum.KeyCode.Escape then
							F:Set(F.Value)
						elseif input.KeyCode == Enum.KeyCode.Backspace then
							F:Set(nil)
						else
							F:Set(input.KeyCode)
						end
					elseif not gp and F.Value and input.KeyCode == F.Value then
						Safe(callback, F.Value)
					end
				end)
				if flag then Library.FlagObjects[flag] = {
					Set = function(_, v)
						local ok, kc = pcall(function() return Enum.KeyCode[v] end)
						F:Set(ok and kc or nil)
					end,
				} end
				F:Set(default)
				return F
			end

			-- ---------------- Save / Load config ----------------
			function Item:AddSaveConfig(SC)
				SC = SC or {}
				local folder = SC.Folder or "KaizenHub"
				local nameValue = SC.Default or "default"
				local hasFS = writefile and readfile and isfile and isfolder and makefolder and listfiles
				local F = {}
				local function path(n) return folder .. "/" .. n .. ".kfg" end
				local function listConfigs()
					local out = {}
					if not hasFS or not isfolder(folder) then return out end
					for _, f in ipairs(listfiles(folder)) do
						local n = f:match("([^/\\]+)%.kfg$")
						if n then out[#out + 1] = n end
					end
					return out
				end

				Item:AddSeperator({ SC.Title or "Configuration" })
				local nameInput = Item:AddInput({ "Config name", "Name used when saving", nameValue, function(v) nameValue = v end })
				local dd = Item:AddSelect({
					Title = "Saved configs", Content = "Pick one to load or overwrite", Options = listConfigs(),
					Callback = function(v)
						if v and v ~= nameValue then
							nameValue = v
							nameInput:Set(v, true)
						end
					end,
				})

				function F:Refresh() dd:Refresh(listConfigs(), nil, true) end
				function F:Save(name)
					name = name or nameValue
					if not hasFS then return false, "filesystem unavailable" end
					if not name or name == "" then return false, "name is empty" end
					if not isfolder(folder) then makefolder(folder) end
					local ok, enc = pcall(function() return HttpService:JSONEncode(Library.Flags) end)
					if not ok then return false, tostring(enc) end
					writefile(path(name), enc)
					F:Refresh()
					return true
				end
				function F:Load(name)
					name = name or nameValue
					if not hasFS then return false, "filesystem unavailable" end
					if not isfile(path(name)) then return false, "config not found" end
					local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path(name))) end)
					if not ok then return false, tostring(data) end
					for k, v in pairs(data) do
						local obj = Library.FlagObjects[k]
						if obj and obj.Set then obj:Set(v) else Library.Flags[k] = v end
					end
					return true
				end
				function F:Delete(name)
					name = name or nameValue
					if hasFS and delfile and isfile(path(name)) then delfile(path(name)) F:Refresh() return true end
					return false, "cannot delete"
				end

				local function report(ok, err, okMsg)
					Library:SetNotification({
						Title = "Config", Description = ok and "Success" or "Failed",
						Content = ok and okMsg or tostring(err), Type = ok and "success" or "error", Delay = 3,
					})
				end
				Item:AddButton({ Title = "Save config", Content = "Write all flagged options to a file", Icon = "save", Primary = true,
					Callback = function() local ok, e = F:Save() report(ok, e, "Saved '" .. tostring(nameValue) .. "'") end })
				Item:AddButton({ Title = "Load config", Content = "Apply the selected config", Icon = "download",
					Callback = function() local ok, e = F:Load() report(ok, e, "Loaded '" .. tostring(nameValue) .. "'") end })
				Item:AddButton({ Title = "Delete config", Content = "Remove the selected config file", Icon = "trash-2",
					Callback = function() local ok, e = F:Delete() report(ok, e, "Deleted '" .. tostring(nameValue) .. "'") end })
				return F
			end

			return Item
		end

		return Tab
	end

	function Window:SetTitle(t) TitleLbl.Text = t end
	function Window:Toggle(v) if v == nil then v = not Visible end SetVisible(v) end
	function Window:Destroy() Library:Destroy() end
	function Window:Notify(c) return Library:SetNotification(c) end

	Relayout()
	return Window
end

return Library
