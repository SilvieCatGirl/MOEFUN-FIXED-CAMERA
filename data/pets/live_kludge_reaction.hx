import funkin.game.shaders.ExtraDropShadowShader;
import funkin.objects.Pet;

var evilShader;
var evilShader2;
var fuckassFire;

var bfRim:ExtraDropShadowShader = new ExtraDropShadowShader();
var gfRim:ExtraDropShadowShader = new ExtraDropShadowShader();
var dadRim:ExtraDropShadowShader = new ExtraDropShadowShader();

var kludge_custom:Pet;

function onLoad()
{
	kludge_custom = new Pet(0, 0);
	kludge_custom.loadPet(pet.curPet);
	add(kludge_custom);

	if (FlxG.random.bool(10))
	{
		kludge_custom.loadPet('evil_kludge_reaction');

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
		fuckassFire.scale.set(3, 5);
		fuckassFire.screenCenter();
		fuckassFire.y = (FlxG.height - fuckassFire.height) + 630;
		insert(2, fuckassFire);

		FlxG.signals.postUpdate.addOnce(function() {
			fire_shaders();
		});
	}

	parent.visible = false;
	parent.active = false;
}

function onCreatePost()
{
	kludge_custom.camera = PlayState.instance.camOther; // Billy told me to put it above the notes
	kludge_custom.x = FlxG.width - kludge_custom.width;
	kludge_custom.y = 0;

	if (curSong == 'Identity Crisis')
	{
		copyPet.camera = PlayState.instance.camOther;
		copyPet.zIndex = 10;
		copyPet.x = 0;
		copyPet.y = 0;
	}
}

function onGameOverPost()
{
	kludge_custom.camera = GameOverSubstate.instance.camCTRL;
	kludge_custom.loadPet(pet.curPet);
	GameOverSubstate.instance.add(kludge_custom);
}

function onUpdatePost(elapsed:Float):Void
{
	if (kludge_custom.shader != null)
	{
		kludge_custom.shader = null;
	}

	if (kludge_custom.alpha != 1)
	{
		kludge_custom.alpha = 1;
	}

	if (kludge_custom.visible != true)
	{
		kludge_custom.visible = true;
	}

	if (evilShader != null)
	{
		health -= 0.000001 * (((FlxG.height - fuckassFire.height) + 630) - fuckassFire.y);

		if (fuckassFire.y > ((FlxG.height - fuckassFire.height) - 370))
		{
			fuckassFire.y -= (0.1 * (songMisses + 1)) * playbackRate;
		}

		if (FlxG.keys.justPressed.ALT)
		{
			FlxTween.cancelTweensOf(fuckassFire);
			FlxTween.tween(fuckassFire, {y: fuckassFire.y + 20}, 0.3, {ease: FlxEase.quartOut});
		}

		if (ClientPrefs.shaders)
		{
			dist = ((((FlxG.height - fuckassFire.height) + 630) - fuckassFire.y) / 5);

			distRecalc = (dist > 0 ? dist : 0);

			bfRim.layers[0].distance = gfRim.layers[0].distance = dadRim.layers[0].distance = distRecalc;
		}
	}
}

function fire_shaders()
{
	if (!ClientPrefs.shaders) return;

	var evilFuckedUpNess:ExtraDropShadowShader = new ExtraDropShadowShader();

	evilFuckedUpNess.addLayer([
		  5, -.1, 20,   0,  64,
		-.3, 1.6, .1,   0,  -8,
		  0,   0,  1, -.3, -16,
		  0,   0,  0,   1,   0
	], 330, 25, .01);

	bfRim = evilFuckedUpNess;
	bfRim.layers[0].angle = 270;
	bfRim.attachedSprite = boyfriend;
	boyfriend.useRenderTexture = true;

	gfRim.copyFrom(dadRim.copyFrom(bfRim));

	dadRim.attachedSprite = dad;
	dad.useRenderTexture = true;

	if (gf != null)
	{
		gfRim.attachedSprite = gf;
		gf.useRenderTexture = true;
	}
}