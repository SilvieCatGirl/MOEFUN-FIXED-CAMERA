function onLoad()
{
	parent.camera = PlayState.instance.camOther; // Billy told me to put it above the notes
	parent.screenCenter();
	parent.x += 456;
	parent.y -= 222;
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
}