collision = {}
collision.hc = require('lib/hardoncollider')

function collision.start(dt, shapeA, shapeB, dx, dy)
	if shapeA.isPlayer then
		shapeA:move(dx, dy)
	elseif shapeB.isPlayer then
		shapeB:move(-dx, -dy)
	end

	if shapeA.isBullet then
		shapeA.parent:destroy()
	elseif shapeB.isBullet then
		shapeB.parent:destroy()
	end
end

function collision.stop(dt, shapeA, shapeB)
end

collision.collider = collision.hc(100, collision.start, collision.stop)