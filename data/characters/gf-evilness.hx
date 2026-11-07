function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			if (value1 == 'scream')
			{
				parent.playAnim('AAAAAAAAAAA', true);
				parent.specialAnim = true;
			}
	}
}