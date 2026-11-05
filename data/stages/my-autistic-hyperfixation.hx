var theRAILS:FlxBackdrop;
var tom:Character;

var ext = 'stages/thomas.gbc/';

function onLoad()
{
	theRAILS = new FlxBackdrop(Paths.image('${ext}placeholderStage'), FlxAxes.X, null, null, null, PathsTestMode.LOOSE);
	theRAILS.camera = PlayState.instance.camHUD;
	theRAILS.scale.set(2.66, 2.658);
	theRAILS.scale.x /= 2;
	theRAILS.scale.y /= 2;
	theRAILS.screenCenter();
	theRAILS.updateHitbox();
	add(theRAILS);

	tom = new Character(0, 0, 'minithomas', false);
	tom.camera = PlayState.instance.camHUD;
	tom.scale.x /= 2;
	tom.scale.y /= 2;
	tom.screenCenter();
	tom.updateHitbox();
	tom.x += 365;
	tom.y += 343;
	add(tom);
}

function onUpdatePost(elapsed:Float):Void
{
	theRAILS.x -= 3.5;
}

function opponentNoteHit(note)
{
	characterSing(tom, note);
}