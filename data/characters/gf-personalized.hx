function onSectionHit()
{
	var suffix:String = (mustHitSection ? '-bf' : '');

	if (gf.curCharacter == 'gf-personalized')
	{
		if (game.gf.idleSuffix != suffix) // making sure shes not already looking in the direction we want
		{
			game.gf.playAnim('turn' + suffix, true);
			game.gf.idleSuffix = suffix;
			game.gf.recalculateDanceIdle();
			game.gf.danced = false; // fuck my gay life
		}
	}
}