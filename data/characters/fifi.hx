function onLoad()
{
	if (gf.library != null)
	{
		var shadow = gf.library.getSymbol('Shadow');
		
		if (shadow != null)
		{
			shadow.timeline.layers[0].forEachFrame((frame) -> {
				for (i in frame.elements) i.visible = false;
			});
		}
	}
}