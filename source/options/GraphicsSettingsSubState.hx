package options;


class GraphicsSettingsSubState extends BaseOptionsMenu
{
	var antialiasingOption:Int;
	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Graphics Settings Menu'; //for Discord Rich Presence

		//I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Low Quality', //Name
			'If checked, disables some background details,\ndecreases loading times and improves performance.', //Description
			'lowQuality', //Save data variable name
			'bool'); //Variable type
		addOption(option);

		var option:Option = new Option('Anti-Aliasing',
			'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.',
			'antialiasing',
			'bool');
		option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);
		antialiasingOption = optionsArray.length-1;


		var option:Option = new Option('Shaders', //Name
			"If unchecked, disables shaders.\nIt's used for some visual effects, and also CPU intensive for weaker PCs.", //Description
			'shaders',
			'bool');
		addOption(option);

		var option:Option = new Option('VRAM Caching', //Name
			"If checked, allows the GPU to be used for caching textures, decreasing RAM usage.\nDon't turn this on if you have a shitty Graphics Card.", //Description
			'cacheOnGPU',
			'bool');
		addOption(option);

		#if !html5 
		#if desktop
		//different res cant really be done on browser lol
		var option:Option = new Option('Resolution: ',
			"What resolution do you want the game to run in?",
			'resolution',
			'string',
			//9p,     18p,    36p, 	   72p,       120p,      144p,      270p       360p,      540p,      720p,       1080p (HD),  1440p (FHD),  2160p (UHD, 4K) yeah i went a bit too far with these
			['16x9', '32x18', '64x36', '128x72', '214x120', '256x144', '480x270', '640x360', '960x540', '1280x720', '1920x1080', '2560x1440', '3840x2160']);
		addOption(option);
		option.onChange = onChangeResolution;
		#end

	//Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		var option:Option = new Option('Framerate',
			"Changes your FPS Limit 60-360 FPS.",
			'framerate',
			'int');
		addOption(option);

		final refreshRate:Int = FlxG.stage.application.window.displayMode.refreshRate;
		option.minValue = 60;
		option.maxValue = 360;
		option.defaultValue = Std.int(FlxMath.bound(refreshRate, option.minValue, option.maxValue));
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		#end

		super();
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:FlxSprite = cast sprite;
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.data.antialiasing;
			}
		}
	}

	function onChangeFramerate()
	{
		if(ClientPrefs.data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.data.framerate;
			FlxG.drawFramerate = ClientPrefs.data.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.data.framerate;
			FlxG.updateFramerate = ClientPrefs.data.framerate;
		}
	}

	function onChangeResolution() {
		#if desktop
    		var resolutionValue = cast(ClientPrefs.data.resolution, String); // Assuming 'clientprefs.resolution' holds the selected resolution

    		if (resolutionValue != null) {
        		var parts = resolutionValue.split('x');
        
        		if (parts.length == 2) {
            			var width = Std.parseInt(parts[0]);
            			var height = Std.parseInt(parts[1]);
            
            			if (width != null && height != null) {
					CoolUtil.resetResScale(width, height);
                			FlxG.resizeGame(width, height);
					lime.app.Application.current.window.width = width;
					lime.app.Application.current.window.height = height;
            			}
        		}
    		}
		#end
}
}