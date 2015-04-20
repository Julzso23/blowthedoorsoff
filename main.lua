require('modules/collision')
require('modules/player')
require('modules/bullet')

function love.load(args)
	player = Player:new()
	walls = {}
	table.insert(walls, collision.collider:addRectangle(256, 256, 512, 16))
	bullets = {}
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

	for k, v in pairs(bullets) do
		v:update(dt)
		if v.destroyed then
			table.remove(bullets, k)
		end
	end

	collision.collider:update(dt)
end

function love.draw()
	player:draw()

	love.graphics.setColor(255, 0, 0, 255)
	for k, v in pairs(walls) do
		v:draw('fill')
	end

	for k, v in pairs(bullets) do
		v:draw()
	end
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		table.insert(bullets, Bullet:new(player:getPosition().x + 32 * math.cos(player:getRotation()), player:getPosition().y + 32 * math.sin(player:getRotation()), player:getRotation()))
	end
end