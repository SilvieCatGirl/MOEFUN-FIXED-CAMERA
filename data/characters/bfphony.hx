function onGameOver()
{
	if (boyfriend.curCharacter == 'bfphony')
	{
		health = 0.00000001;
		openSubState(new ScriptedSubstate('BFPhonyDead'));
		return Function_Stop;
	}
}