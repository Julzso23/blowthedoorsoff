local class = require('lib/middleclass')
require('modules/collision')
require('modules/animation')

Player = class('Player')

function Player:initialize()
	self.shape = collision.collider:addRectangle(0, 0, 96, 96)
	self.shape.isPlayer = true

	self.legAnimations = {}
	self.legAnimations.idle = Animation:new('player/feet/idle.png', 132, 0.05)
	self.legAnimations.walk = Animation:new('player/feet/walk.png', 172, 0.05)
	self.legAnimations.strafeLeft = Animation:new('player/feet/strafe-left.png', 155, 0.05)
	self.legAnimations.strafeRight = Animation:new('player/feet/strafe-right.png', 154, 0.05)

	self.torsoAnimations = {}
	self.torsoAnimations.idle = Animation:new('player/handgun/idle.png', 253, 0.05)
	self.torsoAnimations.move = Animation:new('player/handgun/move.png', 258, 0.05)
	self.torsoAnimations.shoot = Animation:new('player/handgun/shoot.png', 255, 0.05)

	self.legState = 'idle'
	self.torsoState = 'idle'
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
function Player:rotateTowards(x, y)
	local px, py = self.shape:center()
	if (y > py) and (x > px) then
		self.shape:setRotation(math.atan((y - py) / (x - px)))
	elseif x < px then
		self.shape:setRotation(math.atan((y - py) / (x - px)) + math.pi)
	elseif (y < py) and (x > px) then
		self.shape:setRotation(math.atan((y - py) / (x - px)) + 2 * math.pi)
	end
end

function Player:setState(part, state)
	if part == 'leg' then
		self.legState = state
	elseif part == 'torso' and self.torsoState ~= 'shoot' then
		self.torsoState = state
	end
end

function Player:update(dt)
	self.legAnimations[self.legState]:update(dt)
	if self.torsoState == 'shoot' then
		if self.torsoAnimations[self.torsoState]:update(dt) then
			self.torsoState = 'idle'
		end
	else
		self.torsoAnimations[self.torsoState]:update(dt)
	end
end

function Player:draw()
	local x, y = self.shape:center()
	self.legAnimations[self.legState]:draw(x, y, self.shape:rotation())
	self.torsoAnimations[self.torsoState]:draw(x, y, self.shape:rotation())
end