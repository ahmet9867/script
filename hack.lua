-- StarterPlayerScripts içine eklenmelidir (LocalScript)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local speedChangeAmount = 5 -- Her tıklamada hızı ne kadar değiştireceği
local minSpeed = 16 -- Minimum hız (Varsayılan)
local maxSpeed = 100 -- Maksimum hız sınırı (Güvenlik için)

-- Hızı Artır/Düşür butonları için kullanılacak boyutlar
local buttonSize = UDim2.new(0.5, -5, 0.3, 0)

-- =========================================================================
-- 1. GUI Nesnelerini Otomatik Olarak Oluşturma
-- =========================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedControllerGUI"
ScreenGui.Parent = StarterGui

-- Ana Toggle Düğmesi (Hız Ayarlarını Aç/Kapat)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Text = "Hız Ayarları"
ToggleBtn.Size = UDim2.new(0, 150, 0, 40)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0) -- Ekranın sol alt kısmı
ToggleBtn.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = ScreenGui

-- Ayarlar Çerçevesi (Frame)
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(0, 200, 0, 150)
SettingsFrame.Position = UDim2.new(0.02, 0, 0.2, 50) -- ToggleBtn'in hemen üstünde/yanında
SettingsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Visible = false -- Başlangıçta gizli
SettingsFrame.Parent = ScreenGui

-- Hız Artırma Düğmesi
local SpeedUpBtn = Instance.new("TextButton")
SpeedUpBtn.Name = "SpeedUpBtn"
SpeedUpBtn.Text = "Hızı Artır (+ "..speedChangeAmount..")"
SpeedUpBtn.Size = UDim2.new(1, 0, 0.3, 0)
SpeedUpBtn.Position = UDim2.new(0, 0, 0.1, 0)
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Yeşil
SpeedUpBtn.Font = Enum.Font.SourceSansBold
SpeedUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedUpBtn.Parent = SettingsFrame

-- Hız Düşürme Düğmesi
local SpeedDownBtn = Instance.new("TextButton")
SpeedDownBtn.Name = "SpeedDownBtn"
SpeedDownBtn.Text = "Hızı Düşür (- "..speedChangeAmount..")"
SpeedDownBtn.Size = UDim2.new(1, 0, 0.3, 0)
SpeedDownBtn.Position = UDim2.new(0, 0, 0.5, 0)
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Kırmızı
SpeedDownBtn.Font = Enum.Font.SourceSansBold
SpeedDownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedDownBtn.Parent = SettingsFrame

-- =========================================================================
-- 2. İşlevselliği Bağlama
-- =========================================================================

-- Toggle Düğmesi: Frame'i Açıp Kapatır
ToggleBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
    
    if SettingsFrame.Visible then
        ToggleBtn.Text = "Hızı Kapat"
    else
        ToggleBtn.Text = "Hız Ayarları"
    end
end)

-- Hız Kontrol Fonksiyonu
local function changeSpeed(increment)
    -- Karakterin yüklendiğinden emin ol
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        local currentSpeed = humanoid.WalkSpeed
        local newSpeed = currentSpeed + increment

        -- Yeni hızın minimum ve maksimum sınırlar içinde kalmasını sağla
        newSpeed = math.max(minSpeed, math.min(newSpeed, maxSpeed))
        
        humanoid.WalkSpeed = newSpeed
        
        print("Yeni Yürüme Hızı: " .. newSpeed)
    end
end

-- Hız Artırma Düğmesi: Tıklandığında hızı artırır
SpeedUpBtn.MouseButton1Click:Connect(function()
    changeSpeed(speedChangeAmount)
end)

-- Hız Düşürme Düğmesi: Tıklandığında hızı düşürür
SpeedDownBtn.MouseButton1Click:Connect(function()
    changeSpeed(-speedChangeAmount)
end)
