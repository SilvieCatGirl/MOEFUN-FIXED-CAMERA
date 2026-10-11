var funny_noise:FlxSound;

function onLoad()
{
	funny_noise = FlxG.sound.load(Paths.sound('FISH', null, PathsTestMode.LOOSE));

	parent.animation.onFrameChange.add((animName) -> {
		if (animName == 'hey')
		{
			if (parent.animation.curAnim.curFrame == 0)
			{
				funny_noise.play(true);
			}
		}
	});
}