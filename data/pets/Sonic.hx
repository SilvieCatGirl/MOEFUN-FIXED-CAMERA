var stepsToEnd = 8;
var customTimer = stepsToEnd;

function goodNoteHit(note)
{
	parent.playAnim(note.skin.data.singAnimations[note.noteData], true);
	parent.canDance = false;
	customTimer = 0;
}

function onStepHit()
{
	if (customTimer < stepsToEnd) customTimer++;
	else if (!parent.canDance)
	{
		parent.canDance = true;
		parent.dance(true);
	}
}