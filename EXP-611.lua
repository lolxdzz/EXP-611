-- EXP 611 Script
-- Feito por: 4qz
-- Discord: exp611

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Configurações
local Config = {
    Anti = false,
    AntiAFK = false,
    AntiEspiao = false,
    Dia = false,
    Noite = false,
    Shaders = false,
    InfiniteYield = false,
    CMDX = false,
    ESP = false,
    Explodir = false,
    Reentrar = false
}

local TargetPlayer = nil

-- Função para criar GUI
local function CreateGUI()
    -- ScreenGui principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EXP611"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    -- Frame principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 1000, 0, 600)
    MainFrame.Position = UDim2.new(0.5, -500, 0.5, -300)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    -- Logo Nike
    local Logo = Instance.new("TextLabel")
    Logo.Name = "Logo"
    Logo.Size = UDim2.new(0, 40, 1, 0)
    Logo.Position = UDim2.new(0, 10, 0, 0)
    Logo.BackgroundTransparency = 1
    Logo.Text = "✓"
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.TextSize = 24
    Logo.Font = Enum.Font.GothamBold
    Logo.Parent = TopBar

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 50, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "EXP 611"
    Title.TextColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextSize = 18
    Title.Font = Enum.Font.Gotham
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = TopBar

    -- Botão Fechar
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "⚡"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.Parent = TopBar

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 60, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -60, 1, -40)
    ContentArea.Position = UDim2.new(0, 60, 0, 40)
    ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ContentArea.BorderSizePixel = 0
    ContentArea.Parent = MainFrame

    -- Ícones da Sidebar
    local Icons = {
        {icon = "🏠", name = "Home"},
        {icon = "🔧", name = "Tools"},
        {icon = "👤", name = "User"},
        {icon = "🎯", name = "Target"},
        {icon = "💃", name = "Emotes"},
        {icon = "⭐", name = "Favorites"},
        {icon = "🖥️", name = "Server"},
        {icon = "⚙️", name = "Settings"},
        {icon = "🏆", name = "About"}
    }

    local CurrentPage = "Home"
    local IconButtons = {}

    for i, iconData in ipairs(Icons) do
        local IconButton = Instance.new("TextButton")
        IconButton.Name = iconData.name .. "Button"
        IconButton.Size = UDim2.new(1, -10, 0, 50)
        IconButton.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 55)
        IconButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        IconButton.BorderSizePixel = 0
        IconButton.Text = iconData.icon
        IconButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        IconButton.TextSize = 24
        IconButton.Font = Enum.Font.Gotham
        IconButton.Parent = Sidebar

        IconButton.MouseButton1Click:Connect(function()
            CurrentPage = iconData.name
            UpdateContent()
        end)

        IconButton.MouseEnter:Connect(function()
            IconButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        IconButton.MouseLeave:Connect(function()
            if CurrentPage ~= iconData.name then
                IconButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            end
        end)

        table.insert(IconButtons, IconButton)
    end

    -- Função para atualizar conteúdo
    function UpdateContent()
        -- Limpar conteúdo anterior
        for _, child in ipairs(ContentArea:GetChildren()) do
            if child:IsA("GuiObject") then
                child:Destroy()
            end
        end

        -- Atualizar botões da sidebar
        for i, button in ipairs(IconButtons) do
            if Icons[i].name == CurrentPage then
                button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            else
                button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            end
        end

        if CurrentPage == "Home" then
            CreateHomePage(ContentArea)
        elseif CurrentPage == "Settings" then
            CreateSettingsPage(ContentArea)
        elseif CurrentPage == "User" then
            CreateUserPage(ContentArea)
        elseif CurrentPage == "About" then
            CreateAboutPage(ContentArea)
        end
    end

    -- Página Home
    function CreateHomePage(parent)
        local PuppyImage = Instance.new("ImageLabel")
        PuppyImage.Name = "PuppyImage"
        PuppyImage.Size = UDim2.new(0, 200, 0, 200)
        PuppyImage.Position = UDim2.new(0, 50, 0, 50)
        PuppyImage.BackgroundTransparency = 1
        PuppyImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        PuppyImage.Parent = parent

        local Greeting = Instance.new("TextLabel")
        Greeting.Name = "Greeting"
        Greeting.Size = UDim2.new(0, 300, 0, 50)
        Greeting.Position = UDim2.new(0, 280, 0, 50)
        Greeting.BackgroundTransparency = 1
        Greeting.Text = "Olá @" .. LocalPlayer.Name .. "!"
        Greeting.TextColor3 = Color3.fromRGB(255, 255, 255)
        Greeting.TextSize = 32
        Greeting.Font = Enum.Font.GothamBold
        Greeting.TextXAlignment = Enum.TextXAlignment.Left
        Greeting.Parent = parent

        local Instruction = Instance.new("TextLabel")
        Instruction.Name = "Instruction"
        Instruction.Size = UDim2.new(0, 300, 0, 30)
        Instruction.Position = UDim2.new(0, 280, 0, 110)
        Instruction.BackgroundTransparency = 1
        Instruction.Text = "Pressione [B]"
        Instruction.TextColor3 = Color3.fromRGB(200, 200, 200)
        Instruction.TextSize = 20
        Instruction.Font = Enum.Font.Gotham
        Instruction.TextXAlignment = Enum.TextXAlignment.Left
        Instruction.Parent = parent

        local Footer = Instance.new("Frame")
        Footer.Name = "Footer"
        Footer.Size = UDim2.new(0, 400, 0, 60)
        Footer.Position = UDim2.new(1, -450, 1, -80)
        Footer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Footer.BorderSizePixel = 0
        Footer.Parent = parent

        local FooterText1 = Instance.new("TextLabel")
        FooterText1.Size = UDim2.new(1, -20, 0, 20)
        FooterText1.Position = UDim2.new(0, 10, 0, 5)
        FooterText1.BackgroundTransparency = 1
        FooterText1.Text = "Este código foi feito pelo jn"
        FooterText1.TextColor3 = Color3.fromRGB(255, 255, 255)
        FooterText1.TextSize = 14
        FooterText1.Font = Enum.Font.Gotham
        FooterText1.TextXAlignment = Enum.TextXAlignment.Left
        FooterText1.Parent = Footer

        local FooterText2 = Instance.new("TextLabel")
        FooterText2.Size = UDim2.new(1, -20, 0, 20)
        FooterText2.Position = UDim2.new(0, 10, 0, 30)
        FooterText2.BackgroundTransparency = 1
        FooterText2.Text = "atualizado 20/12/25."
        FooterText2.TextColor3 = Color3.fromRGB(200, 200, 200)
        FooterText2.TextSize = 12
        FooterText2.Font = Enum.Font.Gotham
        FooterText2.TextXAlignment = Enum.TextXAlignment.Left
        FooterText2.Parent = Footer
    end

    -- Página Settings
    function CreateSettingsPage(parent)
        local SettingsGrid = Instance.new("Frame")
        SettingsGrid.Name = "SettingsGrid"
        SettingsGrid.Size = UDim2.new(0, 800, 0, 400)
        SettingsGrid.Position = UDim2.new(0.5, -400, 0.5, -200)
        SettingsGrid.BackgroundTransparency = 1
        SettingsGrid.Parent = parent

        local SettingsList = {
            {"Anti", "Anti"},
            {"Anti AFK", "AntiAFK"},
            {"Anti Espião", "AntiEspiao"},
            {"Dia", "Dia"},
            {"Noite", "Noite"},
            {"Shaders", "Shaders"},
            {"Infinite Yield", "InfiniteYield"},
            {"CMDX", "CMDX"},
            {"ESP", "ESP"},
            {"Explodir", "Explodir"},
            {"Reentrar", "Reentrar"}
        }

        local columns = 2
        local buttonWidth = 350
        local buttonHeight = 40
        local spacing = 20

        for i, setting in ipairs(SettingsList) do
            local col = ((i - 1) % columns) + 1
            local row = math.floor((i - 1) / columns) + 1

            local SettingButton = Instance.new("TextButton")
            SettingButton.Name = setting[2] .. "Button"
            SettingButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
            SettingButton.Position = UDim2.new(0, (col - 1) * (buttonWidth + spacing) + 50, 0, (row - 1) * (buttonHeight + spacing) + 50)
            SettingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SettingButton.BorderSizePixel = 0
            SettingButton.Text = setting[1]
            SettingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            SettingButton.TextSize = 16
            SettingButton.Font = Enum.Font.Gotham
            SettingButton.TextXAlignment = Enum.TextXAlignment.Left
            SettingButton.Parent = SettingsGrid

            local GearIcon = Instance.new("TextLabel")
            GearIcon.Size = UDim2.new(0, 30, 1, 0)
            GearIcon.Position = UDim2.new(1, -30, 0, 0)
            GearIcon.BackgroundTransparency = 1
            GearIcon.Text = "⚙️"
            GearIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
            GearIcon.TextSize = 18
            GearIcon.Font = Enum.Font.Gotham
            GearIcon.Parent = SettingButton

            local Toggle = Instance.new("TextLabel")
            Toggle.Name = "Toggle"
            Toggle.Size = UDim2.new(0, 60, 1, 0)
            Toggle.Position = UDim2.new(1, -90, 0, 0)
            Toggle.BackgroundColor3 = Config[setting[2]] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
            Toggle.BorderSizePixel = 0
            Toggle.Text = Config[setting[2]] and "ON" or "OFF"
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 12
            Toggle.Font = Enum.Font.GothamBold
            Toggle.Parent = SettingButton

            SettingButton.MouseButton1Click:Connect(function()
                Config[setting[2]] = not Config[setting[2]]
                Toggle.BackgroundColor3 = Config[setting[2]] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
                Toggle.Text = Config[setting[2]] and "ON" or "OFF"
                HandleSetting(setting[2], Config[setting[2]])
            end)

            SettingButton.MouseEnter:Connect(function()
                SettingButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end)

            SettingButton.MouseLeave:Connect(function()
                SettingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
        end
    end

    -- Página User
    function CreateUserPage(parent)
        -- Avatar Frame
        local AvatarFrame = Instance.new("Frame")
        AvatarFrame.Name = "AvatarFrame"
        AvatarFrame.Size = UDim2.new(0, 200, 0, 250)
        AvatarFrame.Position = UDim2.new(0, 50, 0, 50)
        AvatarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        AvatarFrame.BorderSizePixel = 0
        AvatarFrame.Parent = parent

        -- Input de Alvo
        local TargetInput = Instance.new("TextBox")
        TargetInput.Name = "TargetInput"
        TargetInput.Size = UDim2.new(0, 300, 0, 40)
        TargetInput.Position = UDim2.new(0, 280, 0, 50)
        TargetInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TargetInput.BorderSizePixel = 0
        TargetInput.Text = "alvo"
        TargetInput.PlaceholderText = "Digite o nome do alvo"
        TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        TargetInput.TextSize = 16
        TargetInput.Font = Enum.Font.Gotham
        TargetInput.Parent = parent

        TargetInput.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local targetName = TargetInput.Text
                for _, player in ipairs(Players:GetPlayers()) do
                    if string.find(string.lower(player.Name), string.lower(targetName)) then
                        TargetPlayer = player
                        UpdateUserInfo()
                        break
                    end
                end
            end
        end)

        -- Info Frame
        local InfoFrame = Instance.new("Frame")
        InfoFrame.Name = "InfoFrame"
        InfoFrame.Size = UDim2.new(0, 300, 0, 100)
        InfoFrame.Position = UDim2.new(0, 280, 0, 100)
        InfoFrame.BackgroundTransparency = 1
        InfoFrame.Parent = parent

        local UserIDLabel = Instance.new("TextLabel")
        UserIDLabel.Name = "UserIDLabel"
        UserIDLabel.Size = UDim2.new(1, 0, 0, 25)
        UserIDLabel.Position = UDim2.new(0, 0, 0, 0)
        UserIDLabel.BackgroundTransparency = 1
        UserIDLabel.Text = "UserID: "
        UserIDLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        UserIDLabel.TextSize = 14
        UserIDLabel.Font = Enum.Font.Gotham
        UserIDLabel.TextXAlignment = Enum.TextXAlignment.Left
        UserIDLabel.Parent = InfoFrame

        local DisplayLabel = Instance.new("TextLabel")
        DisplayLabel.Name = "DisplayLabel"
        DisplayLabel.Size = UDim2.new(1, 0, 0, 25)
        DisplayLabel.Position = UDim2.new(0, 0, 0, 30)
        DisplayLabel.BackgroundTransparency = 1
        DisplayLabel.Text = "Display: "
        DisplayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        DisplayLabel.TextSize = 14
        DisplayLabel.Font = Enum.Font.Gotham
        DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left
        DisplayLabel.Parent = InfoFrame

        local JoinedLabel = Instance.new("TextLabel")
        JoinedLabel.Name = "JoinedLabel"
        JoinedLabel.Size = UDim2.new(1, 0, 0, 25)
        JoinedLabel.Position = UDim2.new(0, 0, 0, 60)
        JoinedLabel.BackgroundTransparency = 1
        JoinedLabel.Text = "Joined: "
        JoinedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        JoinedLabel.TextSize = 14
        JoinedLabel.Font = Enum.Font.Gotham
        JoinedLabel.TextXAlignment = Enum.TextXAlignment.Left
        JoinedLabel.Parent = InfoFrame

        function UpdateUserInfo()
            if TargetPlayer then
                UserIDLabel.Text = "UserID: " .. tostring(TargetPlayer.UserId)
                DisplayLabel.Text = "Display: " .. TargetPlayer.DisplayName
                -- Joined info não está disponível diretamente
                JoinedLabel.Text = "Joined: N/A"
            end
        end

        -- Actions Grid
        local ActionsGrid = Instance.new("Frame")
        ActionsGrid.Name = "ActionsGrid"
        ActionsGrid.Size = UDim2.new(0, 900, 0, 300)
        ActionsGrid.Position = UDim2.new(0, 50, 0, 250)
        ActionsGrid.BackgroundTransparency = 1
        ActionsGrid.Parent = parent

        local ActionsList = {
            "Visualiza", "Bang", "Cachorrinho", "Girar", "Trazer", "Empurra",
            "Arremessar", "Sentar na Cabeça", "Mochila", "Teleportar", "Chutar",
            "Focar", "Ficar em Pé", "Arrastar", "Orbitar", "Seguir"
        }

        local actionColumns = 3
        local actionButtonWidth = 280
        local actionButtonHeight = 40
        local actionSpacing = 15

        for i, action in ipairs(ActionsList) do
            local col = ((i - 1) % actionColumns) + 1
            local row = math.floor((i - 1) / actionColumns) + 1

            local ActionButton = Instance.new("TextButton")
            ActionButton.Name = action .. "Button"
            ActionButton.Size = UDim2.new(0, actionButtonWidth, 0, actionButtonHeight)
            ActionButton.Position = UDim2.new(0, (col - 1) * (actionButtonWidth + actionSpacing), 0, (row - 1) * (actionButtonHeight + actionSpacing))
            ActionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ActionButton.BorderSizePixel = 0
            ActionButton.Text = action
            ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ActionButton.TextSize = 16
            ActionButton.Font = Enum.Font.Gotham
            ActionButton.TextXAlignment = Enum.TextXAlignment.Left
            ActionButton.Parent = ActionsGrid

            local GearIcon = Instance.new("TextLabel")
            GearIcon.Size = UDim2.new(0, 30, 1, 0)
            GearIcon.Position = UDim2.new(1, -30, 0, 0)
            GearIcon.BackgroundTransparency = 1
            GearIcon.Text = "⚙️"
            GearIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
            GearIcon.TextSize = 18
            GearIcon.Font = Enum.Font.Gotham
            GearIcon.Parent = ActionButton

            ActionButton.MouseButton1Click:Connect(function()
                HandleAction(action)
            end)

            ActionButton.MouseEnter:Connect(function()
                ActionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end)

            ActionButton.MouseLeave:Connect(function()
                ActionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
        end
    end

    -- Página About
    function CreateAboutPage(parent)
        local AboutFrame = Instance.new("Frame")
        AboutFrame.Name = "AboutFrame"
        AboutFrame.Size = UDim2.new(0, 400, 0, 150)
        AboutFrame.Position = UDim2.new(0, 50, 0, 50)
        AboutFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        AboutFrame.BorderSizePixel = 0
        AboutFrame.Parent = parent

        local MadeBy = Instance.new("TextLabel")
        MadeBy.Size = UDim2.new(1, -20, 0, 30)
        MadeBy.Position = UDim2.new(0, 10, 0, 10)
        MadeBy.BackgroundTransparency = 1
        MadeBy.Text = "🧑‍💻 Feito por: 024Jn"
        MadeBy.TextColor3 = Color3.fromRGB(0, 255, 255)
        MadeBy.TextSize = 18
        MadeBy.Font = Enum.Font.Gotham
        MadeBy.TextXAlignment = Enum.TextXAlignment.Left
        MadeBy.Parent = AboutFrame

        local Discord = Instance.new("TextLabel")
        Discord.Size = UDim2.new(1, -20, 0, 30)
        Discord.Position = UDim2.new(0, 10, 0, 50)
        Discord.BackgroundTransparency = 1
        Discord.Text = "💬 Discord: exp611"
        Discord.TextColor3 = Color3.fromRGB(0, 255, 255)
        Discord.TextSize = 18
        Discord.Font = Enum.Font.Gotham
        Discord.TextXAlignment = Enum.TextXAlignment.Left
        Discord.Parent = AboutFrame

        local Version = Instance.new("TextLabel")
        Version.Size = UDim2.new(1, -20, 0, 30)
        Version.Position = UDim2.new(0, 10, 0, 90)
        Version.BackgroundTransparency = 1
        Version.Text = "📌 Versão: 2"
        Version.TextColor3 = Color3.fromRGB(0, 255, 255)
        Version.TextSize = 18
        Version.Font = Enum.Font.Gotham
        Version.TextXAlignment = Enum.TextXAlignment.Left
        Version.Parent = AboutFrame
    end

    -- Função para lidar com configurações
    function HandleSetting(setting, enabled)
        if setting == "AntiAFK" and enabled then
            -- Anti AFK
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        elseif setting == "Dia" and enabled then
            -- Dia
            game.Lighting.TimeOfDay = "12:00:00"
        elseif setting == "Noite" and enabled then
            -- Noite
            game.Lighting.TimeOfDay = "00:00:00"
        elseif setting == "Shaders" and enabled then
            -- Desabilitar shaders
            for _, descendant in ipairs(game:GetDescendants()) do
                if descendant:IsA("PostEffect") then
                    descendant.Enabled = false
                end
            end
        elseif setting == "InfiniteYield" and enabled then
            -- Carregar Infinite Yield
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        elseif setting == "CMDX" and enabled then
            -- Carregar CMD-X
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
        elseif setting == "ESP" and enabled then
            -- ESP básico
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    CreateESP(player.Character)
                end
            end
        elseif setting == "Explodir" and enabled then
            -- Explodir
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart:Destroy()
            end
        elseif setting == "Reentrar" and enabled then
            -- Reentrar no jogo
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end

    -- Função para lidar com ações
    function HandleAction(action)
        if not TargetPlayer or not TargetPlayer.Character then
            warn("Nenhum alvo selecionado!")
            return
        end

        local targetChar = TargetPlayer.Character
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        local localChar = LocalPlayer.Character
        local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")

        if not targetHRP then return end

        if action == "Visualiza" then
            -- Visualizar
            if localHRP then
                local camera = workspace.CurrentCamera
                camera.CameraSubject = targetChar:FindFirstChild("Humanoid")
            end
        elseif action == "Bang" then
            -- Bang
            if localHRP then
                localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
            end
        elseif action == "Cachorrinho" then
            -- Cachorrinho (animação)
            -- Implementar animação de cachorro
        elseif action == "Girar" then
            -- Girar
            if targetHRP then
                local spin = RunService.Heartbeat:Connect(function()
                    targetHRP.CFrame = targetHRP.CFrame * CFrame.Angles(0, math.rad(10), 0)
                end)
                wait(3)
                spin:Disconnect()
            end
        elseif action == "Trazer" then
            -- Trazer
            if localHRP and targetHRP then
                targetHRP.CFrame = localHRP.CFrame * CFrame.new(0, 0, 5)
            end
        elseif action == "Empurra" then
            -- Empurrar
            if localHRP and targetHRP then
                targetHRP.CFrame = localHRP.CFrame * CFrame.new(0, 0, -10)
            end
        elseif action == "Arremessar" then
            -- Arremessar
            if targetHRP then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                bodyVelocity.Parent = targetHRP
                wait(0.5)
                bodyVelocity:Destroy()
            end
        elseif action == "Sentar na Cabeça" then
            -- Sentar na cabeça
            if localHRP and targetHRP then
                localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 3, 0)
            end
        elseif action == "Mochila" then
            -- Mochila (abrir inventário)
            -- Implementar abertura de inventário
        elseif action == "Teleportar" then
            -- Teleportar
            if localHRP and targetHRP then
                localHRP.CFrame = targetHRP.CFrame
            end
        elseif action == "Chutar" then
            -- Chutar
            if targetHRP then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, -50, 0)
                bodyVelocity.Parent = targetHRP
                wait(0.3)
                bodyVelocity:Destroy()
            end
        elseif action == "Focar" then
            -- Focar
            if localHRP and targetHRP then
                local camera = workspace.CurrentCamera
                camera.CFrame = CFrame.new(localHRP.Position, targetHRP.Position)
            end
        elseif action == "Ficar em Pé" then
            -- Ficar em pé
            local humanoid = targetChar:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        elseif action == "Arrastar" then
            -- Arrastar
            if localHRP and targetHRP then
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    targetHRP.CFrame = localHRP.CFrame * CFrame.new(0, 0, 3)
                end)
                -- Desconectar após 5 segundos
                wait(5)
                connection:Disconnect()
            end
        elseif action == "Orbitar" then
            -- Orbitar
            if localHRP and targetHRP then
                local angle = 0
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    angle = angle + 0.1
                    local offset = Vector3.new(math.cos(angle) * 5, 0, math.sin(angle) * 5)
                    localHRP.CFrame = targetHRP.CFrame * CFrame.new(offset)
                end)
                wait(5)
                connection:Disconnect()
            end
        elseif action == "Seguir" then
            -- Seguir
            if localHRP and targetHRP then
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 5)
                end)
                wait(10)
                connection:Disconnect()
            end
        end
    end

    -- Função para criar ESP
    function CreateESP(character)
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = part
            end
        end
    end

    -- Atalho de teclado [B]
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.B then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Inicializar
    UpdateContent()
end

-- Iniciar GUI
CreateGUI()

print("EXP 611 carregado com sucesso!")
print("Pressione [B] para abrir/fechar o menu")

