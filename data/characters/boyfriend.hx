using StringTools;

var doWeLegs:Bool = false;
public var bfOldLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

var getTrolled = false;

var allow_gf_taunt = true;

var bullshit = false;

function onLoad()
{
	doWeLegs = (ClientPrefs.bfSkin == 'boyfriend' && PlayState.SONG.stage == 'danger');

	getTrolled = FlxG.random.bool((1 / 4096) * 100);

	if (!doWeLegs) return;

	bfOldLegs = new Character(0, 0, 'boyfriend-legs', true);
	boyfriendGroup.insert(0, bfOldLegs);
}

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "o2", "jads", "chef":
			changeCharacter("boyfriend-with-girlfriend", 0);
	}

	if (FlxG.random.bool(15))
	{
		if (boyfriend.library != null)
		{
			var hand = [boyfriend.library.getSymbol('mic hand'), boyfriend.library.getSymbol('arm default'), boyfriend.library.getSymbol('BF defalt arm')];

			if (hand != null)
			{
				for (i in 0...hand.length)
				{
					hand[i].timeline.layers[0].forEachFrame((frame) -> {
						for (i in frame.elements) i.visible = false;
					});
				}
			}
		}
	}

	if (!doWeLegs) return;

	changeCharacter('boyfriend-running', 0);

	bfOldLegs.x = game.boyfriend.x + 10;
	bfOldLegs.y = game.boyfriend.y + 205;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;
}

function onUpdatePost(elapsed)
{
	gfTaunt();

	if (!doWeLegs) return;

	game.boyfriend.y = bfAnchorPoint[1] + legPosY[bfOldLegs.animation.curAnim.curFrame];

	// This changes the legs from the miss version to the normal one and makes sure it starts on the same animation frame where it left off
	if (!boyfriend.getAnimName().contains('miss') && bfOldLegs.getAnimName().contains('miss'))
	{
		var lastFrame:Int = 0;
		var lastDance:String = 'danceLeft';

		lastFrame = bfOldLegs.animation.curAnim.curFrame;
		lastDance = bfOldLegs.getAnimName();
		bfOldLegs.idleSuffix = '';
		bfOldLegs.recalculateDanceIdle();
		bfOldLegs.playAnim(lastDance, false);
		bfOldLegs.animation.curAnim.curFrame = lastFrame;
	}

	if (boyfriend.getAnimName().contains('dance'))
	{
		bfOldLegs.visible = false;
		bfOldLegs.idleSuffix = '';
		bfOldLegs.recalculateDanceIdle();
	}
}

function gfTaunt()
{
	if (!baddieExists) return;

	if (controls.NOTE_TAUNT_P && boyfriend.curCharacter == 'boyfriend' && boyfriend.getAnimName() == 'hey' && allow_gf_taunt)
	{
		if (gf.curCharacter == 'boyfriend-speaker')
		{
			gf.playAnim('cheer');
			gf.specialAnim = true;

			allow_gf_taunt = false;
		}
	}

	if (gf.getAnimName() != 'cheer')
	{
		allow_gf_taunt = true;
	}
}

function goodNoteHit()
{
	if (!doWeLegs) return;

	bfOldLegs.visible = true;
}

function onKeyRelease()
{
	if (!doWeLegs) return;

	game.boyfriend.danced = bfOldLegs.danced;
}

function onCountdownTick()
{
	if (!doWeLegs) return;

	bfOldLegs.dance();
}

function onBeatHit()
{
	if (!doWeLegs) return;

	if (curBeat % 1 == 0)
	{
		bfOldLegs.dance();
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	if (!doWeLegs) return;

	bfOldLegs.visible = true;

	var lastFrame:Int = 0;
	var lastDance:String = 'danceLeft';
	
	lastFrame = bfOldLegs.animation.curAnim.curFrame;
	lastDance = bfOldLegs.getAnimName();
	bfOldLegs.idleSuffix = '-miss';
	bfOldLegs.recalculateDanceIdle();
	bfOldLegs.playAnim(lastDance + '-miss', true);
	bfOldLegs.animation.curAnim.curFrame = lastFrame;
}

function onPause()
{
	if (getTrolled && startedFakeout)
	{
		return Function_Stop;
	}
}

function onGameOver()
{
	if (boyfriend.curCharacter != 'boyfriend') return;

	if (getTrolled && !bullshit)
	{
		bullshit = true;
		getTrolled = false;
		openSubState(new ScriptedSubstate('FakeOutLikeThatOneMod'));
		return Function_Stop;
	}
}