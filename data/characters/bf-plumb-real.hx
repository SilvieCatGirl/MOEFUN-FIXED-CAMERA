var counter = 0;
var _step_shit = [
	[287, 291],
	[319, 351],
	[367, 383]
];

function opponentNoteHitPre(note)
{
	if (curSong != 'Identity Crisis') return;

	if (_step_shit[counter] == null) return;

	if (curStep >= _step_shit[counter][0] && curStep < _step_shit[counter][1])
	{
		note.animSuffix = '-alt';
	}

	if (curStep >= _step_shit[counter][1]) counter++;

	if (dad.curCharacter != boyfriend.getFlag('variants')?.monotone) return;

	dad.idleSuffix = note.animSuffix;
}