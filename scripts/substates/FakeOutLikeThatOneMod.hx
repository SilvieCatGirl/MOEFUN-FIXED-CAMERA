import funkin.states.substates.GameOverSubstate;

function onLoad()
{
	game.persistentUpdate = false;
	game.persistentDraw = true;
	game.audio?.pause();
	game.paused = true;

	PlayState.instance.camHUD.alpha = 0;

	fuckassVOID = new flixel.FlxSprite(0, 0).makeGraphic(5000, 5000, 0xff000000);
	fuckassVOID.screenCenter();
	add(fuckassVOID);

	boyfriend_troll = new funkin.objects.Character(0, 0, 'boyfriend_fakeout', true);
	add(boyfriend_troll);
	boyfriend_troll.x = PlayState.instance.boyfriend.x;
	boyfriend_troll.y = PlayState.instance.boyfriend.y;
	boyfriend_troll.updateHitbox();
	boyfriend_troll.offset.x = 10;
	boyfriend_troll.offset.y = -70;
	boyfriend_troll.playAnim('trolololololol');

	FlxG.sound.play(Paths.sound('rareChance/fakeout_death', null, PathsTestMode.LOOSE));

	FlxG.signals.postUpdate.addOnce(theShit);
}

function theShit()
{
	new flixel.util.FlxTimer().start(6.25, function(_) {
		close();
	});
}