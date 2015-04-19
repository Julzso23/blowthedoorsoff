local class = require('lib/middleclass')
require('modules/collision')

Bullet = class('Bullet')
Bullet.speed = 1000

function Bullet:initialize(x, y, r)
	self.shape = collision.collider:addRectangle(x, y, 4, 2)
	self.shape:setRotation(r)
	self.shape.isBullet = true
	self.shape.parent = self
	self.velocity = {}
	self.velocity.x = Bullet.speed * math.cos(r)
	self.velocity.y = Bullet.speed * math.sin(r)
	self.destroyed = false
end

function Bullet:update(dt)
	self.shape:move(self.velocity.x * dt, self.velocity.y * dt)
end

function Bullet:draw()
	love.graphics.setColor(255, 255, 255, 255)
	self.shape:draw('fill')
end

function Bullet:destroy()
	collision.collider:remove(self.shape)
	self.destroyed = true
end