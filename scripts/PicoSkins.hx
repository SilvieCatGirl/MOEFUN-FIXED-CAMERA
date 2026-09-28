public var _hell_yeah_picos = ['17bucks-pico', 'evil-impostor-pico', 'pick', 'pico_due_p1', 'pico_due_p2', 'pico-mix-player', 'pico-playable', 'piico'];

public var _array_picos = ['suspect', 'roomcode'];

var leShitFuckAss;
var leShitFuckAss2;

function onCreatePost()
{
	leName = Paths.sanitize(PlayState.SONG.song);

	if (!hasBfSkin) return;

	for (i in 0..._array_picos.length)
	{
		leShitFuckAss = _array_picos[i];

		switch (leName)
		{
			case leShitFuckAss:
				for (phillies in 0..._hell_yeah_picos.length)
				{
					if (ClientPrefs.bfSkin == _hell_yeah_picos[phillies])
					{
						changeCharacter(ClientPrefs.bfSkin, 0);
					}
				}
		}
	}
}