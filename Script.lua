local data = require(script:WaitForChild("BadAppleData_32"))

local SIZE = 32
local PIXEL_SIZE = 1
local FPS = 40
local FRAME_DELAY = 1 / FPS

local pixels = {}
local started = false

local ORIGIN = Vector3.new(0, 10, -40)
local BUTTON_POS = Vector3.new(0, 1, 0)

for y = 1, SIZE do
	pixels[y] = {}

	for x = 1, SIZE do
		local part = Instance.new("Part")
		part.Size = Vector3.new(PIXEL_SIZE, PIXEL_SIZE, 1)
		part.Anchored = true
		part.Material = Enum.Material.SmoothPlastic
		part.Color = Color3.new(0, 0, 0)

		part.Position = ORIGIN + Vector3.new(
			x * PIXEL_SIZE,
			(SIZE - y + 1) * PIXEL_SIZE,
			0
		)

		part.Parent = workspace
		pixels[y][x] = part
	end
end

local button = Instance.new("Part")
button.Size = Vector3.new(8, 1, 8)
button.Position = BUTTON_POS + Vector3.new(0, 0, 10)
button.Anchored = true
button.BrickColor = BrickColor.new("Bright green")
button.Name = "StartButton"
button.Parent = workspace

local gui = Instance.new("BillboardGui", button)
gui.Size = UDim2.new(0, 200, 0, 50)
gui.AlwaysOnTop = true

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "TOUCH TO START"
label.TextScaled = true
label.BackgroundTransparency = 1

local function playVideo()
	for _, frame in ipairs(data.frames) do

		for y = 1, SIZE do
			for x = 1, SIZE do

				local value = frame[y][x]

				if value == 1 then
					pixels[y][x].Color = Color3.new(1,1,1)
				else
					pixels[y][x].Color = Color3.new(0,0,0)
				end

			end
		end

		task.wait(FRAME_DELAY)
	end
end

button.Touched:Connect(function(hit)
	if started then return end

	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		started = true

		button.BrickColor = BrickColor.new("Really red")
		label.Text = "PLAYING..."

		playVideo()
	end
end)