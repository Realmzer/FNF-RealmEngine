package options;

class QOLSubstate extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Quality Of Life';
		rpcTitle = 'QOL Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('Smooth HP Bar', // Silky Smooth
			"Make the healthbar smooth",
			'smoothbar',
			'bool');
		addOption(option);


		
		super();
	}

}

