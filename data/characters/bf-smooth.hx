using StringTools;

var anims = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
var _nuh_uh = 'miss';

function onCreatePost()
{
	for (i in 0...anims.length)
	{
		stupid(anims[i], _nuh_uh);
	}
}

function stupid(anuim, exclusion)
{
	for (anim in boyfriend.animation.getAnimationList())
	{
		if (anim.name.contains(anuim))
		{
			if (!anim.name.contains(exclusion))
			{
				boyfriend.animation.onFinish.add((animName) -> {
					if (animName == anim.name)
					{
						boyfriend.animation.play('idle', true);
					}
				});
			}
		}
	}
}