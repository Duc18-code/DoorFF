local CloudHub_Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Cloud-Hub/main/Library/V1"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Cloud-Hub/main/Settings.lua"))()

local Window = CloudHub_Lib:MakeWindow({
  Title = "FREE FIRE | HUB (BETA)",
  SubTitle = "Made by Duc Designer",
  LoadText = "Cloud Hub",
  Flags = "Cloud Hub | Doors.lua"
})

Window:AddMinimizeButton({ 
  Button = {Image = "rbxassetid://127393374937080"},
  UICorner = {true, CornerRadius = UDim.new(0.5, 0)},
  UIStroke = {false,{}}
})

local CloudHub_env = {}

local Home = Window:MakeTab({Name = "Home", Icon = "scan-face"}) do
  Home:AddDiscordInvite({
    DiscordTitle = "FREE FIRE HUB | Community",
    DiscordIcon = "rbxassetid://127393374937080",
    DiscordLink = Discord ( Không hoạt động )
  })
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer

local _isfile = isfile or function(f)return f end
local _isfolder = isfolder or function(f)return f end
local _delfolder = delfolder or function(f)return f end
local _delfile = delfile or function(f)return f end

local Funcs = {} do
  function Funcs:Toggle(Tab, Name, Default)
    return Tab:AddToggle({
      Name = Name,
      Default = Default,
      Callback = function(Value)
        CloudHub_env[Name] = Value
      end, Flag = "CloudHub/Toggle" .. (type(Name) == "string" and Name or tostring(Name))
    })
  end

  function Funcs:Button(Tab, Name, Funcs)
    return Tab:AddButton({
      Name = Name,
      Callback = Funcs
    })
  end

  function Funcs:Slider(Tab, Name, MinValue, MaxValue, Default, Increase)
    return Tab:AddSlider({
      Name = Name,
      MinValue = MinValue, 
      MaxValue = MaxValue,
      Default = Default,
      Increase = Increase,
      Callback = function(Value)
        CloudHub_env[Name] = Value
      end, Flag = "CloudHub/Slider" .. (type(Name) == "string" and Name or tostring(Name))
    })
  end

  function Funcs:Dropdown(Tab, Name, Options, Default, MultSelect)
    return Tab:AddDropdown({
      Name = Name,
      Options = Options,
      Default = Default,
      MultSelect = MultSelect,
      Callback = function(Value)
        CloudHub_env[Name] = Value
      end, Flag = "CloudHub/Dropdown" .. (type(Name) == "string" and Name or tostring(Name))
    })
  end
end

local _main = Window:MakeTab({Name = "Main", Icon = "Home"}) do
  _main:AddSection({"LocalPlayer"})
  Funcs:Slider(_main, "Set Walk Speed", 0, 500, 300, 1)
  Funcs:Toggle(_main, "Enable Walk Speed", false)
  Funcs:Button(_main, "Destroy JumpScare", function()
    local JS = ReplicatedStorage:WaitForChild("Bricks"):WaitForChild("Jumpscare")
    if JS then
      JS:Destroy()
    end
  end)
  Funcs:Button(_main, "Full Brightness", function()
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    Lighting.LightingChanged:Connect(function()
      Lighting.Ambient = Color3.new(1, 1, 1)
      Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
      Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    end)
  end)
  _main:AddSection({"Farming Doors Level"})
  Funcs:Toggle(_main, "Auto Skip Doors Level", false)
  Funcs:Toggle(_main, "Auto Play To Skip Doors Level", false)
  Funcs:Toggle(_main, "Auto Open Doors", false)
  _main:AddSection({"Doors Config"})
  Funcs:Toggle(_main, "Get Faster Interact", false)
  Funcs:Button(_main, "Destroy Doors / Fake Doors", function()
    for _, part in next, game:GetDescendants() do
      if part.Name == "Door" then
        part:Destroy()
      elseif part.Name == "Cửa Giả" then
        part:Destroy()
      end
    end
  end)
  _main:AddSection({"Collecter"})
  Funcs:Toggle(_main, "Auto Collect Key", false)
  _main:AddSection({"Other"})
  Funcs:Toggle(_main, "Anti-Screech", true)
  Funcs:Toggle(_main, "Auto Get Win Heartbeat", true)
  Funcs:Toggle(_main, "Auto Dodge Monster", true)
  Funcs:Toggle(_main, "Sending Notification if Monster Is Spawned", true)
end

local _esp = Window:MakeTab({Name = "ESP", Icon = "mountain-snow"}) do
  Funcs:Toggle(_esp, "ESP Doors", false)
  Funcs:Toggle(_esp, "ESP Lever", false)
  Funcs:Toggle(_esp, "ESP Key", false)
  Funcs:Toggle(_esp, "ESP Fuse", false)
  Funcs:Toggle(_esp, "ESP Chest", false)
  Funcs:Toggle(_esp, "ESP Locker", false)
end

local _settings = Window:MakeTab({Name = "Settings", Icon = "settings"}) do
  Funcs:Button(_main, "Reset Script Setting", function()
    if _isfile("Cloud Hub | Doors.lua") then
      _delfile("Cloud Hub | Doors.lua")
    end
  end)
  Funcs:Button(_main, "Rejoin", function()
    TeleportService:Teleport(game.PlaceId, Player)
  end)
end

return CloudHub_env