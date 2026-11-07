import funkin.audio.visualize.PolygonSpectogram;

var vus:PolygonSpectogram;

function onCreatePost()
{
	vus = new PolygonSpectogram(audio.inst);
	add(vus);
}