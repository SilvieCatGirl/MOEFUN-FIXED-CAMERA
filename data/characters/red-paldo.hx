public var crashing = false;

public var camLerp = 0;

function onUpdatePost(elapsed:Float):Void
{
	if (controls.NOTE_TAUNT_P && !crashing)
	{
		camLerp = FlxG.camera.followLerp;
		game.persistentUpdate = false;
		game.persistentDraw = true;
		FlxG.camera.followLerp = 0;
		game.audio?.pause();
		game.paused = true;
		canPause = false;
		crashing = true;

		Paths.overrideMode = PathsTestMode.LOOSE;
		openSubState(new ScriptedSubstate('CrashSubState'));
	}
}