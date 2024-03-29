package options;

class OptimizationsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Optimization';
		rpcTitle = 'Optimizations Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('Further less Botplay Lag', //No more Combos
			"Disables Notesplashes along side with no combo images",
			'nomoreLag',
			'bool');
		addOption(option);

		var option:Option = new Option('Static Strums', // No more Strum Animations
			"Keeps the strums static",
			'strumstatic',
			'bool');
		addOption(option);

		var option:Option = new Option('Hide Characters', 
		"Hides the characters for less MEM Usuage",
		'hideDeCharacter',
		'bool');
		//addOption(option);


		
		super();
	}

}

