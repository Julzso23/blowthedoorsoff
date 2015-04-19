require('modules/collision')
require('modules/player')

function love.load(args)
	player = Player:new()
	walls = {}
	table.insert(walls, collision.collider:addRectangle(256, 256, 512, 16))
end

function love.update(dt)
	if love.keyboard.isDown('d') then
		player:move(200 * dt, 0)
	end
	if love.keyboard.isDown('a') then
		player:move(-200 * dt, 0)
	end
	if love.keyboard.isDown('w') then
		player:move(0, -200 * dt)
	end
	if love.keyboard.isDown('s') then
		player:move(0, 200 * dt)
	end

	player:setRotation(math.atan((love.mouse.getY() - player:getPosition().y) / (love.mouse.getX() - player:getPosition().x)))

	collision.collider:update(dt)
end

function love.draw()
	player:draw()
	love.graphics.setColor(255, 0, 0, 255)
	for k, v in pairs(walls) do
		v:draw('fill')
	end
end