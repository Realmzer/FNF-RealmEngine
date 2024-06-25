package states.editors;

import backend.Controls;

import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIInputText;
import haxe.io.Bytes;

import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import openfl.Lib;
import sys.io.File;
import sys.FileSystem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;

class TextEditorState extends MusicBeatState
{
   // For Typing
    public var toConvert:Array<Array<String>> = [
        ['ONE', '1'], ['TWO', '2'], ['THREE', '3'], ['FOUR', '4'], ['FIVE', '5'], ['SIX', '6'], ['SEVEN', '7'], ['EIGHT', '8'], ['NINE', '9'], ['ZERO', '0'],
        ['MINUS', '-'], ['PLUS', '+'], ['SLASH', '/'], ['SEMICOLON', ';'], ['COMMA', ','], ['PERIOD', '.'], ['NUMPADONE', '1'], ['NUMPADTWO', '2'], ['NUMPADTHREE', '3'], ['NUMPADFOUR', '4'], ['NUMPADFIVE', '5'], 
        ['NUMPADSIX', '6'], ['NUMPADSEVEN', '7'], ['NUMPADEIGHT', '8'], ['NUMPADNINE', '9'], ['NUMPADZERO', '0'], ['NUMPADMULTIPLY', '*'], ['NUMPADMINUS', '-'], ['NUMPADPLUS', '+'], ['QUOTE', "'"], ['NUMPADPERIOD', '.']
    ];
}