package backend;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import haxe.io.Bytes;
import backend.Song.SwagSong;

class CoolUtil
{
	inline public static function quantize(f:Float, snap:Float){
		// changed so this actually works lol
		var m:Float = Math.fround(f * snap);
		//trace(snap);
		return (m / snap);
	}

	#if desktop
	public static var resW:Float = 1;
	public static var resH:Float = 1;
	public static var baseW:Float = 1;
	public static var baseH:Float = 1;
	inline public static function resetResScale(wid:Int = 1280, height:Int = 720) {
		resW = wid/baseW;
		resH = height/baseH;
	}
	#end

	public static function getUsername():String
		{
			// uhh this one is self explanatory
			#if windows
			return Sys.getEnv("USERNAME");
			#else
			return Sys.getEnv("USER");
			#end
		}
	
	public static function getUserPath():String
		{
			// this one is also self explantory
			#if windows
			return Sys.getEnv("USERPROFILE");
			#else
			return Sys.getEnv("HOME");
			#end
		}
	
	public static function getTempPath():String
		{
			// gets appdata temp folder lol
			#if windows
			return Sys.getEnv("TEMP");
			#else
			// most non-windows os dont have a temp path, or if they do its not 100% compatible, so the user folder will be a fallback
			return Sys.getEnv("HOME");
			#end
		}

	public static function checkForOBS():Bool
		{
			var fs:Bool = FlxG.fullscreen;
			if (fs)
			{
				FlxG.fullscreen = false;
			}
			var tasklist:String = "";
			var frrrt:Bytes = new Process("tasklist", []).stdout.readAll();
			tasklist = frrrt.getString(0, frrrt.length);
			if (fs)
			{
				FlxG.fullscreen = true;
			}
			return tasklist.contains("obs64.exe") || tasklist.contains("obs32.exe") || tasklist.contains("Streamlabs OBS.exe") || tasklist.contains("bdcam.exe"); //More Recording Software
			}

			public static function getSongDuration(musicTime:Float, musicLength:Float, precision:Int = 0):String
				{
					final secondsMax:Int = Math.floor((musicLength - musicTime) / 1000); // 1 second = 1000 miliseconds
					var secs:String = '' + Math.floor(secondsMax) % 60;
					var mins:String = "" + Math.floor(secondsMax / 60)%60;
					final hour:String = '' + Math.floor(secondsMax / 3600)%24;
			
					if (secs.length < 2)
						secs = '0' + secs;
			
					var shit:String = mins + ":" + secs;
					if (hour != "0"){
						if (mins.length < 2) mins = "0"+ mins;
						shit = hour+":"+mins + ":" + secs;
					}
					if (precision > 0)
					{
						var secondsForMS:Float = ((musicLength - musicTime) / 1000) % 60;
						var seconds:Int = Std.int((secondsForMS - Std.int(secondsForMS)) * Math.pow(10, precision));
						shit += ".";
						shit += seconds;
					}
					return shit;
				}
				public static function formatTime(musicTime:Float, precision:Int = 0):String
				{
					var secs:String = '' + Math.floor(musicTime / 1000) % 60;
					var mins:String = "" + Math.floor(musicTime / 1000 / 60) % 60;
					var hour:String = '' + Math.floor((musicTime / 1000 / 3600)) % 24;
					var days:String = '' + Math.floor((musicTime / 1000 / 86400)) % 7;
					var weeks:String = '' + Math.floor((musicTime / 1000 / (86400 * 7)));
			
					if (secs.length < 2)
						secs = '0' + secs;
			
					var shit:String = mins + ":" + secs;
					if (hour != "0" && days == '0'){
						if (mins.length < 2) mins = "0"+ mins;
						shit = hour+":"+mins + ":" + secs;
					}
					if (days != "0" && weeks == '0'){
						shit = days + 'd ' + hour + 'h ' + mins + "m " + secs + 's';
					}
					if (weeks != "0"){
						shit = weeks + 'w ' + days + 'd ' + hour + 'h ' + mins + "m " + secs + 's';
					}
					if (precision > 0)
					{
						var secondsForMS:Float = (musicTime / 1000) % 60;
						var seconds:Int = Std.int((secondsForMS - Std.int(secondsForMS)) * Math.pow(10, precision));
						shit += ".";
						if (precision > 1 && Std.string(seconds).length < precision)
						{
							var zerosToAdd:Int = precision - Std.string(seconds).length;
							for (i in 0...zerosToAdd) shit += '0';
						}
						shit += seconds;
					}
					return shit;
				}

				public static function zeroFill(value:Int, digits:Int) {
					var length:Int = Std.string(value).length;
					var format:String = "";
					if(length < digits) {
						for (i in 0...(digits - length))
							format += "0";
						format += Std.string(value);
					} else format = Std.string(value);
					return format;
				}
			
				public static function floatToStringPrecision(n:Float, prec:Int){
					n = Math.round(n * Math.pow(10, prec));
					var str = ''+n;
					var len = str.length;
					if(len <= prec){
						while(len < prec){
							str = '0'+str;
							len++;
						}
						return '0.'+str;
					}else{
						return str.substr(0, str.length-prec) + '.'+str.substr(str.length-prec);
					}
				}

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	inline public static function coolTextFile(path:String):Array<String>
	{
		var daList:String = null;
		#if (sys && MODS_ALLOWED)
		var formatted:Array<String> = path.split(':'); //prevent "shared:", "preload:" and other library names on file path
		path = formatted[formatted.length-1];
		if(FileSystem.exists(path)) daList = File.getContent(path);
		#else
		if(Assets.exists(path)) daList = Assets.getText(path);
		#end
		return daList != null ? listFromString(daList) : [];
	}

	inline public static function colorFromString(color:String):FlxColor
	{
		var hideChars = ~/[\t\n\r]/;
		var color:String = hideChars.split(color).join('').trim();
		if(color.startsWith('0x')) color = color.substring(color.length - 6);

		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
		if(colorNum == null) colorNum = FlxColor.fromString('#$color');
		return colorNum != null ? colorNum : FlxColor.WHITE;
	}

	inline public static function listFromString(string:String):Array<String>
	{
		var daList:Array<String> = [];
		daList = string.trim().split('\n');

		for (i in 0...daList.length)
			daList[i] = daList[i].trim();

		return daList;
	}

	public static function floorDecimal(value:Float, decimals:Int):Float
	{
		if(decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	public static function toCompactNumber(number:Float):String
		{
			var suffixes1:Array<String> = ['ni', 'mi', 'bi', 'tri', 'quadri', 'quinti', 'sexti', 'septi', 'octi', 'noni'];
			var tenSuffixes:Array<String> = ['', 'deci', 'viginti', 'triginti', 'quadraginti', 'quinquaginti', 'sexaginti', 'septuaginti', 'octoginti', 'nonaginti', 'centi'];
			var decSuffixes:Array<String> = ['', 'un', 'duo', 'tre', 'quattuor', 'quin', 'sex', 'septe', 'octo', 'nove'];
			var centiSuffixes:Array<String> = ['centi', 'ducenti', 'trecenti', 'quadringenti', 'quingenti', 'sescenti', 'septingenti', 'octingenti', 'nongenti'];
	
			var magnitude:Int = 0;
			var num:Float = number;
			var tenIndex:Int = 0;
	
			while (num >= 1000.0)
			{
				num /= 1000.0;
	
				if (magnitude == suffixes1.length - 1) {
					tenIndex++;
				}
	
				magnitude++;
	
				if (magnitude == 21) {
					tenIndex++;
					magnitude = 11;
				}
			}
	
			// Determine which set of suffixes to use
			var suffixSet:Array<String> = (magnitude <= suffixes1.length) ? suffixes1 : ((magnitude <= suffixes1.length + decSuffixes.length) ? decSuffixes : centiSuffixes);
	
			// Use the appropriate suffix based on magnitude
			var suffix:String = (magnitude <= suffixes1.length) ? suffixSet[magnitude - 1] : suffixSet[magnitude - 1 - suffixes1.length];
			var tenSuffix:String = (tenIndex <= 10) ? tenSuffixes[tenIndex] : centiSuffixes[tenIndex - 11];
	
			// Use the floor value for the compact representation
			var compactValue:Float = Math.floor(num * 100) / 100;
	
			if (compactValue <= 0.001) {
				return "0"; // Return 0 if compactValue = null
			} else {
				var illionRepresentation:String = "";
	
				if (magnitude > 0) {
					illionRepresentation += suffix + tenSuffix;
				}
	
					if (magnitude > 1) illionRepresentation += "llion";
	
				return compactValue + (magnitude == 0 ? "" : " ") + (magnitude == 1 ? 'thousand' : illionRepresentation);
			}
		}
	
		public static function getMinAndMax(value1:Float, value2:Float):Array<Float>
		{
			var minAndMaxs = new Array<Float>();
	
			var min = Math.min(value1, value2);
			var max = Math.max(value1, value2);
	
			minAndMaxs.push(min);
			minAndMaxs.push(max);
			
			return minAndMaxs;
		}

	inline public static function dominantColor(sprite:flixel.FlxSprite):Int
	{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth) {
			for(row in 0...sprite.frameHeight) {
				var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
				if(colorOfThisPixel != 0) {
					if(countByColor.exists(colorOfThisPixel))
						countByColor[colorOfThisPixel] = countByColor[colorOfThisPixel] + 1;
					else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687))
						countByColor[colorOfThisPixel] = 1;
				}
			}
		}

		var maxCount = 0;
		var maxKey:Int = 0; //after the loop this will store the max color
		countByColor[FlxColor.BLACK] = 0;
		for(key in countByColor.keys()) {
			if(countByColor[key] >= maxCount) {
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		countByColor = [];
		return maxKey;
	}

	inline public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max) dumbArray.push(i);

		return dumbArray;
	}

	inline public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static function getNoteAmount(song:SwagSong, ?bothSides:Bool = true, ?oppNotes:Bool = false):Int {
		var total:Int = 0;
		for (section in song.notes) {
			if (bothSides) total += section.sectionNotes.length;
			else
			{
				for (songNotes in section.sectionNotes)
				{
					if (!oppNotes && (songNotes[1] < 4 ? section.mustHitSection : !section.mustHitSection)) total += 1;
					if (oppNotes && (songNotes[1] < 4 ? !section.mustHitSection : section.mustHitSection)) total += 1;
				}
			}
		}
		return total;
	}

	inline public static function openFolder(folder:String, absolute:Bool = false) {
		#if sys
			if(!absolute) folder =  Sys.getCwd() + '$folder';

			folder = folder.replace('/', '\\');
			if(folder.endsWith('/')) folder.substr(0, folder.length - 1);

			#if linux
			var command:String = '/usr/bin/xdg-open';
			#else
			var command:String = 'explorer.exe';
			#end
			Sys.command(command, [folder]);
			trace('$command $folder');
		#else
			FlxG.error("Platform is not supported for CoolUtil.openFolder");
		#end
	}

	/**
		Helper Function to Fix Save Files for Flixel 5

		-- EDIT: [November 29, 2023] --

		this function is used to get the save path, period.
		since newer flixel versions are being enforced anyways.
		@crowplexus
	**/
	@:access(flixel.util.FlxSave.validate)
	inline public static function getSavePath():String {
		final company:String = FlxG.stage.application.meta.get('company');
		// #if (flixel < "5.0.0") return company; #else
		return '${company}/${flixel.util.FlxSave.validate(FlxG.stage.application.meta.get('file'))}';
		// #end
	}

	
	/*
	 * List of formatting for different byte amounts
	 * in an array formatted like this:
	 * 
	 * [`Format`, `Divisor`]
	 */
	 public static var byte_formats:Array<Array<Dynamic>> = [
		["$bytes B", 1.0],
		["$bytes KB", 1024.0],
		["$bytes MB", 1048576.0],
		["$bytes GB", 1073741824.0],
		["$bytes TB", 1099511627776.0],
		["$bytes PB", 1125899906842624.0],
		["$bytes EB", 1152921504606846976.0]
	];

	/**
	 * Formats `bytes` into a `String`.
	 * 
	 * Examples (Input = Output)
	 * 
	 * ```
	 * 1024 = '1 kb'
	 * 1536 = '1.5 kb'
	 * 1048576 = '2 mb'
	 * ```
	 * 
	 * @param bytes Amount of bytes to format and return.
	 * @param onlyValue (Optional, Default = `false`) Whether or not to only format the value of bytes (ex: `'1.5 mb' -> '1.5'`).
	 * @param precision (Optional, Default = `2`) The precision of the decimal value of bytes. (ex: `1 -> 1.5, 2 -> 1.53, etc`).
	 * @return Formatted byte string.
	 */
	public static function formatBytes(bytes:Float, onlyValue:Bool = false, precision:Int = 2):String {
		var formatted_bytes:String = "?";

		for (i in 0...byte_formats.length) {
			// If the next byte format has a divisor smaller than the current amount of bytes,
			// and thus not the right format skip it.
			if (byte_formats.length > i + 1 && byte_formats[i + 1][1] < bytes)
				continue;

			var format:Array<Dynamic> = byte_formats[i];

			if (!onlyValue)
				formatted_bytes = StringTools.replace(format[0], "$bytes", Std.string(FlxMath.roundDecimal(bytes / format[1], precision)));
			else
				formatted_bytes = Std.string(FlxMath.roundDecimal(bytes / format[1], precision));

			break;
		}

		return formatted_bytes;
	}


	public static function setTextBorderFromString(text:FlxText, border:String)
	{
		switch(border.toLowerCase().trim())
		{
			case 'shadow':
				text.borderStyle = SHADOW;
			case 'outline':
				text.borderStyle = OUTLINE;
			case 'outline_fast', 'outlinefast':
				text.borderStyle = OUTLINE_FAST;
			default:
				text.borderStyle = NONE;
		}
	}
}
