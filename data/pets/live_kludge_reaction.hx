function onLoad()
{
	parent.camera = PlayState.instance.camOther; // Billy told me to put it above the notes
	parent.screenCenter();
	parent.x += 456;
	parent.y -= 222;
}