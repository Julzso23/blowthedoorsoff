local class = require('lib/middleclass')

Animation = class('Animation')

function Animation:initialize(path, width, period)
	self.img = love.graphics.newImage('images/' .. path)
	self.quads = {}
	for x = 0, (self.img:getWidth() / width) - 1 do
		table.insert(self.quads, love.graphics.newQuad(x * width, 0, width, self.img:getHeight(), self.img:getWidth(), self.img:getHeight()))
	end
	self.curQuad = 1
	self.timer = 0
	self.period = period
end

function Animation:update(dt)
	self.timer = self.timer + dt
	if self.timer >= self.period then
		self.timer = 0
		if self.curQuad == #self.quads then
			self.curQuad = 1
		else
			self.curQuad = self.curQuad + 1
		end
	end
end

function Animation:draw(x, y)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.img, self.quads[self.curQuad], x, y)
end