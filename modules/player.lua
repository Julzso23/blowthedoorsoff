local class = require('lib/middleclass')
require('modules/collision')

Player = class('Player')

function Player:initialize()
	self.shape = collision.collider:addRectangle(0, 0, 64, 64)
end

function Player:move(x, y)
	self.shape:move(x, y)
end
function Player:setPosition(x, y)
	self.shape:moveTo(x, y)
end
function Player:getPosition()
	local x, y = self.shape:center()
	return {x = x, y = y}
end

function Player:rotate(angle)
	self.shape:rotate(angle)
end
function Player:setRotation(angle)
	self.shape:setRotation(angle)
end
function Player:getRotation()
	return self.shape:rotation()
end

function Player:draw()
	love.graphics.setColor(255, 255, 255, 255)
	self.shape:draw('fill')
end