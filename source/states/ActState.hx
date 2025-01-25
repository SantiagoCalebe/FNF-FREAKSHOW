package states;

import backend.WeekData;
import backend.Highscore;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import backend.Song;

class ActState extends MusicBeatState {

    var checker:FlxBackdrop;
    var nmitext:FlxText;
    var difficultynmi:FlxText;
    var nmi:FlxSprite;

    override function create() {

        FlxG.camera.zoom = 150;
        FlxTween.tween(FlxG.camera, { zoom: 1 }, 1, { type: FlxTween.ONESHOT, onComplete: cast onFirstTweenComplete });

        checker = new FlxBackdrop(Paths.image('grid/Grid_lmao'));
        //checker.velocity.set(112, 110);
        checker.updateHitbox();
        checker.scrollFactor.set(0, 0);
        checker.alpha = 0.2;
        checker.screenCenter(X);
        add(checker);

        // NO MORE INNOCENCE
        nmitext = new FlxText();
        nmitext.text = "Bad Habits";
        nmitext.scrollFactor.set();
        nmitext.color = FlxColor.WHITE; 
        nmitext.size = 64;
        nmitext.screenCenter();
        nmitext.x -= 200;
        nmitext.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, "center");
        add(nmitext);

        nmi = new FlxSprite().loadGraphic(Paths.image('freakyimages/nmi'));
        nmi.screenCenter();
        // nmi.y -= 200;
        nmi.x += 250;
        add(nmi);

        var ving = new FlxSprite().loadGraphic(Paths.image('ving2'));
        ving.updateHitbox();
        ving.screenCenter();
        add(ving);

        /*
        difficultynmi = new FlxText();
        difficultynmi.text = "Difficulty: ★★★";
        difficultynmi.scrollFactor.set();
        difficultynmi.color = FlxColor.WHITE; 
        difficultynmi.size = 64;
		difficultynmi.screenCenter();
        difficultynmi.x += 350;
        difficultynmi.y += 300;
        //difficultynmi.x += 150;
        difficultynmi.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, "center");
        add(difficultynmi);
        */
    }
        
    override function update(elapsed:Float) {
        super.update(elapsed);

        checker.x += .5 * (elapsed / (1 / 120)); 
		checker.y -= 0.16;

        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MainMenuState());
        }

        if (FlxG.mouse.overlaps(nmitext)) {
            nmitext.color = 0x230606;
        } else {
            nmitext.color = 0xFFFFFF;
        }

        if (FlxG.mouse.overlaps(nmitext) && FlxG.mouse.justPressed) {
			FlxG.sound.play(Paths.sound('confirmMenu'));
            FlxTween.tween(FlxG.camera, { zoom: 50 }, 1, { type: FlxTween.ONESHOT, onComplete: cast onZoomComplete });
		}
    }

    private function onFirstTweenComplete():Void {
        // I have nothing to do after this so fuck it
    }

    private function onZoomComplete():Void {
        FlxG.camera.fade(FlxColor.BLACK);
		trace("Zoom completed!");      
		PlayState.SONG = Song.loadFromJson('bad-habits-hard', 'bad-habits');
		LoadingState.loadAndSwitchState(new PlayState());
    }
}
