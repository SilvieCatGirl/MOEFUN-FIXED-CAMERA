import flixel.group.FlxTypedGroup;

var counter = 6;
var _glint_min = 4;
var _glint_max = 8;

var aura_farm = false;
var floatElapse:Float = 0;
var baseY:Float = 0;
var floatAmount:Float = 65;
var floatSpeed:Float = 2;
var spawnTimer:Float = 0;
var trailGroup:FlxTypedGroup = new FlxTypedGroup();

function onCreatePost()
{
	baseY = pet.y - 100;
	stage.insert(stage.members.indexOf(pet), trailGroup);
	if (FlxG.random.bool())
	{
		aura_farm = true;
		pet.loadPet('roar_swing');
	}
}

function onUpdate(elapsed) {
	floatElapse += elapsed * floatSpeed;
	spawnTimer += elapsed;
	pet.y = baseY + floatAmount * Math.sin(floatElapse);

	if (spawnTimer > 0.2)
	{
		spawnTimer = 0;
		spawnTrail();
	}
}

function spawnTrail() {
	var trail;
	if (trailGroup.getFirstDead() != null)
	{
		// recycle sprites instead of just creating them endlessly
		trail = trailGroup.getFirstDead();
		trail.revive();
		trailGroup.remove(trail);
		trailGroup.add(trail);
	}
	else 
	{
		trail = pet.clone();
		trail.scale = pet.scale;
		trail.updateHitbox();
		trail.velocity.x = 200;
		trailGroup.add(trail);
		trail.shader = pet.shader;
	}
	trail.x = pet.x;
	trail.y = pet.y;
	trail.offset = pet.offset;
	trail.angle = pet.angle;
	trail.alpha = 1;
	FlxTween.tween(trail, {alpha: 0}, 1, {onComplete: () -> trail.kill()});
}

function onBeatHit()
{
	if (aura_farm) return;

	if (counter > 0) counter--;
	else
	{
		parent.playAnim('glint', true);
		counter = FlxG.random.int(_glint_min, _glint_max);
	}
}