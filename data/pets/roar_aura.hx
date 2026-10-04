var counter = 6;
var _glint_min = 4;
var _glint_max = 8;

var aura_farm = false;

function onCreatePost()
{
	if (FlxG.random.bool())
	{
		aura_farm = true;
		pet.loadPet('roar_swing');
	}
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