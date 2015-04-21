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
	player:setState('leg', 'idle')
	player:setState('torso', 'idle')
	if love.keyboard.isDown('d') then
		player:move(200 * dt, 0)
		player:setState('leg', 'walk')
		player:setState('torso', 'move')
	end
	if love.keyboard.isDown('a') then
		player:move(-200 * dt, 0)
		player:setState('leg', 'walk')
		player:setState('torso', 'move')
	end
	if love.keyboard.isDown('w') then
		player:move(0, -200 * dt)
		player:setState('leg', 'walk')
		player:setState('torso', 'move')
	end
	if love.keyboard.isDown('s') then
		player:move(0, 200 * dt)
		player:setState('leg', 'walk')
		player:setState('torso', 'move')
	end

	player:rotateTowards(love.mouse.getX(), love.mouse.getY())
	player:update(dt)

	for k, v in pairs(bullets) do
		v:update(dt)
		if v.destroyed then
			table.remove(bullets, k)
		end
	end

	collision.collider:update(dt)
end

function love.draw()
	for k, v in pairs(bullets) do
		v:draw()
	end
	player:draw()

	love.graphics.setColor(255, 0, 0, 255)
	for k, v in pairs(walls) do
		v:draw('fill')
	end
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		table.insert(bullets, Bullet:new(player:getPosition().x + 46 * math.cos(player:getRotation()) - 26 * math.sin(player:getRotation()), player:getPosition().y + 46 * math.sin(player:getRotation()) + 26 * math.cos(player:getRotation()), player:getRotation()))
		player:setState('torso', 'shoot')
	end
end