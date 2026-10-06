import funkin.game.shaders.ExtraDropShadowShader;

var evilShader;
var evilShader2;
var fuckassFire;

function onLoad()
{
	if (FlxG.random.bool(100))
	{
		parent.loadPet('evil_kludge_reaction');

		evilShader = new FunkinSprite(0, 0).makeGraphic(FlxG.width + 10, FlxG.height + 10, 0xFFFF0000);
		evilShader.camera = PlayState.instance.camOther;
		evilShader.blend = BlendMode.OVERLAY;
		evilShader.screenCenter();
		evilShader.alpha = 0.4;
		insert(0, evilShader);

		evilShader2 = new FunkinSprite(0, 0).makeGraphic(FlxG.width + 10, FlxG.height + 10, 0xFFFF7300);
		evilShader2.camera = PlayState.instance.camOther;
		evilShader2.blend = BlendMode.OVERLAY;
		evilShader2.screenCenter();
		evilShader2.alpha = 0.4;
		insert(0, evilShader2);

		fuckassFire = new FlxSprite(0, 0);
		fuckassFire.frames = Paths.getSparrowAtlas('evil fucking fire', null, null, PathsTestMode.LOOSE);
		fuckassFire.animation.addByPrefix('idle', 'idle', 18, true);
		fuckassFire.animation.play('idle');
		fuckassFire.camera = PlayState.instance.camOther;
		fuckassFire.scale.x = 3;
		fuckassFire.scale.y = 5;
		fuckassFire.screenCenter();
		fuckassFire.y = (FlxG.height - fuckassFire.height) + 630;
		insert(2, fuckassFire);

		FlxG.signals.postUpdate.addOnce(function() {
			fire_shaders();
		});
	}
}

function onCreatePost()
{
	parent.camera = PlayState.instance.camOther; // Billy told me to put it above the notes
	parent.x = FlxG.width - parent.width;
	parent.y = 0;
}

function onUpdatePost(elapsed:Float):Void
{
	if (parent.shader != null)
	{
		parent.shader = null;
	}

	if (parent.alpha != 1)
	{
		parent.alpha = 1;
	}

	if (parent.visible != true)
	{
		parent.visible = true;
	}

	if (evilShader != null)
	{
		health -= 0.000001 * (((FlxG.height - fuckassFire.height) + 630) - fuckassFire.y);

		if (fuckassFire.y > ((FlxG.height - fuckassFire.height) - 370))
		{
			fuckassFire.y -= 0.1 * (songMisses + 1);
		}
	}

	if (FlxG.keys.justPressed.ALT)
	{
		FlxTween.cancelTweensOf(fuckassFire);
		FlxTween.tween(fuckassFire, {y: fuckassFire.y + 20}, 0.3, {ease: FlxEase.quartOut});
	}
}

function fire_shaders()
{
	if (!ClientPrefs.shaders) return;

	var evilFuckedUpNess:ExtraDropShadowShader = new ExtraDropShadowShader();

	evilFuckedUpNess.setColorMatrix([
		0.8,   0, 0.4, 0, 16,
		-.1, 0.6, -.1, 0,  0,
		0.2,   0, 0.6, 0, 24,
		  0,   0,   0, 1,  0
	]);
	evilFuckedUpNess.addLayer([
		5, -.1, .2, 0, 64,
		-.3, 1.6,  0, 0, 32,
		  0,   0,  1, 0,  0,
		  0,   0,  0, 1,  0
	], 330, 25, .01);

	var bfRim = evilFuckedUpNess;
	bfRim.layers[0].angle = 270;
	bfRim.layers[1].angle = 270;
	bfRim.attachedSprite = boyfriend;
	boyfriend.useRenderTexture = true;

	var gfRim:ExtraDropShadowShader = new ExtraDropShadowShader();
	var dadRim:ExtraDropShadowShader = new ExtraDropShadowShader();

	gfRim.copyFrom(dadRim.copyFrom(bfRim));

	dadRim.attachedSprite = dad;
	dad.useRenderTexture = true;

	if (gf != null)
	{
		gfRim.attachedSprite = gf;
		gf.useRenderTexture = true;
	}
}