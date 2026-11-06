import funkin.states.StoryMenuState;
import funkin.states.FreeplayState;

var racism:FlxSprite;
var deadfriend:FlxSprite;
var go2:FlxSprite;
var go1:FlxSprite;

var poop:Float = 0;
var thing:Float = 0;

var theTime:FlxTimer;

var restarting:Bool = false;

var restartSoundCustom;

function onLoad()
{
	game.persistentUpdate = false;
	game.persistentDraw = true;
	game.audio?.pause();
	game.paused = true;

	racism = new FlxSprite(0, 0).makeScaledGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	racism.camera = PlayState.instance.camOther;
	racism.screenCenter();
	add(racism);

	deadfriend = new FlxSprite(0, 0).loadGraphic(Paths.image('characters/phony/bfphonydead'));
	deadfriend.camera = PlayState.instance.camOther;
	deadfriend.antialiasing = false;
	deadfriend.scale.set(2, 2);
	deadfriend.screenCenter();
	add(deadfriend);

	go2 = new FlxSprite(0, 0).loadGraphic(Paths.image('characters/phony/gameover'));
	go2.camera = PlayState.instance.camOther;
	go2.antialiasing = false;
	go2.scale.set(5, 5);
	go2.screenCenter();
	go2.alpha = 0.3;
	go2.y += 1000;
	add(go2);

	go1 = new FlxSprite(0, 0).loadGraphic(Paths.image('characters/phony/gameover'));
	go1.camera = PlayState.instance.camOther;
	go1.antialiasing = false;
	go1.scale.set(5, 5);
	go1.screenCenter();
	go1.y += 1000;
	add(go1);

	poop = go1.x;

	FlxG.signals.postUpdate.addOnce(fuckingWork);

	FlxG.sound.play(Paths.sound('fnf_loss_sfx_nomic', null, PathsTestMode.LOOSE));
}

function fuckingWork()
{
	new FlxTimer().start(2.3, () -> {
		FlxTween.tween(go2, {y: go2.y - 1200}, 1, {ease: FlxEase.cubeOut});
		FlxTween.tween(go1, {y: go1.y - 1200}, 1.075, {ease: FlxEase.cubeOut});
	});

	FlxTween.shake(deadfriend, 0.1, 2, FlxAxes.X);

	new FlxTimer().start(2, () -> {
		FlxTween.shake(deadfriend, 0.05, 0.3, FlxAxes.X);
	});
}

function onUpdate(elapsed:Float):Void
{
	thing += elapsed;

	go2.x = (poop + Math.sin(thing - 1) * 2);
	go1.x = (poop + Math.sin(thing) * 2);

	go2.angle = (Math.sin(thing - 1) * 2);
	go1.angle = (Math.sin(thing) * 2);

	if ((controls.ACCEPT || FlxG.mouse.justPressed) && restarting)
	{
		theTime.cancel();
		FlxG.resetState();
		restartSoundCustom.destroy();
	}

	if ((controls.ACCEPT || FlxG.mouse.justPressed) && !restarting)
	{
		FlxTween.tween(go2, {'scale.y': 0}, 2, {ease: FlxEase.backIn});
		FlxTween.tween(go1, {'scale.y': 0}, 2, {ease: FlxEase.backIn});

		FlxTween.tween(go2, {'scale.x': 0}, 2, {ease: FlxEase.backIn});
		FlxTween.tween(go1, {'scale.x': 0}, 2, {ease: FlxEase.backIn});

		FlxTween.tween(deadfriend, {alpha: 0}, 2, {ease: FlxEase.linear});

		restartSoundCustom = FlxG.sound.play(Paths.music('gameOverEnd'));

		FlxG.signals.postUpdate.addOnce(restart);

		restarting = true;
	}

	if (controls.BACK)
	{
		FlxG.switchState(() -> PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());

		FunkinSound.playMusic(Paths.music('freakyMenu'));
	}
}

function restart()
{
	theTime = new FlxTimer();
	
	theTime.start(2.5, () -> {
		FlxG.resetState();
	});
}