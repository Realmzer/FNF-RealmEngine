package options;

class MiscSubstate extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Miscellaneous';
		rpcTitle = 'Miscellaneous Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('Skip Restart Transition',
			"If checked, skips the restart transition.",
			'restartskiptran',
			'bool');
		addOption(option);
		
		super();
	}

}

