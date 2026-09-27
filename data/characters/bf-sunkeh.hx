function onSpawnNote(note)
{
	if (note.lane != 0) return;

	note.noAnimation = true;
}

function goodNoteHit(note)
{
	parent.holdTimer = 0;

	if (note.isSustainNote) return;

	parent.playAnim(note.skin.data.singAnimations[note.noteData], false);
}