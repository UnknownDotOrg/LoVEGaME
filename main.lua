local player = {
    x = 400,
    y = 300,
    size = 64,
    speed = 250
}

local coin = {
    x = 600,
    y = 300,
    size = 32
}

local score = 0

local screenWidth = 800
local screenHeight = 600

local playerImage
local coinImage


function spawnCoin()
    repeat
        coin.x = math.random(20, screenWidth - coin.size - 20)
        coin.y = math.random(20, screenHeight - coin.size - 20)
    until not (
        player.x < coin.x + coin.size + 50
        and player.x + player.size + 50 > coin.x
        and player.y < coin.y + coin.size + 50
        and player.y + player.size + 50 > coin.y
    )
end


function love.load()
    love.window.setTitle("LÖVEGÄME")
    love.window.setMode(screenWidth, screenHeight)

    math.randomseed(os.time())

    playerImage = love.graphics.newImage("assets/player.png")
    coinImage = love.graphics.newImage("assets/coin.png")

    spawnCoin()
end


function love.update(dt)

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end

    player.x = math.max(
        0,
        math.min(screenWidth - player.size, player.x)
    )

    player.y = math.max(
        0,
        math.min(screenHeight - player.size, player.y)
    )

    if player.x < coin.x + coin.size
        and player.x + player.size > coin.x
        and player.y < coin.y + coin.size
        and player.y + player.size > coin.y then

        score = score + 1
        spawnCoin()
    end
end


function love.draw()

    love.graphics.clear(0.08, 0.08, 0.08)

    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(
        playerImage,
        player.x,
        player.y
    )

    love.graphics.draw(
        coinImage,
        coin.x,
        coin.y
    )

    love.graphics.print(
        "Coins: " .. score,
        20,
        20,
        0,
        2,
        2
    )
end
