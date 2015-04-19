collision = {}
collision.hc = require('lib/hardoncollider')

function collision.start(dt, shapeA, shapeB, dx, dy)
	shapeA:move(dx, dy)
end

function collision.stop(dt, shapeA, shapeB)
end

collision.collider = collision.hc(100, collision.start, collision.stop)