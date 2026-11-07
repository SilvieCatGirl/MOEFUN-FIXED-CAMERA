import funkin.audio.visualize.PolygonSpectogram;

var vus:PolygonSpectogram;

function onCreatePost()
{
	vus = new PolygonSpectogram(audio.inst);
	add(vus);

	canPause = false;

	playFields.members[1].camera = PlayState.instance.camGame;
	modManager.setValue("transformX", -100, 1);

	modManager.setValue('sustainSplashAlpha', 1, 1);
}

function onStepHit()
{
	switch (curStep)
	{
		case 188:
			defaultCamZoom = 1.2;
			bfOff[1] = 1420;

		case 192:
			bfOff[1] = 920;

			triggerEventNote('Legacy', 'Show Task Song', 'info');
			canPause = true;
	}
}

function onSpawnNote(note)
{
	if (note.lane == 1)
	{
		note.camera = playFields.members[1].camera;
	}
}